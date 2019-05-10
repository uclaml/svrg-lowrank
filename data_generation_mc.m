function [M_star] = data_generation_mc(d1,r)

% Generate M* 
 U_star = randn(d1,r) / sqrt(d1); 
 %V_star = randn(d2,r) / sqrt(d2);
M_star = U_star*U_star';
end

