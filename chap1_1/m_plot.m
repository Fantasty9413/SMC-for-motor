close all;      %关闭所有figure窗口

%% 1.输出跟踪输入
figure(1);
plot(t,y(:,1),'r',t,y(:,2),'b:','linewidth',2);
xlabel('time(s)');ylabel('step response');

%% 2.控制量
figure(2);
plot(t,ut,'linewidth',2);
xlabel('time(s)');ylabel('control input');