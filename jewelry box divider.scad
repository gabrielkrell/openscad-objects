height=31.3;
depth=82; // 84 input -> 84.75 output -> 82.66 trimmed. revised to 82
width=164; // 165 -> 164

thickness=1;



module ns_divider(length, edge=false) {
    if (!edge) {
        cube([thickness,length,height]);
        translate([-2*thickness,0,0]) cube([thickness*5,length,thickness]);
    } else {
        cube([thickness*5,length,thickness]);
    }
}

module ew_divider(length, edge=false) {
    rotate([0,0,-90]) ns_divider(length, edge);
}

module interior() {
    for (o = [width/4:width/4:width-1]) {
        translate([o,0,0]) ns_divider(depth);
    }
    translate([0,depth/2,0]) ew_divider(width);

    translate([0,5*thickness,0]) ew_divider(width,true);
    ns_divider(depth,true);
    translate([0,depth]) ew_divider(width,true);
    translate([width-5*thickness,0,0]) ns_divider(depth,true);
}

    interior();
//    cube([width,depth,height]);