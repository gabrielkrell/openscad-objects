$fn=120;

h=1.8;
height=5;
    
translate([0,0,1+h-height])
difference() {
translate([-68/2,-38/2,0]) cube([68,48,5]);
    union() {
        translate([0,0,height-1-.01]) cylinder(d=41.92,h=6);
        translate([0,0,height-1-h+.01]) cylinder(d=35.75,h=5);
        translate([0,0,height-1-h+.001]) cylinder(d1=35.75,d2=41.92,h=h);
    }
}

translate([-68/2,-38/2,10.4]) cube([68,38,5]);
translate([-68/2,-38/2,0]) cube([4.5,48,15]);