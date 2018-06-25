function sigma_a = fun_sigma_a( rho, phi, Ci, R, w, a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    sigma_a = (rho *(phi - Ci) - R ) / (rho * a * R - rho * phi - R + w*R);
end
