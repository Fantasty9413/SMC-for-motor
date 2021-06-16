function [sys,x0,str,ts] = spacemodel(t,x,u,flag,k1,k2)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u,k1,k2);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];

function sys=mdlDerivatives(t,x,u)
sys=[];

function sys=mdlOutputs(t,x,u,k1,k2)
% c=5;
% c=10;
% k=10;
b=133;
% k1 = 1;
% k2 = 2;

thd=u(1);
th=u(2);
dth=u(3);
% c=u(4);
dthd=cos(t);    %diff
ddthd=-sin(t);

f1 = 0;
df1 = 0;
G1 = 1;
f2 = -25*dth;
G2 = b;

z1 = th - thd;
x2d = 1/G1*(-k1*z1 - f1 + dthd);
z2 = dth - x2d;
dz1 = -k1*z1 + G1*z2;
dx2d = 1/G1*(-k1*dz1 - df1 + ddthd);

ut = 1/G2*(-k2*z2 - G1*z1 - f2 + dx2d);

sys(1)=ut;
sys(2)=z1;
sys(3)=z2;
sys(4)=x2d;

