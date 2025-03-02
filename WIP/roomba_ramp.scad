sunroom_height = 60;
bathroom_height = 75;

target = sunroom_height;
width_to_height = 1.7; // experimental, test me
length = 100;


width = target*width_to_height;
module step() {
    rotate([90,0,0])
    linear_extrude(length)
    polygon([[0,0],[width,0],[width,target]]);
}

// actually this will take too long to print. for prototyping, just use a piece of cardboard and some back supports

difference() {
    step();
    #translate([0,-length,0]) cube([width-10, length, target]);
}