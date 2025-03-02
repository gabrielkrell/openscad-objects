$fn=360;

module hole(h=30) {
    cylinder(d=27, h=h);
}


// spacing is 35mm
spacing = 35;

module holes() {    
    for(column = [0: 4]) {
        x = column * spacing ;
        translate([x,0,0]) hole();
    }
    
    for(row= [1:3 ] ) {
        height = row * spacing /2 * tan(60);
        offset = spacing /2 * row;
        for(column = [0: 5 - row]) {
            x = offset + column * spacing ;
            translate([x,height,0]) hole();
        }
    }

    for(row= [1:2] ) {
        height = row * spacing /2 * tan(60);
        offset = spacing /2 * row;
        for(column = [0: 5 - row]) {
            x = offset + column * spacing ;
            translate([x,-height,0]) hole();
        }
    }
}

// 239x239 hexagon outside

module plate() {
    thickness=4;
    hull() {
        translate([-15,0,0]) hole(thickness);
        // #translate([5*spacing+15,0,0]) hole(thickness);
        #translate([
            4.5*spacing+15*cos(60),
            spacing*sin(60) + 15 * sin(60),
            0]) hole(thickness);
        #translate([
            4.5*spacing+15*cos(60),
            -spacing*sin(60) - 15 * sin(60),
            0]) hole(thickness);
        translate([
            1*spacing + spacing/2    - 15*cos(60),
            3 * spacing /2 * tan(60) + 15*sin(60),
            0]) hole(thickness);
        translate([
            3*spacing + spacing/2    + 15*cos(60),
            3 * spacing /2 * tan(60) + 15*sin(60),
            0]) hole(thickness);
        translate([
            1*spacing    - 15*cos(60),
            -2/2 * spacing * tan(60) - 15*sin(60),
            0]) hole(thickness);
        translate([
            4*spacing    + 15*cos(60),
            -2/2 * spacing * tan(60) - 15*sin(60),
            0]) hole(thickness);
    }
}

difference() {
    plate();
    translate([0,0,-0.01]) holes();
}