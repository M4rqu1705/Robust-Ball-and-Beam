%% Finding the open-loop system representation
% Note: This procedure to find G_p(s) was inspired by C. G. Bolivar Vicenty,
%       K. Z. Rosa Medina, and G. Beauchamp Baez in their paper "Control
%       Robusto del Sistema de Bola y Viga” (p. 6)

% Open Nonlinear Model
mdl = "nonlinear_model";
open_system(mdl)

% Temporarily remove compensator from model
compensator = get_param(strcat(mdl, "/Ball & Beam Compensator"), "sys");
set_param(strcat(mdl, "/Ball & Beam Compensator"), "sys", "1");

% Retrieve Operating Point (by default 0)
opspec = operspec(mdl);

% Collect some options for linearization
options = findopOptions("DisplayReport", "off");
op = findop(mdl, opspec, options);

% Establish input and output of system to be linearized
% We want to convert the system from one in H-configuration to one in
% G-configuration (Rohrs, Melsa, Schultz p. 108). Therefore we'll linearize GH.
io(1) = linio(strcat(mdl, "/Ball & Beam Compensator"), 1, "input");
io(2) = linio(strcat(mdl, "/Follower Potentiometer Quantizer"), 1, "openoutput");

% Linearize
G_p_tilde = ulinearize(mdl, io, op);

% Extract minimal nominal model
G_p = zpk(minreal(G_p_tilde.NominalValue));

% Clean up
set_param(strcat(mdl, "/Ball & Beam Compensator"), "sys", compensator);
clear mdl opspec options op io compensator