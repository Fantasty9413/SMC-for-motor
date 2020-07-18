close all;

figure(1)
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('Angel');
legend('Input','Output');
title('Angle track');

figure(2)
c=15;
plot(e,de,'r',e,-c*e,'linewidth',2);
xlabel('e');ylabel('de');
legend('s change','s');
title('S track');