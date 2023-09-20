widths = [
    0,
    24.5,
    40.6,
    52,
    62.6,
    71.7,
    80,
    87,
    92,
    96,
    99,
    102,
    103,
    104,
    104.7,
    104.9,
    105,
    105,
    105,
    105,
    105
];

steps = len(widths)-1;

sideways_tolerance = 2;
iron_edge_points = [
	for (a = [steps : -1 : 1]) [ 10*a, 0 - widths[a]/2 - sideways_tolerance ],
    [0, 0],
	for (a = [1: steps]) [ 10*a, widths[a]/2 + sideways_tolerance]
];
inset_depth = 5;
iron_center_points = [
	for (a = [steps : -1 : 1]) [ 10*a, 0 - widths[a]/2 + inset_depth ],
    [0, 0],
	for (a = [1: steps]) [ 10*a, widths[a]/2 - inset_depth]
];
wall_width = 3;
plate_points = [
	for (a = [steps : -1 : 1]) [ 10*a, 0 - widths[a]/2 - sideways_tolerance - wall_width ],
    [0, 0],
	for (a = [1: steps]) [ 10*a, widths[a]/2 + sideways_tolerance + wall_width ]
];


module iron() {
    linear_extrude(4) polygon(iron_edge_points);
    linear_extrude(10) polygon(iron_center_points);
}

module plate() {
    difference() {
        linear_extrude(4 + wall_width) polygon(plate_points);
        translate([0, 0, 1.5]) iron();
        translate([0,-40,-5]) cube([40,80,20]);
        #translate([120,-80,-5]) cube([80,160,20]);
    }
}
    

//color("grey") iron();

plate();