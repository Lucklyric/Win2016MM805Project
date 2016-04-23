function [ fx,fy,delta_x,delta_y ] = strategyD( x_bar,x_p_bar,y_bar,y_t_bar,theta_t,theta_p,x_r_bar,y_r_bar)
%STRATEGYD Summary of this function goes here
%   Detailed explanation goes here
delta_x = (x_bar+x_r_bar)/2;
delta_y = (y_bar+y_r_bar)/2;


% Ay = 4*theta_t*(-theta_t*(y_bar^2)+2*theta_t*y_bar*delta_y-theta_t*(delta_y^2));
% By = theta_t^2*(-y_bar)-y_bar+y_t_bar+(theta_t^2)*delta_y;
% fy = (sqrt(Ay+By^2)+By)/(2*theta_t);
% 
% Ax = 4*theta_p*(-theta_p*(x_bar^2)+2*theta_p*x_bar*delta_x-theta_p*(delta_x^2));
% Bx = theta_p^2*(-x_bar)-x_bar+x_p_bar+(theta_p^2)*delta_x;
% fx = (sqrt(Ax+Bx^2)-Bx)/(2*theta_p);
Ay = 4*theta_t*(delta_x^2*(-theta_t)+2*theta_t*y_bar*delta_y-theta_t*(y_bar^2));
By = (theta_t^2)*delta_y-y_bar*(theta_t^2+1)+y_t_bar;
fy = (sqrt(Ay+By^2)+By)/(2*theta_t);

Ax = 4*theta_p*(2*delta_x*theta_p*x_bar-theta_p*delta_y^2-theta_p*x_bar^2);
Bx = (theta_t^2)*delta_x-x_bar*(theta_p^2+1)+x_p_bar;
fx = (sqrt(Ax+Bx^2)-Bx)/(2*theta_p);
end

