$fn=120;

module cross_section() {
    translate([57,0,0]) difference() {
            circle(d=28);
            circle(d=24);
            square([20,20]);
            translate([0,-20]) square([20,20]);
    }
}


rotate_extrude(angle=180, $fn=180) cross_section();

rotate([90,0,0]) linear_extrude(height=50) cross_section();
rotate([-90,0,180]) linear_extrude(height=50) cross_section();