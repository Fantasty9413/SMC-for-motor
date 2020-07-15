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
J=2;
c=10;
k=10;
xite=1.1;

thd=u(1);
th=u(2);
dth=u(3);

e=th-thd;
de=dth;
s=c*e+de;

sys=J*(-c*dth-1/J*(k*s+xite*sign(s)));      %signÎª·ûºÅº¯Êý
