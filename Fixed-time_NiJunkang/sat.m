function [ output_args ] = sat( x, y )
%SAT 此处显示有关此函数的摘要
%   limit the amplitude of singularity term

if abs(x) < y
    output_args = x;
else
    output_args = y * sign(x);
end

end

