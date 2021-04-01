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
T_c = 0.1;

m1 = 1/5;
m2 = 1/5;

xd = u(1);
dxd = cos(t);
ddxd = -sin(t);
x1 = u(2);
x2 = u(3);

e = xd - x1;
de = dxd - x2;

s = de + 1/T_c * exp(abs(e)^m1) / (m1*abs(e)^(m1-1))*sign(e);

% sys =  J * (ddxd + 1/T_c*(exp(abs(e)^m1)*m1^2*abs(e)^(2*m1) - exp(abs(e)^m1)*m1*(m1-1)*abs(e)^m1)*de/(m1^2*abs(e)^(2*m1)) + 1/T_c*exp(abs(s)^m2)/(m2*abs(s)^(m2-1)));
sys =  J * (ddxd + 1/T_c*(exp(abs(e)^m1)*m1^2*abs(e)^(2*m1-2) - exp(abs(e)^m1)*m1*(m1-1)*abs(e)^(m1-2))*de/(m1^2*abs(e)^(2*m1-2)) + 1/T_c*exp(abs(s)^m2)/(m2*abs(s)^(m2-1))*sign(s));