function [ output_args ] = sat( x, y )
%SAT �˴���ʾ�йش˺�����ժҪ
%   limit the amplitude of singularity term

if abs(x) < y
    output_args = x;
else
    output_args = y * sign(x);
end

end

