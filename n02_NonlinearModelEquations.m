%% Set up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');

    % Run pre-requisite programs
    n01_UncertainSystemModels;
end

%% Higher-order SRV02 Model
% Note: This model was derived by hand from equations 1.1.3, 1.1.15, 1.1.20,
%       and 1.1.21 from SRV02 Student Workbook (p. 2-4)


% Retrieve relevant values and important results from script
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
G_m_tilde = tf(K_m, denominator);

%% Wrap up
if is_main == mfilename('fullpath')
    clear is_main
end