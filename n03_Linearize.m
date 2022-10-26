%% Finding the entire closed loop system representation

% Run pre-requisite programs:
n01_UncertainSystemModels;
n02_NonlinearModelEquations;

% Open Nonlinear Model
mdl = "n02_NonlinearModel";
open_system(mdl)

% Retrieve Operating Point (by default 0)
opspec = operspec(mdl);

% Collect some options for linearization
options = findopOptions("DisplayReport", "off");
op = findop(mdl, opspec, options);

% Establish input and output of system to be linearized
io(1) = linio(strcat(mdl, "/Ball & Beam Compensator"), 1, "input");
io(2) = linio(strcat(mdl, "/Follower Potentiometer Quantizer"), 1, "openoutput");

% Linearize
linsys = ulinearize(mdl, io, op);

%% Finding l_m(jω) for the desired transfer function.

% Generating samples of transfer function we want to fit
samples = usample(linsys, 100);

% Fit the function. Find l_m(jω)
[tmp, Info] = ucover(samples, linsys.NominalValue, 4);
l_m = tf(Info.W1);

% Visually validate l_m(jω)
close all;
ran = {1E-1, 1E5};
hold on;
bode(linsys, "r-", ran);
bode(feedback(10 * G_m_simple.NominalValue, 1) * G_bb, "b-", ran);
bode(linsys.NominalValue * (1 + l_m), "g-", ran);
legend("Linearized Perturbed System", "Simple Linear System", "Perturbed System Upper Bound");
set(findall(gcf, 'type', 'line'), 'linewidth', 1)
hold off;