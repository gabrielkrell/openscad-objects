$fn=30;

pd = .5;
d=2;

rod_r = 1.5;
rod_h = 3;
flange_r = 1.5;
flange_h = 3;
cut_r = 1.5;
cut_d = 2;


vs = [
    [rod_r,0],
    [rod_r, rod_h],
    [rod_r+flange_r, rod_h],
    [cut_r, rod_h+flange_h],
    [cut_r, rod_h+flange_h-cut_d],
    [-(cut_r), rod_h+flange_h-cut_d],
    [-(cut_r), rod_h+flange_h],
    [-(rod_r+flange_r), rod_h],
    [-(rod_r), rod_h],
    [-rod_r, 0],
    [rod_r,0],
];

groups = [
[8,9,0,1],
[1,2,3,4],
[5,6,7,8],
[2,4,5,8]
];

for (group = groups) {
    hull() {
        for (i = group) {
            translate([vs[i][0], vs[i][1], 0]) cylinder(d=pd,h=d);
        }
    }
}

translate([-20,50,0]) rotate([90]) cylinder(d=8.5,h=128); // pencil