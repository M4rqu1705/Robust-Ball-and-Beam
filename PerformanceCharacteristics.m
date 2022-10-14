%% Finding p(jω) for the desired performance characteristics

% %O.S
os = 10;

% Settling time (
ts = 5;

% Finding omega and zeta
% Equation 4.4-13 (p. 191)
zeta = -log(os / 100) / sqrt(pi^2 + log(os / 100)^2);
% Equation 4.4-14 (p. 191)
omega_n = -log(2 / 100) / (ts * zeta);
% Damped Frequency (p. 190)
omega_d = omega_n * sqrt(1 - zeta^2);

% Finding the positions of the poles
% Equation 4.4-5 (p. 189)
p_1 = -zeta*omega_n + omega_d*i;
p_2 = -zeta*omega_n - omega_d*i;

% Finding approximate cutoff frequency (p. 239)
omega_c = omega_n;

% Finding phase margin (derived on my own by solving |G(jω)| == 1 and finding arg(G(jω))
%phi_m = -angle(1 - 4 * zeta^2*(1 - j));

% Finding M circle
% Equation 6.5-13 (p. 328)
% M_c = 1 / (2*sin(phi_m/2));

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
% 1) p(s) has 2 poles on s = -omega_n
% 2) p(s) should be close to 1 for low frequencies
% (Steady state response performance requirement)
% 3) p(s) must jave a pole at the origin.
% (Other Loop-shaping requirements)
% 4) p(s) must have a slope of -20 db/dec for 2/3 decades around the crossover frequency
% 5) p(s) must have phase margin close to 60 deg
% 6) p(s) must have high gain margin

close all; hold on;
margin(zpk([-omega_n/10], [0, p_1, p_2], 2*zeta*omega_n))
bode(zpk([], [p_1, p_2], omega_n^2))
hold off;