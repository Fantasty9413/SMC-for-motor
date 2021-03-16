function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];

function sys=mdlDerivatives(t,x,u)

sys=[];

function sys=mdlOutputs(t,x,u)
J = 2;
f = 0;
g = 1/J;

alpha1 = 10;
beta1 = 5;
alpha2 = 10;
beta2 = 5;
m1 = 9;
n1 = 5;
m2 = 9;
n2 = 5;
p1 = 5;
q1 = 9;
p2 = 5;
q2 = 9;
h = 100;

yd = u(1);
dyd = cos(t);
ddyd = -sin(t);
y1 = u(2);
y2 = u(3);

e = yd - y1;
de = dyd - y2;

s = de + alpha1 * abs(e)^(1/2 + m1/(2*n1) + (m1/(2*n1)-1/2)*sign(abs(e)-1))*sign(e) + beta1 * abs(e)^(p1/q1)*sign(e);

% sys = -1/g * (f + alpha1*(1/2 + m1/(2*n1) + (m1/(2*n1)-1/2)*sign(abs(y1)-1))*y1^(1/2 + m1/(2*n1) + (m1/(2*n1)-1/2)*sign(abs(y1)-1)-1)*y2 + sat(beta1*p1/q1 * y1^(p1/q1-1)*y2, h) + alpha2 * s^(1/2 + m2/(2*n2) + (m2/(2*n2)-1/2)*sign(abs(s)-1)) + beta2*s^(p2/q2));
sys = 1/g * (ddyd - f + alpha1*(1/2 + m1/(2*n1) + (m1/(2*n1)-1/2)*sign(abs(e)-1))*abs(e)^(1/2 + m1/(2*n1) + (m1/(2*n1)-1/2)*sign(abs(e)-1)-1)*sign(e)*de + sat(beta1*p1/q1 * abs(e)^(p1/q1-1)*sign(e) * de, h) + alpha2 * abs(s)^(1/2 + m2/(2*n2) + (m2/(2*n2)-1/2)*sign(abs(s)-1))*sign(s) + beta2*abs(s)^(p2/q2)*sign(s));
