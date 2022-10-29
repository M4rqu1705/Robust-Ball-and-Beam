%% SRV02 Model

%% Simple SRV02 Model

% Values from table 3.1 from SRV02 User Manual (p. 11)
R_m = ureal("R_m", 2.6, "Percentage", 12);
L_m = 0.18E-3;
k_t = ureal("k_t", 7.68E-3, "Percentage", 12);
k_m = ureal("k_m", 7.68E-3, "Percentage", 12);
K_g = 70;
eta_m = ureal("eta_m", 0.69, "Percentage", 5);
eta_g = ureal("eta_g", 0.90, "Percentage", 10);
J_m = ureal("J_m", 3.90E-7, "Percentage", 10);

% Equation 1.1.18 from SRV02 Student Workbook (p. 4)
J_eq = eta_g * K_g^2 * J_m;

% Equation 1.1.19 from SRV02 Student Workbook (p. 4)
% B_eq = eta_g * K_g^2 * B_m + B_l;
B_eq = 0.015;

% Equation 1.1.27 from SRV02 Student Workbook (p. 5)
B_eq_v = eta_g * K_g^2 * eta_m *  k_t * k_m / R_m + B_eq;

% Equation 1.1.28 from SRV02 Student Workbook (p. 5)
A_m = eta_g * K_g * eta_m * k_t / R_m;

% Answer 1.2.3 from SRV02 Instructor Workbook (p. 8)
K_m_simple = A_m / B_eq_v;

% Answer 1.2.4 from SRV02 Instructor Workbook (p. 8)
tau_simple = J_eq / B_eq_v;

% Open-loop transfer function θ_L(s) / V_m(s)
% Equation 1.1.1 from SRV02 Student Workbook (p. 2)
G_m_simple_tilde = tf(K_m_simple, [tau_simple, 1, 0]);
G_m_simple = tf(G_m_simple_tilde.NominalValue);

%% Higher-order SRV02 Model
% Note: This model was derived by hand from equations 1.1.3, 1.1.15, 1.1.20,
%       and 1.1.21 from SRV02 Student Workbook (p. 2-4)

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

% Motor gain
K_m = eta_m * eta_g * k_t * K_g;

% Open-loop transfer function θ_L(s) / V_m(s)
G_m_tilde = tf(K_m, denominator);
G_m = tf(G_m_tilde.NominalValue);

% Cleaning up
clear R_m L_m k_t k_m K_g eta_m eta_g J_m J_eq B_eq B_eq_v A_m denominator