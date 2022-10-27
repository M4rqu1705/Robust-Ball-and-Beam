%% SS01 Model
% Note: No manual was found for SS01 Remote Sensing Module.
%       These results are based on measurements.

% Leader (master) Low-pass RC Filter
R_l = ureal("R_l", 240, "Percentage", 1);
C_l = ureal("C_l", 1E-6, "Percentage", 20);
tau_l = R_l * C_l;
G_l_tilde = tf(1, [tau_l, 1]);
G_l = G_l_tilde.NominalValue;

% Follower (slave) Low-pass RC Filter
R_f = ureal("R_f", 3.6E3, "Percentage", 1);
C_f = ureal("C_f", 1E-6, "Percentage", 20);
tau_f = R_f * C_f;
G_f_tilde = tf(1, [tau_f, 1]);
G_f = G_f_tilde.NominalValue;

% Cleaning up
clear R_l C_l R_f C_f