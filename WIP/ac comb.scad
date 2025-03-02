// TO DO: round the edges of the comb so that it's easier to slot into the a/c.


fpi = 24; // fins per inch
fin_spacing = 1/fpi * 2.54 * 10; // fin spacing in mm

fin_width = 0.2; // width of sheet metal (in practice, printer min width

module tooth () {
    difference() {    
        cube([fin_spacing - fin_width, 20, 10]); 
        translate([fin_spacing - fin_width + 0.01,0,0])
            rotate([45,0,0])
            rotate([0,-90,0])
            cube([20, 20, fin_spacing - fin_width + 0.02]);
    }
}

tooth();

for(offset = [0 : fin_spacing : 10]) {
    translate([offset,0,0]) tooth();
}

translate([0,20,0]) cube([10*fin_spacing - fin_width,30,10]);