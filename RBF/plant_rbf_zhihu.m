function [sys,x0,str,ts] = chap2_3rbf(t,x,u,flag)
switch flag
case 0
    [sys,x0,str,ts] = mdlInitializeSizes;
case 3
    sys = mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1; % 输出量1个
sizes.NumInputs      = 2; % 输入量2个
sizes.DirFeedthrough = 1; % 存在直接馈通
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];

function sys = mdlOutputs(t,~,u)
persistent w w_1 w_2 b ci         % 定义持久变量
alfa = 0.05;                      % 动量因子
xite = 0.5;                       % 学习率
if t == 0
	b = 1.5;
    ci = [-1  -0.5 0 0.5 1;
          -10 -5   0 5   10];
	w  = rands(5,1);   
	w_1 = w;
    w_2 = w_1;
end
ut   = u(1);       % 第一个输入
yout = u(2);       % 第二个输入
xi   = [ut yout]'; % 输入层
for j = 1:1:5
    h(j) = exp(-norm(xi-ci(:,j))^2/(2*b^2));
end
ymout = w'*h';  % 神经网络输出值【存在直接馈通】
d_w   = 0*w;    % 预留位置[5*1]
for j = 1:1:5
   d_w(j) = xite*(yout-ymout)*h(j);
end
w   = w_1 + d_w + alfa*(w_1-w_2);   
w_2 = w_1;      % 上一次权值
w_1 = w;        % 当前权值 
sys(1) = ymout;
