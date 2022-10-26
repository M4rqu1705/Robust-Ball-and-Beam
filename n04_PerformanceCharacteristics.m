%% Set up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');
    
    % Run pre-requisite programs
    n01_UncertainSystemModels;
    n02_NonlinearModelEquations;
end

%% Determine the performance characteristics

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

%% Determining p(jω) fromm the desired performance characteristics
% Note: This procedure to find p(jω) was heavily based on Rohrs, Melsa, and
%       Shultz (p. 346 - 349)

if false

    % Obtain required K to meet criteria number 2
    syms s complex
    syms K_sym positive
    syms zeta_sym real
    syms omega_n_sym real
    p_sym(s) = K_sym * (s + omega_n_sym /  100) * (s + omega_n_sym / 1000) / (s^2 * (s^2 + 2*zeta_sym*omega_n_sym*s + omega_n_sym^2));
    K_res = solve(abs(p_sym(1j*omega_n_sym / 10)) == 1, K_sym);
    K_res = simplify(expand(K_res), "IgnoreAnalyticConstraints", true, "Criterion", "preferReal");
    K = double(subs(K_res, [zeta_sym, omega_n_sym], [zeta, omega_n]));

    [num, den] = numden(subs(p_sym(s), [K_sym, zeta_sym, omega_n_sym], [K, zeta, omega_n]));
    p = zpk(tf(sym2poly(num), sym2poly(den)));
else
    p = zpk([-3, -3.1], [0, 0], 0.1);
end

if is_main == mfilename('fullpath')
    close all;

    % Generate bode plots to visually validate result. 
    region = {omega_n / 100, 100 * omega_n};
    hold on;
    bodemag(p, region);
    bodemag(zpk([], [p_1, p_2], omega_n^2), region);
    legend("p(jω)", "Second Order System");
    hold off;
end

%% Wrap up
if is_main == mfilename('fullpath')
    clear is_main
end