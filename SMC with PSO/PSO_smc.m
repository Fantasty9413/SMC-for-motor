%{
�����ܣ�
1������Ⱥ�㷨��⺯��������ֵ
2���ο����ӣ�https://blog.csdn.net/qq_32515081/article/details/79793549

%}
clc
clear
close

tic

% ��ʼ����Ⱥ
f= @J_function; % �������ʽ
figure(1)
% ezplot(f,[1,1,100]);
N = 20;                         % ��ʼ��Ⱥ����
d = 1;                          % �ռ�ά��
ger = 25;                      % ����������     
limit = [1, 10];                % ����λ�ò�������
vlimit = [-1, 1];               % �����ٶ�����
% w = 0.8;                        % ����Ȩ��
% c1 = 0.5;                       % ����ѧϰ����
% c2 = 0.5;                       % Ⱥ��ѧϰ���� 

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
fym = inf;                      % ��Ⱥ��ʷ�����Ӧ��
hold on
plot(xm, f(xm), 'kx');title('��ʼ״̬ͼ');
title('��ʼ״̬ͼ')

% Ⱥ�����
iter = 1;
record = zeros(ger, 1);          % ��¼��
while iter <= ger
     disp(['�������� ',num2str(iter), ' ��']);
     fx = f(x) ; % ���嵱ǰ��Ӧ��   
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
    v(v > vlimit(2)) = vlimit(2);
    v(v < vlimit(1)) = vlimit(1);
    x = x + v;% λ�ø���
    % �߽�λ�ô���
    x(x > limit(2)) = limit(2);
    x(x < limit(1)) = limit(1);
    record(iter) = fym;%��Сֵ��¼
%     x0 = 0 : 0.01 : 20;
%     plot(x0, f(x0), 'b-', x, f(x), 'ro');title('״̬λ�ñ仯')
%     pause(0.1)
    iter = iter+1;
end
figure(2)
plot(record);
title('��������')
x0 = 1 : 0.1 : 10;
figure(1)
plot(x0, f(x0), 'k-');
hold on
plot(x,f(x),'ro','linewidth',3)
title('PSOѰ��')
disp(['��Сֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);

toc