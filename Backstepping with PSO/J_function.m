% ������������������������������������������������������������������������������
% -*- coding: utf-8 -*-
% @Time    : 2021-06-16
% @Author  : Fantasty9413
% @FileName: J_function.m
% @Software: Matlab2020b
% @Github  : https://github.com/Fantasty9413
% ������������������������������������������������������������������������������

function [ output ] = J_function( parameter1, parameter2 )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��  
%   parameter1 = c
%   parameter2 = k

    [M,N] = size(parameter1);        %�������������
    T_step = 0.001;                  %simulinlk���沽��

%% ����Simulinkģ����������
    model = 'motor';
    for i = 1:1:M
        in(i) = Simulink.SimulationInput(model);
        in(i) = in(i).setVariable('k1', parameter1(i,1));
        in(i) = in(i).setVariable('k2', parameter2(i,1));
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
%         e(i,:) = simOut(i).e';
        e(i,:) = simOut(i).z1';
        ut(i,:) = simOut(i).ut';
    end
                      
%     J = sum(abs(e(:,1))) + sum(abs(ut(:,1)));
%     J = sum(abs(e),2);
%     J = sum(abs(e),2) + 0.1*sum(abs(ut),2);
    J = T_step*sum(abs(e),2)*0.2 + T_step*sum(abs(ut),2);
    output = J;

end

