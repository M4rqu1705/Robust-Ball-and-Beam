close all;

% Generate bode plots to visually validate result.
figure("Name", "Performance Function",...
    "NumberTitle", "off",...
    "Units", "normalized",...
    "Position", [0, 0.04, 1, 0.875]);
region = {omega_n / 100, 100 * omega_n};
hold on;
bodemag(p, region);
bodemag(G_p / tf(omega_n^2, [1, 2*zeta*omega_n, omega_n^2]), region);
bodemag(zpk([], [], 2*sind(60/2)), region, "r--");
bodemag(zpk([], [], 2*sind(30/2)), region, "g--");
bodemag(zpk([], [], 2*sind(15/2)), region, "b--");
xline(omega_disturbances, "k--");
legend("p(jω)", "Second Order System", "60° φ_m", "30° φ_m", "15° φ_m", "ω_{desired}");
grid on;
hold off;

% Cleaning up
clear region