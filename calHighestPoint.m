function [H, H2] = calHighestPoint(H0H1, vel)
theta_rad = atan(vel(:,3)/ -vel(:,2));
theta_deg = rad2deg(theta_rad);

% disp("theta: "+string(round(theta_deg, 1)))

nor = norm(vel);
theta_sin =sin(theta_rad);
g = 9.81;

H2 = (nor^2*theta_sin^2)/(2*g);
H = H2 +H0H1;



