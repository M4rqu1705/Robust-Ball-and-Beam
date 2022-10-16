%% Finding the entire closed loop system representation

% Run pre-requisite programs:
n01_UncertainSystemModels;
n02_NonlinearModelEquations;

% Open Nonlinear Model
mdl = "n02_NonlinearModel";
open_system(mdl)

% Determine operating point
opspec = operspec(mdl);
% opspec.States(2).x = [0];
% opspec.States(2).Known = [1];
% opspec.States(3).x = [0];
% opspec.States(3).Known = [1];

% Collect some options for linearization
options = findopOptions("DisplayReport", "off");
op = findop(mdl, opspec, options);

% Establish input and output of system to be linearized
io(1) = linio(strcat(mdl, "/Input"), 1, "input");
% io(2) = linio(strcat(mdl, "/Ball & Beam"), 1, "output");
io(2) = linio(strcat(mdl, "/Ball & Beam"), 1, "openoutput");

% Linearize
linsys = ulinearize(mdl, io, op);

%% Finding l_m(jω) for the desired transfer function.

% Generating samples of transfer function we want to fit
samples = usample(linsys, 20);

% Fit the function. Find l_m(jω)
[tmp, Info] = ucover(samples, linsys.NominalValue, 6);
l_m = tf(Info.W1);

% Visually validate l_m(jω)
% close all;
% hold on;
% bode(linsys, "r-");
% bode(linsys.NominalValue * (1 + l_m), "g--");
% bode(feedback(G_c * feedback(10*G_m_simple.NominalValue, 1) * G_bb, 1), "b-")
% legend("Linearized System", "Linearized * (1 + l_m(jω))", "Linear System");
% hold off;