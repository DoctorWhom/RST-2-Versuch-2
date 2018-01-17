function [ x1, x2, u ] = trajectorystates(time, y_desired,dydt,d2ydt2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    load Modellparameter.mat;
    mu = 5.5e-04;
    a = (Ke*Km)/(J * R) +mu/ J;
    b = (Km * V)/(J * R);
    
    A = [0,1;0,-a];
    
    x1 = y_desired;
    x2 = dydt;
    
    u = [0, 1/b] * ([dydt;d2ydt2] - [y_desired;-a*dydt]);

end

