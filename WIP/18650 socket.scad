// $vpr = [90 - 30 + $t * 30, $t, $t * 45 + 45];
$fn=100;

offset=0.001;

batt_length = 65.68;
batt_dia= 18.3;
wall_thickness=2;
wire_thickness=1.67; // 14 AWG

module battery() {
    difference() {
        color("brown") cylinder(d=18.3,h=batt_length);
        translate([0,0,-offset]) cylinder(d=13.45,h=1);
        translate([0,0,65.68-1+offset]) cylinder(d=13.45,h=1);
    }
    color("silver") cylinder(d=13.45,h=1);
    translate([0,0,batt_length-1]) color("silver") cylinder(d=8.7,h=1);
    translate([0,0,batt_length-1-offset]) color("white") difference() {
        cylinder(d=13.45,h=1);
        cylinder(d=9.94,h=1.1);
    }
}
    
box_length = batt_length+wall_thickness*2+wire_thickness*2;
box_height = batt_dia*.6+wall_thickness;
box_width = batt_dia+wall_thickness*2;
module box() {
    translate([
        -box_width /2,
        -box_width/2,
        -wall_thickness-wire_thickness])
    difference() {
        cube([box_height, box_width, box_length]);
        translate([
            wall_thickness+offset/2,
            wall_thickness+offset/2,
            wall_thickness+offset/2]) cube([
                batt_dia+offset,
                batt_dia+offset,
                batt_length+wire_thickness*2+offset]);
        translate([-offset,box_width*1/6,wall_thickness*3])
            cube([wall_thickness+offset*2,box_width*2/3,box_length*3/8]);
        translate([-offset,box_width*1/6,
            box_length-wall_thickness*3-box_length*3/8])
            cube([wall_thickness+offset*2,box_width*2/3,box_length*3/8]);
        translate([-offset,-offset,-offset]) cube([box_height+offset*2, box_width+offset*2, wall_thickness+offset*2]);
    }
}
module boxEnd() {
    translate([
        -box_width /2,
        -box_width/2,
        -wall_thickness-wire_thickness])
    intersection() {
        cube([box_width, box_width, wall_thickness]);
        
        translate([
            box_height-wall_thickness,
            box_width/2,
            0])
        cylinder(d=batt_dia, h=wall_thickness);
    }
}
module boxEnds() {
//    boxEnd();
    translate([0,0,box_length-wall_thickness]) boxEnd();
}

module clamp() {
    clamp_length = batt_length*5/6;
    clamp_height = batt_dia*3/10;
    translate([
        0,
        -box_width/2,
        -wall_thickness-wire_thickness+
            (box_length-clamp_length)/2])
    difference() {
        cube([clamp_height, box_width, clamp_length]);
        translate([0, batt_dia/2+wall_thickness,0]) battery();
        translate([-50, -50,clamp_length/2-7]) cube([100,100,14]);
    }
}

module bend() {
    color("#a87732")
    translate([0,0,-3.83]) rotate([90,0,0])
    rotate_extrude(angle=90, $fn=70)
    translate([3.83-wire_thickness/2, 0, 0]) circle(d = wire_thickness, $fn=20);
}
module wire() {
    bend();
    color("#a87732")
        translate([0,0,-wire_thickness/2])
        rotate([0,-90,0]) cylinder(d = wire_thickness, h=20, $fn=20);
    color("#a87732")
        translate([3.83-wire_thickness/2,0,-wall_thickness-wire_thickness])
        rotate([180,0,0])
        cylinder(d = wire_thickness, h=3, $fn=20);
}
module wires() {
//    wire();
    translate([0,0,box_length-wire_thickness*2-wall_thickness*2]) rotate([180,0,0]) wire();
    
}


battery();
difference() {
    box();
    wires();
}
difference() {
    boxEnds();
    wires();
}
wires();
clamp();

module semicircle(h, r, d) {
    difference() {
        resize([0, r, 0]) cylinder(h=h,d=d);
        translate([0,0,-offset])
        resize([d-wall_thickness*2, r-wall_thickness*2, 0]) cylinder(h=h+offset*2,r=r/2-wall_thickness);
        translate([-d/2,-r,-offset/2])
            cube([d+offset*2,r+offset*2,h+offset*2]);
    }
}

end_height = batt_dia*.7+wall_thickness;
d1 = box_width*.47;
d2 = d1 /3 + wall_thickness*.7;
d3 = d2 *2;
module spring() {
    semicircle(end_height, d=d1, r=d1);
    translate([d2/2-d1/2,0,0])
        rotate([0,0,180]) semicircle(end_height, d=d2, r=d2);
    translate([d2*1.5-d1/2-wall_thickness,0,0])
        semicircle(end_height, d=d2, r=d2);
    translate([-wall_thickness-d3/2-d1/2+d2*2,0,0])
        rotate([0,0,180]) difference() {
            semicircle(end_height, r=d3, d=d3);
            translate([0,0,-offset]) cube([d3,d3,end_height+offset*2]);
        }
    edge=(d1/2+(box_width/2-d1)/2)-(-d2/2+wall_thickness+d3/2-wall_thickness);
    fudge=.35;
    translate([
        fudge+wall_thickness+edge-d3/2-(d2-wall_thickness),
        -d3/2+wall_thickness,
        0])
        rotate([0,0,180]) cube([edge+fudge,wall_thickness,end_height]);
}
module align_spring() {
    translate([batt_dia*.1+wall_thickness,0,0])
    rotate([270,0,0]) rotate([0,270,0]) children();
}
module spring_end() {
    translate([0,d1/2+(box_width/2-d1)/2,-d3/2-wire_thickness/2]) {
        align_spring() spring();
        translate([0,-box_width/2,0]) mirror([0,1,0]) align_spring() spring();
    }
}
spring_end();