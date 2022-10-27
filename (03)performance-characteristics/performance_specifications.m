%% Determine the performance specifications

% %O.S
os = 20;

% Settling time (s)
Ts = 3;

% Finding omega and zeta
% Equation 4.4-13 (p. 191)
zeta = abs(log(os / 100)) / sqrt(pi^2 + log(os / 100)^2);
% Equation 4.4-14 (p. 191)
omega_n = abs(log(2 / 100)) / (Ts * zeta);
% Damped Frequency (p. 190)
omega_d = omega_n * sqrt(1 - zeta^2);

% Finding the positions of the poles
% Equation 4.4-5 (p. 189)
p_1 = -zeta*omega_n + 1j*omega_d;
p_2 = -zeta*omega_n - 1j*omega_d;

% Finding approximate cutoff frequency (p. 239)
omega_c = omega_n;

% Finding peak frequency and magnitude
omega_p = 0; M_p = 0;
if zeta < sqrt(2) / 2
    % Equation 5.3-8 (p. 239)
    omega_p = omega_n * sqrt(1 - 2*zeta^2);
    % Equation 5.3-9 (p. 239)
    M_p = 1 / (2 * zeta * sqrt(1 - zeta^2));
else
    % Approximating it
    omega_p = omega_n;
    % Equation 5.3-10 (p. 240)
    M_p = 1 / (2 * zeta);
end

% Cleaning up
clear p_1 p_2