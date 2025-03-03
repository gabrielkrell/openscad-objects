// PEGSTR - Pegboard Wizard
// Design by Marius Gheorghescu, November 2014
// Modified by Gabriel Krell, Feb 2025
// Update log:
// November 9th 2014
//		- first coomplete version. Angled holders are often odd/incorrect.
// November 15th 2014
//		- minor tweaks to increase rendering speed. added logo. 
// November 28th 2014
//		- bug fixes
// February 19th 2025
//      - added keyed slots, so the hooks and holder can both be printed
//        in strong orientations without support
//      - separated x and y tapering
//      - increased $fn number. use a dev version (I'm on nightly) so this
//        renders faster, or lower it.
//      - note: I still haven't fixed the sharp corner between
//        the peg and the hook
//      - TODO: improve key? make it symmetrical again?


$fn = 160;

// width of the orifice
holder_x_size = 1;

// depth of the orifice
holder_y_size = 10;

// hight of the holder
holder_height = 15;

// how thick are the walls. Hint: 6*extrusion width produces the best results.
wall_thickness = 1.85;

// how many times to repeat the holder on X axis
holder_x_count = 1;
// additional spacing between the holes, for instance for large handles
holder_x_spacing = (34-7);

// how many times to repeat the holder on Y axis
holder_y_count = 1;

// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
corner_radius = 0;//(23-17)/2/2;

// Use values less than 1.0 to make the bottom of the holder narrow
x_taper_ratio = 1; // taper ratio for the width
y_taper_ratio = x_taper_ratio; // taper ratio for the depth

radius_taper_ratio = min(x_taper_ratio, y_taper_ratio);

// mm to cut off from the peg rows. higher values = looser fit
peg_tolerance = .4;

// mm cut off from corner of flat side, in case of poor rounding or elephant's foot
chamfer_tolerance = .15;

// pct to undersize the pegs
peg_undersize_ratio = .9;


/* [Advanced] */

// offset from the peg board, typically 0 unless you have an object that needs clearance
holder_offset = 0; // (34-7)/2;

// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
strength_factor = 0.5;

// for bins: what ratio of wall thickness to use for closing the bottom
closed_bottom = 0.0;

// what percentage cu cut in the front (example to slip in a cable or make the tool snap from the side)
holder_cutout_side = 0.6;

// set an angle for the holder to prevent object from sliding or to view it better from the top
holder_angle = 0;


/* [Hidden] */

// dimensions the same outside US?
hole_spacing = 25.4;
hole_size = 6.35; // 1/4"
board_thickness = 4; // .155"


holder_total_x = wall_thickness + holder_x_count*(wall_thickness+holder_x_size) + (holder_x_count-1)*holder_x_spacing;
holder_total_y = wall_thickness + holder_y_count*(wall_thickness+holder_y_size);
holder_total_z = round(holder_height/hole_spacing)*hole_spacing;
holder_roundness = min(corner_radius, holder_x_size/2, holder_y_size/2); 



epsilon = 0.1;

clip_height = 2*hole_size + 2;

/**
 a rounded-off rectangular extrusion
*/
module round_rect_ex(x1, y1, x2, y2, z, r1, r2) {
	brim = z/10;

