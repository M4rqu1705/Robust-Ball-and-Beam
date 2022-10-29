close all;

% Visualize relationship between alpha, beta, and G_p_tilde
figure("Name", "Uncertainty Regions: Bode Magnitude",...
    "NumberTitle", "off",...
    "Units", "normalized",...
    "Position", [0, 0.52, 0.5, 0.39]);
region = {1E-3, 1E5};
hold on;
bodemag(alpha, region, 'r--');
bodemag(beta, region, 'g--');
bodemag(G_p_tilde, region, 'b-');
legend("α(jω)", "β(jω)", "G_{p_{tilde}}");
grid on;
hold off;

% Visually validate l_m(jω)
figure("Name", "Validate l_m(jω)",...
    "NumberTitle", "off",...
    "Units", "normalized",...
    "Position", [0.5, 0.52, 0.5, 0.39]);
region = {1E-1, 1E6};
hold on;
bode(G_p_tilde, "b-", region);
bode(feedback(10 * G_m_simple, 1) * G_bb * G_f, "g-", region);
bode(G_p * (1 + l_m), "r-", region);
legend("G_{p_{tilde}}", "Simple G_p", "G_p * (1 + l_m(jω))");
grid on;
hold off;

% Analyze plant's nyquist plot
figure("Name", "G_p Nyquist",...
    "NumberTitle", "off",...
    "Units", "normalized",...
    "Position", [0, 0.045, 0.5, 0.39]);
region = {1E-1, 1E10};
hold on;
nyquist(G_p_tilde, region, "b--");
nyquist(G_p, region, "r-");
legend("G_{p_{tilde}}", "G_p");
grid on;
hold off;

% Cleaning up
clear region sw sh