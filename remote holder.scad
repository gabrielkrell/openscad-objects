$fn=120;

module arrange(r_,w,h) {
    hull() {
        translate([r_  ,0,  r_]) rotate([90]) children();
        translate([w-r_,0,  r_]) rotate([90])  

module remote() {
    // front bit
    translate([-1,8,3])
    arrange(r_=12,w=49,h=204)
        resize([22,30,8]) cylinder(r2=11, r1=12,h=8);
    
    // curve outward
    translate([-1,0,3])
    arrange(r_=12,w=49,h=204)
        resize([22*11/12,30*11/12,3])
        sphere(r=11);
    

    // rounded back
    intersection() {
        translate([0,8,(30-22)/2])
            arrange(r_=11,w=47,h=210-(30-22)) resize([22,30,22]) sphere(11);
        translate([0,8,0]) cube([47,11,210]);
    }

    //keypad
    translate([(47-35)/2,-0,23]) // keypad
        rounded_rect(r_=5,w=35,d=30,h=210-23-7); // d=2.5
}

module bracket() {
    translate([-30,15,-7]) //color("grey", alpha=.2)
    union() {
        rounded_rect(r_=5,d=25,h=60,w=60);
        translate([0,-25,0]) arrange(r_=5,h=60,w=60) sphere(5);
    }
}

difference() {
    bracket();
    
    translate([-47/2,-19/2,0]) // center
    remote();
}


//    translate([-47/2,-25,0]) // center
//    remote();