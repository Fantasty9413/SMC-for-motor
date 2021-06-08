function [ output ] = J_function( input )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��   

    parameter = input;
    N = length(parameter);        %�������������

%% ����Simulinkģ����������
    model = 'motor';
    for i = 1:1:N
        in(i) = Simulink.SimulationInput(model);
        in(i) = in(i).setVariable('c', parameter(i));
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
for i = 1:1:N
    e(i,:) = simOut(i).e';
    ut(i,:) = simOut(i).ut';
end
                      
%     J = sum(abs(e(:,1))) + sum(abs(ut(:,1)));
%     J = sum(abs(e),2);
    J = sum(abs(e),2) + 0.1*sum(abs(ut),2);
    output = J;

end

