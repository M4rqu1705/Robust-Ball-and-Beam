%% SRV02 Model

% Values from table 3.1 from SRV02 User Manual
R_m = ureal("R_m", 2.6, "Percentage", 12);
L_m = 0.18E-3;
k_t = ureal("k_t", 7.68E-3, "Percentage", 12);
k_m = ureal("k_m", 7.68E-3, "Percentage", 12);
K_g = 70;
eta_m = ureal("eta_m", 0.69, "Percentage", 5);
eta_g = ureal("eta_g", 0.90, "Percentage", 10);
J_m = ureal("J_m", 3.90E-7, "Percentage", 10);
B_eq = 0.015;
J_l = 0; %% COMPLETE LATER

% Equation 1.1.18 from SRV02 Student Workbook
J_eq = eta_g * K_g^2 * J_m + J_l;

% Equation 1.1.27 from SRV02 Student Workbook
B_eq_v = eta_g * K_g^2 * eta_m *  k_t * k_m / R_m + B_eq;

% Equation 1.1.28 from SRV02 Student Workbook
A_m = eta_g * K_g * eta_m * k_t / R_m;

% Answer 1.2.3 from SRV02 Instructor Workbook
K_m = A_m / B_eq_v;

% Answer 1.2.4 from SRV02 Instructor Workbook
tau = J_eq / B_eq_v;

% Open-loop transfer function θ_L(s) / V_m(s)
% Equation 1.1.1 from SRV02 Student Workbook
G_m = tf([K_m], [tau, 1, 0]);

%% BB01 Model

% Values from table 3.1 from BB01 User Manual
g = 9.81;
L_beam = 0.4255;
r_arm = 0.00254;
m_b = 56;
r_b = 0.00127;

% Equation 2.20 from BB01 Student Workbook
K_bb = g * r_arm * r_b^2 / (7/5 * L_beam * r_b^2);

% Open-loop transfer function X(s) / θ_L(s)
% Equation 2.21 from BB01 Student Workbook
G_bb = tf([K_bb], [1, 0, 0]);