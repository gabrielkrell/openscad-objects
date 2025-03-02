nub=3.65;
mainHeight=26.15;
mainDiaMajor=11.81;
mainDiaMinor=9.59;

ridgeDepth=12-mainDiaMinor;
ridgeWidth=1.96;

offset=.57;

e=0.01;
holeTolerance=0.5;
$fn=120;

difference() {
    union() {
        translate([-offset,0,0]) cylinder(h=mainHeight+nub*2, d=6.55);
        translate([0,0,nub])
            resize([mainDiaMinor,mainDiaMajor,mainHeight])
            cylinder(h=mainHeight,d=mainDiaMajor);
        translate([-mainDiaMinor/2-ridgeDepth,-ridgeWidth/2,nub]) cube([ridgeDepth,ridgeWidth,mainHeight]);
    }
    union() {
        difference() {
            translate([-offset,0,-e]) cylinder(h=mainHeight+nub*2+2*e, d=4+holeTolerance);
            translate([holeTolerance,-5,-e*2]) cube([10,10,mainHeight+nub*2+2*e]);
        }
        insert();
    }
}


insertHeight=17;
module insert() {
    translate([1,-15,(2*nub+mainHeight-insertHeight)/2]) cube([1,30,insertHeight]);
    translate([1,-15,(2*nub+mainHeight-insertHeight)/2]) cube([20,30,2]);
}
