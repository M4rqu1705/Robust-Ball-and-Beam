%% SRV02 Model

% Retrieve the values from table 3.1 from SRV02 User Manual
n01_UncertainSystemModels;

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