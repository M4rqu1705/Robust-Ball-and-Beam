% Design the compensator
G_c = zpk([0.1, 0.2, 100, 110], [0.0001, 0.0002, 2.5, 3], 0.01);

% Run pre-requisites
% n03_Linearize;
% n04_PerformanceCharacteristics;

lower_bound = p;
upper_bound = 1 / l_m;
ran = {1E-2, 1E4};

close all;
hold on;
bode(lower_bound, "r--", ran);
bode(upper_bound, "g--", ran);
bode(G_c * linsys.NominalValue, "b-", ran);
legend("Lower Bound", "Upper Bound", "System");
hold off;

T = feedback(G_c * linsys.NominalValue, 1) * G_l;
S = 1 - T;
bodemag(S * p + T / l_m);
