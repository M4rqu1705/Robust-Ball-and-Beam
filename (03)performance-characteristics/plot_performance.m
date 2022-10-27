close all;

% Generate bode plots to visually validate result. 
region = {omega_n / 100, 100 * omega_n};
hold on;
bodemag(p, region);
bodemag(tf([omega_n^2], [1, 2*zeta*omega_n, omega_n^2]), region);
legend("p(jω)", "Second Order System");
grid on;
hold off;

% Cleaning up
clear region