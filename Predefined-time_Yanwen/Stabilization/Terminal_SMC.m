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
sizes.NumInputs      = 2;
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
T_c = 1;

m1 = 1/3;
m2 = 1/3;

x1 = u(1);
x2 = u(2);

s = x2 + 1/T_c * exp(abs(x1)^m1) / (m1*abs(x1)^(m1-1))*sign(x1);

sys = -J/T_c * ((exp(abs(x1)^m1)*m1^2*abs(x1)^(2*m1-2) - exp(abs(x1)^m1)*m1*(m1-1)*abs(x1)^(m1-2))*x2/(m1^2*abs(x1)^(2*m1-2)) + sign(s)*exp(abs(s)^m2)/(m2*abs(s)^(m2-1)));
