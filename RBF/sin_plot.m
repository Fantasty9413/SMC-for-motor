close all
figure(1);
plot(t,y(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('y');

figure(2);
plot(y(:,2),y(:,3),'r','linewidth',2)
xlabel('x');ylabel('hj');
hold on;
plot(y(:,2),y(:,4),'k','linewidth',2);
hold on
plot(y(:,2),y(:,5),'g','linewidth',2);
hold on
plot(y(:,2),y(:,6),'b','linewidth',2);
hold on
plot(y(:,2),y(:,7),'y','linewidth',2);
