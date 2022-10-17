close all;

% Design the compensator
G_c = zpk([-0.5, -0.55], [-10, -11], 34);

% Run pre-requisites
n03_Linearize;
n04_PerformanceCharacteristics;

lower_bound = p / (1 - l_m);
upper_bound = (1 - p) / l_m;
ran = {1, 100};

hold on;
bode(lower_bound, "r--", ran);
bode(upper_bound, "g--", ran);
bode(linsys, "b-", ran);
legend("Lower Bound", "Upper Bound", "System");
hold off;
