function [ fx,fy ] = strategyC( x_bar,x_square_bar,x_p_bar,theta_p,y_bar,y_square_bar,y_t_bar,theta_t)
fx = ((x_p_bar - x_bar* (1 + theta_p^2))/ (-2 * theta_p)) + (1/2)*sqrt(((x_bar * (1 + theta_p^2) - (x_p_bar))/ theta_p)^2 - 4*(x_square_bar));
fy = (y_t_bar - y_bar* (1 + theta_t^2))/ (2 * theta_t) + (1/2)*sqrt(((y_bar * (1 + theta_t^2) - (y_t_bar))/ theta_t)^2 - 4*(y_square_bar));
end