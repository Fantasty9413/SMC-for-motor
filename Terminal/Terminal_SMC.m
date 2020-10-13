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
k=15;
xite=1.1;

T = 1;        % ’¡≤ ±º‰

c11 = 4;
c21 = 1;
C = [c11, c21];

thd = u(1);
th = u(2);
dth = u(3);
dthd = cos(t);
ddthd = -sin(t);

e = th - thd;
de = dth - dthd;
E = [e; de];

e0 = 0;
de0 = -1;
dde0 = 0;

A1 = 6;
A2 = -8;
A3 = 3;

% A1 = 80;
% A2 = -240;
% A3 = 192;

if(t <= T)
%         p = e0 + de0*t + 1/2*dde0*t^2 + A1*t^3 + A2*t^4 + A3*t^5;
%         dp = de0 + dde0*t + 3*A1*t^2 + 4*A2*t^3 + 5*A3*t^4;
%         ddp = dde0 + 6*A1*t + 12*A2*t^2 + 20*A3*t^3;
        p = e0 + de0*t + 1/2*dde0*t^2 + A1*t^3 + A2*t^4 + A3*t^5;
        dp = de0 + dde0*t + 3*A1*t^2 + 4*A2*t^3 + 5*A3*t^4;
        ddp = dde0 + 6*A1*t + 12*A2*t^2 + 20*A3*t^3;
else
        p = 0;
        dp = 0;
        ddp = 0;
end
P = [p; dp];

% p = e0 + de0*t + 1/2*dde0*t^2 + A1*t^3 + A2*t^4 + A3*t^5;
% dp = de0 + dde0*t + 3*A1*t^2 + 4*A2*t^3 + 5*A3*t^4;
% ddp = dde0 + 6*A1*t + 12*A2*t^2 + 20*A3*t^3;
% P = [p; dp];

S = C*E - C*P; 

%%sys = J*(c11/c21*dp + ddp - c11/c21*de + ddthd) - xite*sign(S) -k*S;
%%sys = 1/J*(c11/c21*dp + ddp - c11/c21*de + ddthd) - 1/J*sign(S)*(xite + k);
sys = 1/J*(c11/c21*dp + ddp + ddthd - c11/c21*de + ddthd) - 1/J*tanh(S/0.1)*(1/J*xite + k);

