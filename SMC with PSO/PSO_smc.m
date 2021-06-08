%{
程序功能：
1、粒子群算法求解函数的最优值
2、参考链接：https://blog.csdn.net/qq_32515081/article/details/79793549

%}
clc
clear
close

tic

% 初始化种群
f= @J_function; % 函数表达式
figure(1)
% ezplot(f,[1,1,100]);
N = 20;                         % 初始种群个数
d = 1;                          % 空间维数
ger = 25;                      % 最大迭代次数     
limit = [1, 10];                % 设置位置参数限制
vlimit = [-1, 1];               % 设置速度限制
% w = 0.8;                        % 惯性权重
% c1 = 0.5;                       % 自我学习因子
% c2 = 0.5;                       % 群体学习因子 

w = 0.8;                        % 惯性权重
c1 = 0.5;                       % 自我学习因子
c2 = 0.5;                       % 群体学习因子 

for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%初始种群的位置
end
v = rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
fxm = inf*ones(N, 1);               % 每个个体的历史最佳适应度
fym = inf;                      % 种群历史最佳适应度
hold on
plot(xm, f(xm), 'kx');title('初始状态图');
title('初始状态图')

% 群体更新
iter = 1;
record = zeros(ger, 1);          % 记录器
while iter <= ger
     disp(['迭代至第 ',num2str(iter), ' 代']);
     fx = f(x) ; % 个体当前适应度   
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
    v(v > vlimit(2)) = vlimit(2);
    v(v < vlimit(1)) = vlimit(1);
    x = x + v;% 位置更新
    % 边界位置处理
    x(x > limit(2)) = limit(2);
    x(x < limit(1)) = limit(1);
    record(iter) = fym;%最小值记录
%     x0 = 0 : 0.01 : 20;
%     plot(x0, f(x0), 'b-', x, f(x), 'ro');title('状态位置变化')
%     pause(0.1)
    iter = iter+1;
end
figure(2)
plot(record);
title('收敛过程')
x0 = 1 : 0.1 : 10;
figure(1)
plot(x0, f(x0), 'k-');
hold on
plot(x,f(x),'ro','linewidth',3)
title('PSO寻优')
disp(['最小值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);

toc