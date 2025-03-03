include <pegboard wizard.scad>

$fn = 160;


pinboard_column(left=false);
translate([-3.9,0,0]) rotate([0,0,180]) pinboard_column(left=true, board_thickness=1.5);

// disable chamfer first