wall=1;
// note - bottom was too thin and it tore during print. shore it up before printing again
difference() {
    cube([90+wall*2,65+wall*2,50]);
    translate([wall,wall,wall]) cube([90,65,50+wall]);
}