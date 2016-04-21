function [ fx,fy,delta_x,delta_y ] = strategyC( x_bar,x_p_bar,theta_p,y_bar,y_t_bar,theta_t,theta_r,x_r_bar,y_r_bar)
x_square_bar = x_bar^2; 
y_square_bar = y_bar^2;
fx = ((x_p_bar - x_bar* (1 + theta_p^2))/ (-2 * theta_p)) + (1/2)*sqrt(((x_bar * (1 + theta_p^2) - (x_p_bar))/ theta_p)^2 - 4*(x_square_bar));
fy = (y_t_bar - y_bar* (1 + theta_t^2))/ (2 * theta_t) + (1/2)*sqrt(((y_bar * (1 + theta_t^2) - (y_t_bar))/ theta_t)^2 - 4*(y_square_bar));
A = x_bar*fy*cot(theta_r)^2-x_bar*fy*cot(theta_r)*csc(theta_r)+x_bar*fy-y_bar*fx*csc(theta_r)+fx*y_r_bar*csc(theta_r)+fy*x_r_bar*csc(theta_r)^2-fy*x_r_bar*cot(theta_r)*csc(theta_r);
B = fy*(cot(theta_r)^2+csc(theta_r)^2-2*cot(theta_r)*csc(theta_r)+1);
%delta_x = (x_bar+x_r_bar)/2;
%delta_y = (y_bar+y_r_bar)/2;
delta_x=A/B;
C=-x_bar*fy*sin(theta_r)+y_bar*fx*cos(theta_r)-fx*y_r_bar+fy*delta_x*sin(theta_r);
D=fx*(cos(theta_r)-1);
delta_y=C/D;
end