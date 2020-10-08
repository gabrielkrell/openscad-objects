use <text_on/text_on.scad>

small_size_1 = 6.35;
small_size_1_label = "1/4";
small_size_2 = 7.14375;
small_size_2_label = "9/32";
large_size_1 = 7.9375;
large_size_1_label = "5/16";
large_size_2 = 8.73125;
large_size_2_label = "11/32";

key_length = 35;

fragments = 100; // default is 30, cylinder slices

module keyhole(size) {
    translate([0,0,key_length-size+0.001])
        rotate(45)
        cube([size, size, size*2], center=true);
    // chamfer edge with magic numbers and square pyramid
    translate([0,0,key_length-size+0.001+1])
        cylinder(h=size+1,r1=0,r2=size+1,$fn=4);
}

module key(size) {
    translate([0,0,key_length-2*size])
        cylinder(r=size, h=2*size, $fn=fragments);
}

module shank(size, label) {
    shank_length = key_length-2*size;
    cylinder(r=size, h=shank_length, $fn=fragments);
    
    translate([0,0,shank_length*1.4])
    rotate(180, v=[1,0,0]) {
    text_on_cylinder(
            t=label,
            r1=size,
            r2=size,
            h=key_length-2*size,
            size=4,
            updown=0,
            valign="top");
    rotate(180) text_on_cylinder(
            t=label,
            r1=size,
            r2=size,
            h=key_length-2*size,
            size=4,
            updown=0,
            valign="top");
    }
}
   

module end(size) {
    difference() {
        key(size);
        keyhole(size);
    }
}

rotate(000, v=[0,1,0]) union() {
	end(small_size_1);
	shank(small_size_1, small_size_1_label);
}
rotate(090, v=[0,1,0]) union() {
	end(large_size_1);
	shank(large_size_1, large_size_1_label);
}
rotate(180, v=[0,1,0]) union() {
	end(small_size_2);
	shank(small_size_1, small_size_2_label);
}
rotate(270, v=[0,1,0]) union() {
	end(large_size_2);
	shank(large_size_1, large_size_2_label);
}

