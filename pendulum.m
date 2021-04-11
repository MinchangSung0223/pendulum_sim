function dxdt = pendulum(t,x)
global m;
global l;
global g;
global u;
global kf;
dxdt = zeros(2,1);
dxdt(1) = x(2);
dxdt(2) = -(g/l)*sin(x(1)) -(kf/m/l/l)*sign(x(2)) + (1/m/l/l)*u;
