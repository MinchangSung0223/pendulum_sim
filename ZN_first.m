close all
clear all
home
s_time = 0.002; tf = 10;
q = 0; qdot = 0; eint = 0;
global m;
global l;
global g;
global u;
global kf;
m = 1; l = 1; g = 9.806; kf = 0.5; n=1;
hold on
axis([-1.5 1.5 -1.5 1.5]);
grid
x=l*sin(q); Ax = [0, x]; y = -l*cos(q); Ay = [0, y];

figure(1)
subplot(1,2,1);
p = line(Ax,Ay,'LineWidth',[5],'Color','b');
hold on;
grid on;
plot(l*cos(0:0.01:2*pi),l*sin(0:0.01:2*pi),"r:")
daspect([1,1,1])
tt = [0]
th = [0]
subplot(1,2,2);
p2 = line(tt,th,'LineWidth',[1],'Color','b');
hold on;
daspect([1,1,1])
grid on;
axis([0,tf,-pi,pi])

qd = pi/2;

Kcr = 57;
Pcr = 0.8240
Kp = 0.6*57;
Ti = 0.5*Pcr*1.6;
Td = 0.125*Pcr*1.8;
eint = 0;
prev_e = 0;
for i = 0 : s_time : tf
    
e = qd-q;
edot = 0-qdot;
eint = eint+e*s_time;
u = Kp*e+Kp*Td*edot+Kp/Ti*eint;

[t,z] = ode45('pendulum', [0, s_time], [q; qdot]);
index = size(z); q = z(index(1), 1); qdot = z(index(1), 2);
x=l*sin(q);
Ax = [0, x]; 
y = -l*cos(q); 
Ay = [0, y];
n=n+1;
data(n+1,1) = i; data(n+1,2) = q;

if rem(n,10) == 0
subplot(1,2,1);
set(p,'X', Ax, 'Y',Ay)

subplot(1,2,2);
th(end+1) = q;
tt(end+1) = i;
set(p2,'X',tt, 'Y',th)
drawnow;
end
end

plot(data(:,1),data(:,2))
