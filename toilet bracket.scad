// todo - make top part parallel

d = 10;
width = 10; // shrink before final print

cp = [10,-10];
ll = [0,0];
ul = ll + [0,41];
ur = ul + [47 * cos(d), 47*sin(d)];
lr = ur + [-6, -70];


linear_extrude(height=10)
polygon(points=[
    cp + [-width*sqrt(2)/2,-width*sqrt(2)/2],
    ll + [-width,-width/2],
    ul + [-width,+10],
    ur + [+width,+10],
    lr + [+width,     0],
    lr,ur,ul,ll,cp],
  convexity=4);