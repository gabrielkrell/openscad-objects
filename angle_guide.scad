$fn=360; 

length = 20;
angle = 20;
extrude = 40;

x = length * cos(angle);
y = length * sin(angle);

translate([0,extrude,0]) rotate([90,0,0]) linear_extrude(height = extrude) {
    polygon(points = [
        [0,0],
        [x, y],
        [x, 0]]);
}

translate([x - y,0,y/8])
rotate([90,0,0]) linear_extrude(height=1) { text(str(angle, "°"), size=y / 2);}