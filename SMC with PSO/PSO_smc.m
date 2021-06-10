%{
�����ܣ�
1������Ⱥ�㷨��⺯��������ֵ
2���ο����ӣ�https://blog.csdn.net/qq_32515081/article/details/79793549

%}
clc
clear
close

tic

%% 1.���ƺ�������
f= @J_function;    % �������ʽ
x1 = 0:0.1:10;
x2 = 0:0.1:10;
X=[x1',x2'];
% pso_plot_2(X,f);        %���Ʋ���

%% 2.PSO������ʼ��
N = 24;                         % ��ʼ��Ⱥ����
d = 2;                          % �ռ�ά��
ger = 50;                      % ����������     
limit = [0, 10; 0, 10];         % ����λ�ò�������
vlimit = [-1, 1; -1, 1];        % �����ٶ�����
w = 0.8;                        % ����Ȩ��
c1 = 0.5;                       % ����ѧϰ����
c2 = 0.5;                       % Ⱥ��ѧϰ���� 
for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
end
v = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ��
fxm = inf*ones(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = inf;                       % ��Ⱥ��ʷ�����Ӧ��
figure
% pso_plot_2(X,f);
% hold on
scatter3(x(:,1),x(:,2),f(x(:,1),x(:,2)),'ro')       %��Ⱥ��ʼλ��
title('��ʼ״̬ͼ');

%% 3.��������
figure
% axis([0,20,0,20,-60,20])
set(gca,'XLim',[0 limit(1,2)]);% X���������ʾ��Χ
set(gca,'YLim',[0 limit(2,2)]);% X���������ʾ��Χ
iter = 1;
record = zeros(ger, 1);          % ��¼��
bar = waitbar(0, '׼����ʼ�Ż����㣬���Եȣ�');      %���ɽ�����
while iter <= ger
     fx = f(x(:,1),x(:,2)) ; % ���嵱ǰ��Ӧ��   
     for i = 1:N      
        if fxm(i) > fx(i)
            fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end 
     end
    if fym > min(fxm)
        [fym, nmin] = min(fxm);   % ����Ⱥ����ʷ�����Ӧ��
        ym = xm(nmin, :);      % ����Ⱥ����ʷ���λ��
    end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% �ٶȸ���
    % �߽��ٶȴ���
    v(v > vlimit(1,2)) = vlimit(1,2);
    v(v < vlimit(1,1)) = vlimit(1,1);
    x = x + v;      % λ�ø���
    % �߽�λ�ô���
    x(x > limit(1,2)) = limit(1,2);
    x(x < limit(1,1)) = limit(1,1);
    record(iter) = fym;%��Сֵ��¼
    
%     scatter3(x(:,1),x(:,2),f(x(:,1),x(:,2)),'ro')
    plot(x(:,1),x(:,2),'ro')
    axis([0,limit(1,2),0,limit(2,2)])
    grid on
    title('����Ⱥλ�÷ֲ�')
%     pause(0.02)
    progress_bar(iter/ger,bar);
    iter = iter+1;
end

figure
plot(record);
title('��������')
figure
scatter3(x(:,1),x(:,2),f(x(:,1),x(:,2)),'ro','linewidth',3)
title('PSOѰ��')
disp(['��Сֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);

toc

function [] = pso_plot_2(x,f)
    [X1,X2] = meshgrid(x(:,1),x(:,2));
    F = f(X1,X2);
    mesh(X1,X2,F);
end

function progress_bar(num, bar)
    str = ['����������...', num2str(num*100), '%'];
    waitbar(num, bar, str);
    if(num>=1)
       close(bar); 
    end
end