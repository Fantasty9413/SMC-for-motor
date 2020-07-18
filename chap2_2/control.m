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

function sys=mdlOutputs(t,x,u)
c=15;
xite=5;
k=10;
b=133;

thd=u(1);
th=u(2);
dth=u(3);
dthd=cos(t);    %diff
ddthd=-sin(t);

e=thd-th;
de=dthd-dth;
s=c*e+de;

S=1;
if S==1
   ds=-xite*sign(s); 
elseif S==2
   ds=-xite*sign(s)-k*s;    
elseif S==3
   ds=-k*sqrt(abs(s))*sign(s);         
elseif S==4
   ds=-xite*s-1/2*k*s^2;
end

%ds=-xite*sign(s);
%ds=-xite*sign(s)-k*s;
ut=1/b*(c*de+ddthd+25*dth-ds);

sys(1)=ut;
sys(2)=e;
sys(3)=de;
sys(4)=S;

