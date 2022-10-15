%% Finding the entire closed loop system representation

% Open Nonlinear Model
mdl = "NonlinearModel"
open_system(mdl)

% Determine operating point
opspec = operspec(mdl);
opspec.States(3).Known = [1, 1];

% Collect some options for linearization
options = findopOptions("DisplayReport", "off");
op = findop(mdl, opspec, options);

% Establish input and output of system to be linearized
io(1) = linio(strcat(mdl, "/IL Sum"), 1, "input");
io(2) = linio(strcat(mdl, "/Frequency Limiter"), 1, "openoutput");

% Linearize
linsys = ulinearize(mdl, io, op)