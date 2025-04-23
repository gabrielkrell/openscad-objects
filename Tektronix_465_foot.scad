/*

Reference pics:
https://web.archive.org/web/20230902024421/https://www.sphere.bc.ca/oldsite/test/feet/original%20foot-465b.jpg
https://web.archive.org/web/20230902024418/https://www.sphere.bc.ca/oldsite/test/feet/new-foot-parts.jpg
*/

//8mm radius
e=0.01;
mm_per_inch=25.4;
inch=mm_per_inch;
$fn=260;

module tek_blue(dark=false) {
    color(dark ? "#2e7c87" : "#19a5b9") children();
}


band = 12;
lip=2;
wall = 2.14;
height = 148;
width = (height - 5)*2;
center_offset=8-wall;

module scope() {
    case=50;
    
    tek_blue() difference() {
        hull() {
            translate([-height/2,-width/2,0]) cylinder(r=8, h=band);
            translate([height/2,width/2,0]) cylinder(r=8, h=band);
            translate([-height/2,width/2,0]) cylinder(r=8, h=band);
            translate([height/2,-width/2,0]) cylinder(r=8, h=band);
        }
        hull() {
            translate([-height/2,-width/2,band-lip-e]) cylinder(r=8-wall, h=lip+e*2);
            translate([height/2,width/2,band-lip-e]) cylinder(r=8-wall, h=lip+e*2);
            translate([-height/2,width/2,band-lip-e]) cylinder(r=8-wall, h=lip+e*2);
            translate([height/2,-width/2,band-lip-e]) cylinder(r=8-wall, h=lip+e*2);
        }
        // center of screw hole is exactly .5" from the inner lip of the band
        translate([
            -height/2-center_offset+mm_per_inch/2,
            -width/2-center_offset+mm_per_inch/2,
            0]) cylinder(d=8.75, h=band+1+e*2);
        translate([
            height/2+center_offset-mm_per_inch/2,
            width/2+center_offset-mm_per_inch/2,
            0]) cylinder(d=8.75, h=band+1+e*2);
        translate([
            height/2+center_offset-mm_per_inch/2,
            -width/2-center_offset+mm_per_inch/2,
            0]) cylinder(d=8.75, h=band+1+e*2);
        translate([
            -height/2-center_offset+mm_per_inch/2,
            width/2+center_offset-mm_per_inch/2,
            0]) cylinder(d=8.75, h=band+1+e*2);
    }
    
    tek_blue(dark=true) translate([0,0,-case]) hull() {
        translate([-height/2,-width/2,0]) cylinder(r=8-wall, h=case-e);
        translate([height/2,width/2,0]) cylinder(r=8-wall, h=case-e);
        translate([-height/2,width/2,0]) cylinder(r=8-wall, h=case-e);
        translate([height/2,-width/2,0]) cylinder(r=8-wall, h=case-e);
    }
}


module foot() {
    // rubber circle was 0.75" diameter
    // overall foot was about 1-3/8"post-to-post
    // the first level of the foot is square to match the case, then the rest of it
    // is a rounded corner. let's just make the whole thing out of TPU
    
    // there's 1/2" between hole center and case edge, but only 10mm between 
    // hole center and protruding scope bits

    // first, a little countersunk part for indexing
    translate([0,0,-mm_per_inch/10]) cylinder(d=8,h=mm_per_inch/10);
    
    // next, the rounded square
    total=inch/2+10;
    translate([-1/2*inch,-1/2*inch,0]) hull() {
        corner=5;
        translate([corner,corner,0]) cylinder(r=corner,h=5);
        translate([total-corner,total-corner,0]) cylinder(r=corner,h=5);
        translate([corner,total-corner,0]) cylinder(r=corner,h=5);
        translate([total-corner,corner,0]) cylinder(r=corner,h=5);
    }
    
    // now the rounded part
    height=(1+3/8)*inch;
    difference() {
        intersection() {
            translate([-1/2*inch,-1/2*inch,0]) hull() {
                corner=5;
                translate([corner,corner,0]) cylinder(r=corner,h=height);
                translate([total-corner,total-corner,0]) cylinder(r=corner,h=height);
                translate([corner,total-corner,0]) cylinder(r=corner,h=height);
                translate([total-corner,corner,0]) cylinder(r=corner,h=height);
            }
            
            translate([10,10,0]) cylinder(r=total,h=height);
        }
        
        cut_tr=total-(1/8*inch)*.6;
        // properly seat the cord, but not enough to
        // impinge on the center screw
        
        translate([10,10,1/8*inch+5]) rotate([0,0,179])
            rotate_extrude(angle=92) hull() {
                translate([cut_tr,0,0]) circle(d=1/4*inch);
                translate([total,0,0]) circle(d=1/4*inch);
            };

        translate([10,10,1/8*inch+1/4*inch+1/8*inch+5]) rotate([0,0,179])
        rotate_extrude(angle=92) hull() {
            translate([cut_tr,0,0]) circle(d=1/4*inch);
            translate([total,0,0]) circle(d=1/4*inch);
        };

        translate([10,10,2/8*inch+2/4*inch+1/8*inch+5]) rotate([0,0,179])
        rotate_extrude(angle=92) hull() {
            translate([cut_tr,0,0]) circle(d=1/4*inch);
            translate([total,0,0]) circle(d=1/4*inch);
        };
    }
}

module foot_with_hole() {
    difference() {
        foot();
        translate([0,0,-inch]) cylinder(d=4.5,h=3*inch);
        translate([0,0,(1+3/8)*inch-3.5]) cylinder(d=8.5,h=3.5+e);
    }
}

    
translate([0,0,10]) rotate([-90,90,0]) foot_with_hole();

//scope();
//translate([
//    -height/2-center_offset+mm_per_inch/2,
//    -width/2-center_offset+mm_per_inch/2,
//    band-lip]) foot_with_hole();
//translate([
//    height/2+center_offset-mm_per_inch/2,
//    width/2+center_offset-mm_per_inch/2,
//    band-lip]) rotate([0,0,180]) foot_with_hole();
//translate([
//    height/2+center_offset-mm_per_inch/2,
//    -width/2-center_offset+mm_per_inch/2,
//    band-lip]) rotate([0,0,90]) foot_with_hole();
//translate([
//    -height/2-center_offset+mm_per_inch/2,
//    width/2+center_offset-mm_per_inch/2,
//    band-lip]) rotate([0,0,270]) foot_with_hole();