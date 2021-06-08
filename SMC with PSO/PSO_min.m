%{
程序功能：
1、粒子群算法求解函数的最优值
2、参考链接：https://blog.csdn.net/qq_32515081/article/details/79793549

%}
clc
clear
close

%% 1.绘制函数曲线
f= @(x1,x2)x1 .* sin(x1) .* cos(2 * x1) - 2 * x2 .* sin(3 * x2);    % 函数表达式
x1 = 0:0.1:20;
x2 = 0:0.1:20;
X=[x1',x2'];
pso_plot_2(X,f);        %绘制波形

%% 2.PSO参数初始化
N = 100;                         % 初始种群个数
d = 2;                          % 空间维数
ger = 1000;                      % 最大迭代次数     
limit = [0, 20; 0, 20];         % 设置位置参数限制
vlimit = [-1, 1; -1, 1];        % 设置速度限制
w = 0.8;                        % 惯性权重
c1 = 0.5;                       % 自我学习因子
c2 = 0.5;                       % 群体学习因子 
for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%初始种群的位置
end
v = rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
fxm = zeros(N, 1);               % 每个个体的历史最佳适应度
fym = inf;                       % 种群历史最佳适应度
figure
pso_plot_2(X,f);
hold on
scatter3(x(:,1),x(:,2),f(x(:,1),x(:,2)),'ro')       %种群初始位置
title('初始状态图');

%% 3.迭代更新
figure
% axis([0,20,0,20,-60,20])
set(gca,'XLim',[0 20]);% X轴的数据显示范围
set(gca,'YLim',[0 20]);% X轴的数据显示范围
iter = 1;
record = zeros(ger, 1);          % 记录器
while iter <= ger
     fx = f(x(:,1),x(:,2)) ; % 个体当前适应度   
     for i = 1:N      
        if fxm(i) > fx(i)
            fxm(i) = fx(i);     % 更新个体历史最佳适应度
            xm(i,:) = x(i,:);   % 更新个体历史最佳位置
        end 
     end
    if fym > min(fxm)
        [fym, nmin] = min(fxm);   % 更新群体历史最佳适应度
        ym = xm(nmin, :);      % 更新群体历史最佳位置
    end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% 速度更新
    % 边界速度处理
    v(v > vlimit(1,2)) = vlimit(1,2);
    v(v < vlimit(1,1)) = vlimit(1,1);
    x = x + v;      % 位置更新
    % 边界位置处理
    x(x > limit(1,2)) = limit(1,2);
    x(x < limit(1,1)) = limit(1,1);
    record(iter) = fym;%最小值记录
    
%     scatter3(x(:,1),x(:,2),f(x(:,1),x(:,2)),'ro')
    plot(x(:,1),x(:,2),'ro')
    axis([0,20,0,20])
    pause(0.02)
    
    iter = iter+1;
end

figure
plot(record);
title('收敛过程')
figure
pso_plot_2(X,f); 
hold on
scatter3(x(:,1),x(:,2),f(x(:,1),x(:,2)),'ro','linewidth',3)
title('PSO寻优')
disp(['最小值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);

function [] = pso_plot_2(x,f)
    [X1,X2] = meshgrid(x(:,1),x(:,2));
    F = f(X1,X2);
    mesh(X1,X2,F);
end