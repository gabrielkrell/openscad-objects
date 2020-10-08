/*
I designed this hanger peg to hang things on the wall using the various 3M Command Strips which I'm a big fan off.
I have a bunch of things that have those little "keyhole" hanger points that you're supposed to slip over a nail 
or screw head but I don't like making holes in my walls especially when the item doesn't weigh very much. So I made 
this design to attach to the wall with a Command Strip designed to hold the weight and then hang your item on the peg.
The normal Poster strips are supposed to be able to hold up 0.5 pounds which is plenty for many small things. Need 
to hang something bigger like a drill battery holder?  Scale up the base for a bigger Command Strip for more weight.
*/

$fn=50;

// This should be the size of the command strip
baseW = 16;
baseL = 47;
baseH = 2;
baseC = "blue";

// This is the size of the small part of the keyhole
pegD = 4;  // width of the small part
pegH = 3;  // thickness of the small part
pegC = "green";

// This is the size of the big part of the keyhole
capD = 8;  // width of the big part
capH = 2;  // thickness of the big part
capC = "red";
rotate([90,0,0]) // I would print it standing on end so the the layers are perpendicular to the shear stress on the peg
difference(){
  union(){
    color(baseC) cube([baseW, baseL, baseH]);
    translate([baseW/2+3,pegD/2, baseH])
      color(pegC) cylinder(d=pegD, h=pegH);
    translate([baseW/2+3,pegD/2, baseH+pegH])
      color(capC) cylinder(d=capD, h=capH);
  }
  //slice a flat base on it for easier printing.
  translate([0,-(capD-pegD),0])
    cube([baseW,capD-pegD,baseH+pegH+capH]);
}