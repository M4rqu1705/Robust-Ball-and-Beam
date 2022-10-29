%% Design and test the compensator
G_c = 0.4 * tf([6.6677, 1], [0.3333]);

G_tilde = G_p_tilde * G_c;
G = G_tilde.NominalValue;

% See fundamental loop-shaping plot
close all;
region = {1E-2, 1E2};
hold on;
yline(0, "k--");
bode(p, "r--", region);
bode(1/l_m, "g--", region);
bode(G, "b-", region);
legend("p", "1/l_m", "G");
grid on;
hold off;

% Cleaning up
clear region zeroes poles