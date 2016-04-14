function [ fx ] = strategyC( x_bar,x_square_bar,x_p_bar,x_p_square_bar,theta_p)
%STRATEGYC Summary of this function goes here
%   Detailed explanation goes here
fx = (x_p_bar - x_bar* (1 + theta_p^2))/ 2 * theta_p + (1/2)*sqrt(((x_bar * (1 + theta_p^2) - (x_p_square_bar))/ theta_p)^2 - 4*(x_square_bar));

end