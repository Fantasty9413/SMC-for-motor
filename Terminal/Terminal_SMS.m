% 设计SMC的滑模面

Tc = 1;

A = [Tc^3, Tc^4, Tc^5;
     3*Tc^2, 4*Tc^3, 5*Tc^4;
     6*Tc^1, 12*Tc^2, 20*Tc^3];
 
 b = [Tc; 1; 0];
 
 x = A \ b