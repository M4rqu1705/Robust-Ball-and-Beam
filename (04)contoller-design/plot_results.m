close all;

fig_1 = figure;
fig_2 = figure;
fig_3 = figure;
fig_4 = figure;
fig_5 = figure;

% See fundamental loop-shaping plot
figure(fig_1);
region = {1E-2, 1E2};
hold on;
yline(0, "k--");
bodemag(p, "r--", region);
bodemag(1/l_m, "g--", region);
bodemag(G, "b-", region);
legend("0dB", "p", "1/l_m", "G");
grid on;
hold off;

% Visualize some robustness stability criteria
figure(fig_2)
region = {1E-2, 1E2};
hold on;
T = feedback(G_bb * feedback(G_m_tilde * 10, 1) * G_c, G_f_tilde) * G_f_tilde * G_l_tilde;
S = 1 - T;
bodemag(T, region);
bodemag(1/l_m, region);
bodemag(S, region);
bodemag(1/p, region);
legend("T", "1/l_m", "S", "1/p");
grid on;
hold off;

% Visualize THE robustness stability criterion
figure(fig_3);
region = {1E-10, 1E10};
hold on;
yline(0, "k--");
bodemag(S*p + T*l_m, region);
grid on;
hold off;

% Visualize closed-loop step response
% Visualize open-loop stability with Nyquist
figure(fig_4);
hold on;
step(G_tilde);
grid on;
hold off;

% Visualize open-loop stability with Nyquist
figure(fig_5);
region = {1E-1, 1E10};
hold on;
nyquist(G_tilde, region, "b--");
nyquist(G, region, "r-");
legend("G_{tilde}", "G");
grid on;
hold off;


% Cleaning up
clear region fig_1 fig_2 fig_3 fig_4 fig_5