$fn=40;

length=132;

offset = (length - 113)/2;

module assembly() {
    color("grey") union() {
        cylinder(d=3.5,h=length);
        translate([0,0,offset]) cylinder(d=11,h=113);
    }
}

module holder() {
    smoothness = 1;
    translate([smoothness-6,-6,smoothness]) minkowski() {
        cube([12-smoothness*2 ,6,length-smoothness*2]); // middle
        rotate([90,0,0]) cylinder(r=smoothness, h=0.0001, center=true);
    }
    translate([smoothness-6,smoothness*2-3,smoothness]) minkowski() {
        cube([12-smoothness*2,3-smoothness*2,offset-smoothness*2]);
        sphere(r=smoothness);
    }
    translate([smoothness-6,smoothness*2-3,smoothness+length-offset]) minkowski() {
        cube([12-smoothness*2,3-smoothness*2,offset-smoothness*2]);
        sphere(r=smoothness);
    }
}

difference() {
    holder();
    assembly();
}

//holder();