%% BB01 Model

% Values from table 3.1 from BB01 User Manual (p. 7)
g = 9.81;
L_beam = 0.4255;
r_arm = 0.0254;
r_b = 0.0127;

% Equation 2.20 from BB01 Student Workbook (p. 7)
K_bb = g * r_arm * r_b^2 / (7/5 * L_beam * r_b^2);

% Open-loop transfer function X(s) / θ_L(s)
% Equation 2.21 from BB01 Student Workbook (p. 8)
G_bb = tf(K_bb, [1, 0, 0]);

% Cleaning up
clear g L_beam r_arm r_b