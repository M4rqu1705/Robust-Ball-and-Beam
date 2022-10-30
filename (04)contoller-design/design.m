%% Design and test the compensator
% Important criteria
% 1) Cutoff frequency < 3 rad/s (p. 429, parr. 3)
% 2) Crossover magnitude slope of -20 dB/dec or less (if possible)

% G_c = 0.075 * zpk([-1E-1], [-1E1], 100) * zpk([-5E-2], [-5E-3], 10); % Alberto
% G_c = 0.12 * zpk([-1E-1], [-1E1], 100) * zpk([-5E-2], [-5E-3], 10); % Dylan
zeroes = [-0.1, -100];
poles = [-10, -11];
G_c = zpk(zeroes, poles, 1 / K_bb * abs(prod(poles) / prod(zeroes)));
G_c = zpk([-0.4], [-10], 62.5);

G_tilde = G_p_tilde * G_c;
G = zpk(G_tilde.NominalValue);

% See fundamental loop-shaping plot
close all;
region = {1E-5, 1E5};
hold on;
bode(p, "r--", region);
bode(1/l_m, "g--", region);
margin(G, region);
legend("p", "1/l_m", "G");
grid on;
hold off;

% Cleaning up
clear region zeroes poles