	hull() {
        translate([-x1/2 + r1, y1/2 - r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([x1/2 - r1, y1/2 - r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([-x1/2 + r1, -y1/2 + r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([x1/2 - r1, -y1/2 + r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);

        translate([-x2/2 + r2, y2/2 - r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([x2/2 - r2, y2/2 - r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([-x2/2 + r2, -y2/2 + r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([x2/2 - r2, -y2/2 + r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);

    }
}

module pin(clip, board_thickness=board_thickness) {
    full_hole_size = hole_size;
    hole_size = hole_size*peg_undersize_ratio;
    curve_size = hole_size * .95;
	if (clip) {
        cylinder(
            d1=hole_size,
            d2=curve_size,
            h=wall_thickness+board_thickness+epsilon,
            center=true
            );
		
        rotate([0,0,90])
		intersection() {
			translate([0, 0, wall_thickness*2+board_thickness+epsilon*2+.75])
				cube([hole_size+2*epsilon, clip_height, 2*hole_size], center=true);

			// [-hole_size/2 - 1.95,0, board_thickness/2]
			translate([0, full_hole_size/2 + 1.82, board_thickness/2+.85]) 
				rotate([0, 90, 0])
				rotate_extrude(convexity = 5, angle=270)
				translate([5, 0, 0])
				 circle(d = curve_size); 
			
			translate([0, hole_size/2 + 2 - 1.6, board_thickness/2]) 
				rotate([45,0,0])
				translate([0, -0, hole_size*0.6])
					cube([hole_size+2*epsilon, 3*hole_size, hole_size], center=true);
		}
	} else {
        cylinder(d=hole_size, h=wall_thickness+board_thickness+epsilon, center=true);
    }
}

module pinboard_clips() {
	rotate([0,90,0])
	for(i=[0:round(holder_total_x/hole_spacing)]) {
		for(j=[0:max(strength_factor, round(holder_height/hole_spacing))]) {

			translate([
				j*hole_spacing, 
				-hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing, 
				board_thickness*0.25])
					pin(j==0);
		}
        
        hull() {
            for(j=[0:max(strength_factor, round(holder_height/hole_spacing))]) {
                translate([
                    j*hole_spacing, 
                    -hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing, 
                    -board_thickness/2]
                ) rotate([0,0,0*15])
                    squished_cylinder(
                        d1=hole_size*4/3,
                        d2=hole_size,
                        h=wall_thickness+epsilon,
                        left=
                    (-hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing) < 0);
            }
        }
	}
}

module pinboard_column(left=false, board_thickness=board_thickness) {
    difference() {
        intersection() {
        
            // intersect with this cube to cut the side flat by a little
            rotate([0,90,0])
                translate([
                    -hole_size-board_thickness,
                    0-hole_size/2 + (left ? peg_tolerance : -hole_size*1/3-peg_tolerance),
                    -wall_thickness-epsilon
                ]) cube([
                    max(strength_factor, round(holder_height/hole_spacing))*hole_spacing+hole_size*2+board_thickness,
                    hole_size*4/3,
                    wall_thickness+board_thickness+hole_size
                    // this is not right, needs to accomodate the 5?mm from rotate extrude
                ]);
                
            // the actual pin column
            rotate([0,90,0]) {
                for(j=[0:max(strength_factor, round(holder_height/hole_spacing))]) {
                    translate([
                        j*hole_spacing, 
                        0, 
                        board_thickness*0.25
                    ]) pin(j==0, board_thickness);
                }
                
                hull() {
                    for(j=[0:max(strength_factor, round(holder_height/hole_spacing))]) {
                        translate([
                            j*hole_spacing, 
                            0, 
                            -wall_thickness-epsilon
                        ])
                        rotate([0,0,0*15])
                        squished_cylinder(
                            d1=hole_size*4/3, d2=hole_size,
                            h=wall_thickness+epsilon,
                            left=left
                        );
                    }
                }
            }
        }
        
        // finally, chamfer the flat edge a little in case
        // of elephant's foot or poor inner corner radius on the holder
        rotate([0,90,0])
        translate([
                (left ? -hole_size-board_thickness : 0),
                (left ? 1 : -1) * (peg_tolerance-hole_size/2),
                -wall_thickness
            ])
        rotate([(left ? 180+45 : -45),0,0])
        translate([
            (left ? 0 : -hole_size-board_thickness),
            -chamfer_tolerance,
            -board_thickness*3/2
        ])
        cube([
            max(strength_factor, round(holder_height/hole_spacing))*hole_spacing+hole_size*2+board_thickness,
            hole_size*4/3,
            board_thickness*3
        ]);
    }
}

module pinboard(thickness=wall_thickness, cutouts=false) {
	rotate([0,90,0])
	translate([-epsilon, 0, -wall_thickness - board_thickness/2 + epsilon])
	difference() {
        // modify the initial pinboard to have extra width to accomodate pegs
        // let's use the pin radius for it (hole_size/2)
        hull() {
            translate([-clip_height/2 + hole_size/2, 
                -hole_spacing*(round(holder_total_x/hole_spacing)/2)-hole_size/2,
                0])
                cylinder(r=hole_size/2, h=thickness);

            translate([-clip_height/2 + hole_size/2, 
                hole_spacing*(round(holder_total_x/hole_spacing)/2)+hole_size/2,0])
                cylinder(r=hole_size/2,  h=thickness);

            translate([max(strength_factor, round(holder_height/hole_spacing))*hole_spacing+hole_size/2,
                -hole_spacing*(round(holder_total_x/hole_spacing)/2)-hole_size/2,0])
                cylinder(r=hole_size/2, h=thickness);

            translate([max(strength_factor, round(holder_height/hole_spacing))*hole_spacing+hole_size/2,
                hole_spacing*(round(holder_total_x/hole_spacing)/2)+hole_size/2,0])
                cylinder(r=hole_size/2,  h=thickness);
        }
        
        if(cutouts) { // cut slots for pin pairs (top + bottom)
        
        for(i=[0:round(holder_total_x/hole_spacing)]) {
            hull() { translate([
                0, // -clip_height/2 + hole_size/2, 
                -hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing,
                thickness/2
                ])
                squished_cylinder(d1=hole_size*4/3, d2=hole_size, h=thickness/2+epsilon, left=(-hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing) < 0);

            translate([
                max(strength_factor, round(holder_height/hole_spacing))*hole_spacing+hole_spacing,
                -hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing,
                thickness/2
                ])
                squished_cylinder(d1=hole_size*4/3, d2=hole_size, h=thickness/2+epsilon, left=(-hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing) < 0);
            }
            }
        }
    }
}

module holder(negative) {
	for(x=[1:holder_x_count]){
		for(y=[1:holder_y_count]) 
/*		render(convexity=2)*/ {
			translate([
				-holder_total_y /*- (holder_y_size+wall_thickness)/2*/ + y*(holder_y_size+wall_thickness) + wall_thickness,

				-holder_total_x/2 + (holder_x_size+wall_thickness)/2 + (x-1)*(holder_x_size+wall_thickness+holder_x_spacing) + wall_thickness/2,
				 0])			
	{
		rotate([0, holder_angle, 0])
		translate([
			-wall_thickness*abs(sin(holder_angle))-0*abs((holder_y_size/2)*sin(holder_angle))-holder_offset-(holder_y_size + 2*wall_thickness)/2 - board_thickness/2,
			0,
			-(holder_height/2)*sin(holder_angle) - holder_height/2 + clip_height/2
		])
		difference() {
			if (!negative)

				round_rect_ex(
					(holder_y_size + 2*wall_thickness), 
					holder_x_size + 2*wall_thickness, 
					(holder_y_size + 2*wall_thickness)*y_taper_ratio, 
					(holder_x_size + 2*wall_thickness)*x_taper_ratio, 
					holder_height, 
					holder_roundness + epsilon, 
					holder_roundness*radius_taper_ratio + epsilon);

				translate([0,0,closed_bottom*wall_thickness])

				if (negative>1) {
					round_rect_ex(
						holder_y_size*y_taper_ratio, 
						holder_x_size*x_taper_ratio, 
						holder_y_size*y_taper_ratio, 
						holder_x_size*x_taper_ratio, 
						3*max(holder_height, hole_spacing),
						holder_roundness*radius_taper_ratio + epsilon, 
						holder_roundness*radius_taper_ratio + epsilon);
				} else {
					round_rect_ex(
						holder_y_size, 
						holder_x_size, 
						holder_y_size*y_taper_ratio, 
						holder_x_size*x_taper_ratio, 
						holder_height+2*epsilon,
						holder_roundness + epsilon, 
						holder_roundness*radius_taper_ratio + epsilon);
				}

			if (!negative)
				if (holder_cutout_side > 0) {

				if (negative>1) {
					hull() {
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size*y_taper_ratio, 
							holder_x_size*x_taper_ratio, 
							holder_y_size*y_taper_ratio, 
							holder_x_size*x_taper_ratio, 
							3*max(holder_height, hole_spacing),
							holder_roundness*radius_taper_ratio + epsilon, 
							holder_roundness*radius_taper_ratio + epsilon);
		
						translate([0-(holder_y_size + 2*wall_thickness), 0,0])
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size*y_taper_ratio, 
							holder_x_size*x_taper_ratio, 
							holder_y_size*y_taper_ratio, 
							holder_x_size*x_taper_ratio, 
							3*max(holder_height, hole_spacing),
							holder_roundness*radius_taper_ratio + epsilon, 
							holder_roundness*radius_taper_ratio + epsilon);
					}
				} else {
					hull() {
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size, 
							holder_x_size, 
							holder_y_size*y_taper_ratio, 
							holder_x_size*x_taper_ratio, 
							holder_height+2*epsilon,
							holder_roundness + epsilon, 
							holder_roundness*radius_taper_ratio + epsilon);
		
						translate([0-(holder_y_size + 2*wall_thickness), 0,0])
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size, 
							holder_x_size, 
							holder_y_size*y_taper_ratio, 
							holder_x_size*x_taper_ratio, 
							holder_height+2*epsilon,
							holder_roundness + epsilon, 
							holder_roundness*radius_taper_ratio + epsilon);
						}
					}

				}
			}
		} // positioning
	} // for y
	} // for X
}


module pegstr() {
	difference() {
		union() {

			pinboard(thickness=wall_thickness*2, cutouts=true);


			difference() {
				hull() {
					pinboard();
	
					intersection() {
						translate([-holder_offset - (strength_factor-0.5)*holder_total_y - wall_thickness/4,0,0])
						cube([
							holder_total_y + 2*wall_thickness, 
							holder_total_x + wall_thickness, 
							2*holder_height
						], center=true);
	
						holder(0);
	
					}
				}

				if (closed_bottom*wall_thickness < epsilon) {
						holder(2);
				}

			}

			color([0.7,0,0]) difference() {
				holder(0);
				holder(2);
			}

//			color([1,0,0]) pinboard_clips();
		}
	
		holder(1);

	}
}

//translate([0,0,-clip_height/2-epsilon])
//pegstr();

//for (i = [0:1]) {
//translate([hole_size/2+5+20*0,-clip_height+hole_size/2,-hole_size/2+peg_tolerance]) rotate([-90,0,0])
pinboard_column(left=false);
//translate([hole_size/2+5+20*i,-hole_size/2+clip_height,-hole_size/2+peg_tolerance]) rotate([90,0,0]) pinboard_column(left=true);
//}


// for cutouts. squished cylinder centered on d2 (the higher face)
// with either the left or right edge straight and the other one
// out at an angle
//
// previously this was to the left or right, but the flat face made keying
// difficult. adjust to be slightly inward
module squished_cylinder(h, d1, d2, left=false) {
    e=0.01;
    hull() {
        translate([0,(left ? 1 : -1) * (d1-d2)/2,0])
            cylinder(d=d1, h=e);
        translate([0,0,h-e]) cylinder(d=d2, h=e*2);
    }
}
