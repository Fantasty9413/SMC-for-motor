function [sys,x0,str,ts] = chap2_3plant(t,x,u,flag)
switch flag
case 0
    [sys,x0,str,ts] = mdlInitializeSizes;
case 1
    sys = mdlDerivatives(t,x,u);  % ΢�ֶ�Ӧ����״̬����
case 3
    sys = mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;  % ����״̬����2�������ƽ�ģ�͵�2�״��ݺ���
sizes.NumDiscStates  = 0;   
sizes.NumOutputs     = 1;  % �����1��
sizes.NumInputs      = 1;  % ������1��
sizes.DirFeedthrough = 0;  % ��ֱ����ͨ
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [];

function sys = mdlDerivatives(~,x,u)  % ��Ӧ���ݺ�����״̬�ռ���ʽ��ʽ
sys(1) = x(2);
sys(2) = -25*x(2)+133*u; 

function sys = mdlOutputs(~,x,~)
sys(1) = x(1);
