hole_width=6.0035;
pegboard_thickness=5;
$fn=60;

module end(length,thickness=1,cap=0) {
    c_h = length - hole_width/2 - cap * hole_width/2;
    translate([0,0,hole_width/2]) {
        cylinder(d=hole_width*thickness,h=c_h );
        translate([0,0,-hole_width/2]) cylinder(d1=0,d2=hole_width*thickness,h=hole_width/2);
    }
}
module back() {    
    side_thickness=.25;
    prong_length = hole_width*2;
    translate([0,0,-prong_length-pegboard_thickness]) {
        end(prong_length+pegboard_thickness, 1, 0);
    }
}

piece_thickness=3;
screw_head_max=9.3;
shaft=4;

module cap() {
    cylinder(d=shaft,h=piece_thickness*1.5);
    translate([0,0,piece_thickness*1.5]) cylinder(d=screw_head_max-1,h=piece_thickness-1);
}


module pegboard() {
    difference() {
        translate([-100,-100,-pegboard_thickness]) color("brown", .5) cube([200,200,pegboard_thickness]);
//        translate([0,0,-100]) cylinder(d=hole_width,h=200);
        for (x = [-25.4 * 5: 25.4 : 200]) {
            for (y = [-25.4 * 5: 25.4 : 200]) {
                translate([x,y,-100]) cylinder(d=hole_width,h=200);
            }
        }
                
    }
}


//back();
difference() {
    cap();
    translate([-5,1.9,0]) cube([10,10,10]);
}
//pegboard();
//
translate([25.4/2,pegboard_thickness*0.75/2,0]) rotate([90,0,0])
difference() {
    cylinder(d=25.4 + hole_width * 0.75, h=pegboard_thickness*0.75);
    translate([0,0,-1]) cylinder(d=(25.4 + hole_width * 0.75) * 0.8, h=pegboard_thickness*0.75 + 2);
    translate([-100,-0, -100]) cube([200,200,200]);
}

translate([25.4*1.5 + 1.5,-pegboard_thickness*0.75/2 ,0]) rotate([-90,0,0])
difference() {
    cylinder(d=25.4 + hole_width * 0.75, h=pegboard_thickness*0.75);
    translate([0,0,-1]) cylinder(d=(25.4 + hole_width * 0.75) * 0.8, h=pegboard_thickness*0.75 + 2);
    translate([-100,-0, -100]) cube([200,200,200]);
    translate([-12,-100, -100]) cube([200,200,200]);
}

