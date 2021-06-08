function [ output ] = J_function( input )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明   

    parameter = input;
    N = length(parameter);        %并行运算的数量

%% 定义Simulink模型批量运行
    model = 'motor';
    for i = 1:1:N
        in(i) = Simulink.SimulationInput(model);
        in(i) = in(i).setVariable('c', parameter(i));
    end
    in = in.setModelParameter('AbsTol', '1e-3', ...
                          'SimulationMode', 'accelerator', ...
                          'Solver', 'ode4',...
                          'StopTime', '10');
                      
%% 运行批量仿真并加载监视器
simOut = parsim(in, 'ShowSimulationManager', 'off');

%% 输出代价函数值
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

