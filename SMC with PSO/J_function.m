function [ output ] = J_function( parameter1, parameter2 )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��  
%   parameter1 = c
%   parameter2 = k

    [M,N] = size(parameter1);        %�������������

%% ����Simulinkģ����������
    model = 'motor';
    for i = 1:1:M
        in(i) = Simulink.SimulationInput(model);
        in(i) = in(i).setVariable('c', parameter1(i,1));
        in(i) = in(i).setVariable('xite', parameter2(i,1));
%         in(i) = in(i).setVariable('k', parameter2(i,1));
    end
    in = in.setModelParameter('AbsTol', '1e-3', ...
                          'SimulationMode', 'accelerator', ...
                          'Solver', 'ode4',...
                          'StopTime', '10');
                      
%% �����������沢���ؼ�����
simOut = parsim(in, 'ShowSimulationManager', 'off');

%% ������ۺ���ֵ
e = [];
ut = []
for i = 1:1:M
    e(i,:) = simOut(i).e';
    ut(i,:) = simOut(i).ut';
end
                      
%     J = sum(abs(e(:,1))) + sum(abs(ut(:,1)));
%     J = sum(abs(e),2);
%     J = sum(abs(e),2) + 0.1*sum(abs(ut),2);
    J = sum(abs(e),2)*0.2 + sum(abs(ut),2);
    output = J;

end

