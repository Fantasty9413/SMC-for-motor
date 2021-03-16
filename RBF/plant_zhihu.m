function [sys,x0,str,ts] = chap2_3plant(t,x,u,flag)
switch flag
case 0
    [sys,x0,str,ts] = mdlInitializeSizes;
case 1
    sys = mdlDerivatives(t,x,u);  % 微分对应连续状态变量
case 3
    sys = mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;  % 连续状态变量2个，待逼近模型的2阶传递函数
sizes.NumDiscStates  = 0;   
sizes.NumOutputs     = 1;  % 输出量1个
sizes.NumInputs      = 1;  % 输入量1个
sizes.DirFeedthrough = 0;  % 无直接馈通
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [];

function sys = mdlDerivatives(~,x,u)  % 对应传递函数的状态空间表达式形式
sys(1) = x(2);
sys(2) = -25*x(2)+133*u; 

function sys = mdlOutputs(~,x,~)
sys(1) = x(1);
