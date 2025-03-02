roll_h=230; // 230 real
roll_d=100;

plate_w = roll_d*3/4;
slot_w = 10;
cap_h=5;
cap_nest=10;

module trash_bags(bag_only=false) {
    color("white") cylinder(d=roll_d, h=roll_h);
    if(!bag_only) {
        translate([0,0,roll_h-e]) cylinder(d=roll_d, h=cap_nest+e*2);
        }
}

wall = 4;
e = 0.01;
$fn=240;

module holder(slot=true) {
    total_h=roll_h+cap_nest+wall;
    difference() {
        hull() {
            translate([0,0,-wall]) cylinder(d=roll_d+wall*2, h=total_h);
            translate([-roll_d/2-wall,-plate_w/2,-wall])
                cube([wall,plate_w,total_h]);
        }

        trash_bags();

        // cut off top
//        translate([0,0,roll_h+cap_nest-e]) cylinder(d=roll_d, h=cap_h+cap_nest);

        // center hole
        translate([0,0,-wall-e]) cylinder(d=4, h=total_h+e*2);

        if(slot) {
            translate([0,-slot_w/2,e]) cube([roll_d/2+wall,slot_w,total_h+e]);
        }
    }
}

module cap() {
    difference() {
        union() {
            chamfer = 1;
            translate([0,0,roll_h]) cylinder(
                d1=(roll_d-e)-chamfer, // slide a little
                d2=roll_d-e,
                h=chamfer
            );
            translate([0,0,roll_h+chamfer]) cylinder(
                d=roll_d-e,
                h=cap_nest-chamfer
            );
            hull() {
                translate([0,0,roll_h+cap_nest])
                    cylinder(d=roll_d+wall*2-e, h=cap_h);
                translate([-roll_d/2-wall+e,-plate_w/2,roll_h+cap_nest])
                    cube([wall,plate_w,cap_h]);
            }
        }
        
        
        translate([0,0,roll_h-e]) cylinder(d=roll_d-wall*2, h=cap_nest-wall);
        
//        holder(slot=false);
        
        // center hole
        translate([0,0,-wall-e]) cylinder(d=4, h=roll_h+cap_h+cap_nest+wall*2+e*2);
    }
}

translate([0,0,wall]) holder();

translate([0,0,$t<.5 ? $t*40 : 40-$t*40])
//translate([0,0,0]) rotate([180,0,0]) translate([0,0,-roll_h-cap_nest-cap_h])
    cap();
//trash_bags(true);