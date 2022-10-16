%% Finding p(jω) for the desired performance characteristics

% %O.S
os = 20;

% Settling time (s)
ts = 3;

% Finding omega and zeta
% Equation 4.4-13 (p. 191)
zeta = abs(log(os / 100)) / sqrt(pi^2 + log(os / 100)^2);
% Equation 4.4-14 (p. 191)
omega_n = abs(log(2 / 100)) / (ts * zeta);
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

%% Determining p(jω)

% Criteria:
% (Transient response performance requirements)
% 1) p(s) has response similar to second order systems for low frequencies
% 2) p(s) should be close to 1 for operating frequencies
% (Steady state response performance requirement)
% 3) p(s) must jave a pole at the origin.
% (Other Loop-shaping requirements)
% 4) p(s) must have a slope of -20 db/dec for 2/3 decades around the crossover frequency
% 5) p(s) must have phase margin greater than 60 deg
% 6) p(s) must have high gain margin for low frequencies

% Obtain required K to meet criteria number 2
syms s complex
syms K_sym positive
syms zeta_sym real
syms omega_n_sym real
p(s) = K_sym * (s + omega_n_sym /  100) / (s * (s^2 + 2*zeta_sym*omega_n_sym*s + omega_n_sym^2));
K_res = solve(abs(p(1j*omega_n_sym / 10)) == 1, K_sym);
K_res = simplify(expand(K_res), "IgnoreAnalyticConstraints", true, "Criterion", "preferReal");
K = double(subs(K_res, [zeta_sym, omega_n_sym], [zeta, omega_n]));

% Generate bode plots to visually validate result. 
close all; hold on;
margin(zpk(-omega_n/100, [0, p_1, p_2], K));
bode(zpk([], [p_1, p_2], omega_n^2));
hold off;