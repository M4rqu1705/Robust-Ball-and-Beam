close all;

fig_1 = figure;
fig_2 = figure;
fig_3 = figure;

% Visualize relationship between alpha, beta, and G_p_tilde
figure(fig_1);
region = {1E-3, 1E5};
hold on;
bodemag(alpha, region, 'r--');
bodemag(beta, region, 'g--');
bodemag(G_p_tilde, region, 'b-');
legend("α(jω)", "β(jω)", "G_{p_{tilde}}");
grid on;
hold off;

% Visually validate l_m(jω)
figure(fig_2);
region = {1E-1, 1E6};
hold on;
bode(G_p_tilde, "b-", region);
bode(feedback(10 * G_m_simple, 1) * G_bb * G_f, "g-", region);
bode(G_p * (1 + l_m), "r-", region);
legend("G_{p_{tilde}}", "Simple G_p", "G_p * (1 + l_m(jω))");
grid on;
hold off;

% Analyze system nyquist plot
figure(fig_3);
region = {1E-1, 1E10};
hold on;
nyquist(G_p_tilde, region, "b--");
nyquist(G_p, region, "r-");
legend("G_{p_{tilde}}", "G_p");
grid on;
hold off;

% Cleaning up
clear region fig_1 fig_2 fig_3