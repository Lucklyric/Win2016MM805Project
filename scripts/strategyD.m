function [ fx,fy,delta_x,delta_y ] = strategyD( x_bar,x_p_bar,y_bar,y_t_bar,theta_t,theta_p,x_r_bar,y_r_bar)
%STRATEGYD This function is implemented the strategy D
%   It returns the fx fy delta_x and delta_y
delta_x = (x_bar+x_r_bar)/2;
delta_y = (y_bar+y_r_bar)/2;

Ay = 4*theta_t*(delta_x^2*(-theta_t)+2*theta_t*y_bar*delta_y-theta_t*(y_bar^2));
By = (theta_t^2)*delta_y-y_bar*(theta_t^2+1)+y_t_bar;
fy = (sqrt(Ay+By^2)+By)/(2*theta_t);

Ax = 4*theta_p*(2*delta_x*theta_p*x_bar-theta_p*delta_y^2-theta_p*x_bar^2);
Bx = (theta_p^2)*delta_x-x_bar*(theta_p^2+1)+x_p_bar;
fx = (sqrt(Ax+Bx^2)-Bx)/(2*theta_p);
end

