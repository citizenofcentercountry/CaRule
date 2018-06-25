function rho = fun_rho( Cd, R, w, a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    rho = (Cd + R * (1 + w)) / ((2 + a + w) * R);
end

