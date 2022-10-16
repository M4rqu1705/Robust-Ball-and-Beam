%% SRV02 Model

% Values from table 3.1 from SRV02 User Manual
R_m = ureal("R_m", 2.6, "Percentage", 12);
L_m = ureal("L_m", 0.18E-3, "Percentage", 1E-12);
k_t = ureal("k_t", 7.68E-3, "Percentage", 12);
k_m = ureal("k_m", 7.68E-3, "Percentage", 12);
K_g = 70;
eta_m = ureal("eta_m", 0.69, "Percentage", 5);
eta_g = ureal("eta_g", 0.90, "Percentage", 10);
J_m = ureal("J_m", 3.90E-7, "Percentage", 10);

% Equation 1.1.18 from SRV02 Student Workbook
J_eq = eta_g * K_g^2 * J_m + J_l;

% Equation 1.1.19 from SRV02 Student Workbook
% B_eq = eta_g * K_g^2 * B_m + B_l;
B_eq = 0.015;

% Build the denominator
denominator = [...
    ... % Third-order coefficient
    J_eq * L_m, ...
    ... % Second-order coefficient
    B_eq * L_m + R_m * J_eq, ...
    ... % First-order coefficient
    eta_g * eta_m * k_m * k_t * K_g^2 + B_eq * R_m, ...
    ... % Zeroeth-order coefficient
    0 ...
];

% Gain
K_m = eta_m * eta_g * k_t * K_g;

% Open-loop transfer function θ_L(s) / V_m(s)
% Derived by hand from equations 1.1.3, 1.1.15, 1.1.20, and 1.1.21 from SRV02 Student Workbook
G_m = tf(K_m, denominator);

%% BB01 Model

% Values from table 3.1 from BB01 User Manual
g = 9.81;
L_beam = 0.4255;
r_arm = 0.00254;
r_b = 0.00127;

% Equation 2.20 from BB01 Student Workbook
K_bb = g * r_arm * r_b^2 / (7/5 * L_beam * r_b^2);

% Open-loop transfer function X(s) / θ_L(s)
% Equation 2.21 from BB01 Student Workbook
G_bb = tf(K_bb, [1, 0, 0]);