%% Design and test the compensator
% Important criteria
% 1) Cutoff frequency < 3 rad/s (p. 429, parr. 3)
% 2) Crossover magnitude slope of -20 dB/dec or less (if possible)

% G_c = 0.075 * zpk([-1E-1], [-1E1], 100) * zpk([-5E-2], [-5E-3], 10); % Alberto
% G_c = 0.12 * zpk([-1E-1], [-1E1], 100) * zpk([-5E-2], [-5E-3], 10); % Dylan
G_c = zpk([-1E-2, -2E-2], [-1E-1, -2E-1], 1E4);


G_tilde = G_p_tilde * G_c;
G = G_tilde.NominalValue;

% See fundamental loop-shaping plot
close all;
region = {1E-2, 1E2};
hold on;
bode(p, "r--", region);
bode(1/l_m, "g--", region);
margin(G, region);
legend("p", "1/l_m", "G");
grid on;
hold off;

% Cleaning up
clear region zeroes poles