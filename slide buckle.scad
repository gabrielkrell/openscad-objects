$fn=60;


height = 9;
width = height / 2;
round_r = 1;
spike_r = .5;
buckle_thickness=1;

module arrange(x,y) {
    translate([0,0,0]) children();
    translate([x,0,0]) children();
    translate([0,y,0]) children();
    translate([x,y,0]) children();
}

module rect(x,y,round_r) {
    hull() {
        arrange(x,y) circle(r=round_r);
    }
}

module base() {
    difference() {
        rect(width, height, round_r);
        translate([buckle_thickness, buckle_thickness, 0])
          rect(width-buckle_thickness*2, height-buckle_thickness*2, round_r);
    }
}

module center() {
    translate([width/2 - buckle_thickness/2,0,0])
    square(size=[buckle_thickness, height]);
}

module spikes() {
    inc = 2*spike_r*sin(60);
    for (y = [height - round_r : -inc : round_r]) {
        translate([spike_r/2,y,0])
            circle(r=spike_r, $fn=3);
    }
}

linear_extrude(height=buckle_thickness) {
    base();
    center();
    spikes();
    translate([width,0,0]) mirror([1,0,0]) spikes();
}