%% Design and test the compensator
zeroes = [];
poles = [];
G_c = zpk(zeroes, poles, 1 * abs(prod(poles) / prod(zeroes)));

G_tilde = G_p_tilde * G_c;
G = G_tilde.NominalValue;

% See fundamental loop-shaping plot
close all;
region = {1E-2, 1E2};
hold on;
yline(0, "k--");
bodemag(p, "r--", region);
bodemag(1/l_m, "g--", region);
bodemag(G, "b-", region);
legend("0dB", "p", "1/l_m", "G");
grid on;
hold off;

% Cleaning up
clear region zeroes poles