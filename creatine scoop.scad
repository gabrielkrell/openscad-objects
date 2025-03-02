// four gram creatine scoop
// 0.25 cups / 46.91 grams  * 4 grams ==  5040 mm^3
// this is just about 1 teaspoon but whatever

$fn=360;

volume = 5040;
w=20;
h=volume / (PI * pow(w/2,2));
_=0.01;

wall_thickness=1.5;

module inside() {
    cylinder(d=w, h=h);
}


module outside() {
    difference() {
        cylinder(d=w+2*wall_thickness, h=h+wall_thickness);
        translate([0,0,wall_thickness+_]) inside();
    }
}

outside();

module handle() {
//    translate([-w/3,0,0]) cube([w*2/3,w*4,wall_thickness*2]);
    width=w*2/3;
    hull() {
        cylinder(d=width, h=wall_thickness);
        translate([0,w*4,0]) cylinder(d=width, h=wall_thickness);
    }
    difference() {
        hull() {
            cylinder(d=width, h=wall_thickness);
            translate([0,0,h/2]) cylinder(d=width, h=wall_thickness);
            translate([0,w,0]) cylinder(d=width, h=wall_thickness);
        }
        inside();
    }
}
handle();