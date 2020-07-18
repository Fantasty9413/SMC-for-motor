close all;

c=15;

figure(1)
load dengsu;
plot(t,y(:,2),'y','linewidth',1);
hold on;
load zhishu;
plot(t,y(:,2),'g','linewidth',1);
hold on;
load mici;
plot(t,y(:,2),'r','linewidth',1);
hold on;
load yiban;
plot(t,y(:,2),'b','linewidth',1);
hold on;
plot(t,y(:,1),'k:','linewidth',1);
grid on;axis on;
xlabel('time(s)');ylabel('step response');
legend('等速趋近','指数趋近','幂次趋近','一般趋近','输入');


figure(2)
load dengsu;
plot(e,de,'y','linewidth',2);
hold on;
load zhishu;
plot(e,de,'g','linewidth',2);
hold on;
load mici;
plot(e,de,'r','linewidth',2);
hold on;
load yiban;
plot(e,de,'b','linewidth',2);
hold on;
plot(e,-c*e,'k:','linewidth',2);
grid on;axis on;
xlabel('e');ylabel('de');
legend('等速趋近','指数趋近','幂次趋近','一般趋近','滑模面');