%% Finding l_m for the desired transfer function.

% Generating samples of transfer function we want to fit
samples = usample(G_m, 100);

% Fit the function. Find l_m
[tmp, Info] = ucover(samples, G_m.NominalValue, 4);
l_m = tf(Info.W1);

% Visually validate l_m
close all;
hold on;
bodemag(G_m);
bodemag(G_m.NominalValue * (1 + l_m));
hold off;