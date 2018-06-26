function sigma_b = fun_sigma_b( rho, Cd, R, w, a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    sigma_b = (w*R + Cd + R ) / (rho * R*(a + w + 2));
end
