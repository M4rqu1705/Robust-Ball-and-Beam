%% Set up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');
    
    % Run pre-requisite programs
    n01_UncertainSystemModels;
    n02_NonlinearModelEquations;
    
    G_c = zpk(1); % Temporary compensator ...
end

%% Finding the open-loop system representation
% Note: This procedure to find G_p(s) was inspired by C. G. Bolivar Vicenty,
%       K. Z. Rosa Medina, and G. Beauchamp Baez in their paper "Control
%       Robusto del Sistema de Bola y Viga” (p. 6)

% Open Nonlinear Model
mdl = "n02_NonlinearModel";
open_system(mdl)

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
linearized_system = ulinearize(mdl, io, op);

%% Finding l_m(jω) for the desired transfer function.
% Note: This procedure to find l_m(jω) was heavily based on Rohrs, Melsa, and
%       Shultz (p. 275 - 277), and inspired by C. G. Bolivar Vicenty, K. Z. 
%       Rosa Medina, and G. Beauchamp Baez in their paper “Control Robusto del
%       Sistema de Bola y Viga” (p. 6)

% Generating samples of G_p_tilde (which is the linearized system)
samples = usample(linearized_system, 500);

% Fit the function. Confirm G_p_tilde(s) and find error from the nominal model.
[G_p_tilde, Info] = ucover(samples, linearized_system.NominalValue, 4);

% Extract minimal nominal model
G_p = zpk(minreal(G_p_tilde.NominalValue));

% Equation 5.6-5 from Rorhs, Melsa, and Shcultz (p. 275)
alpha = G_p * (1 - Info.W1*3);
beta = G_p * (1 + Info.W1*3);

% Uncertain dynamics kick in at 3 rad/s (Bolivar Vicenty, et al. p. 6)
alpha = alpha * zpk([], -3, 3);
beta = beta * 1 / zpk([], -3, 3);

% Equation 5.6-6 from Rorhs, Melsa, Shcultz (p. 275)
l_m = (beta - alpha) / (2 * G_p);
l_m = 1/minreal(1/l_m);

if is_main == mfilename('fullpath')
    close all;

    % Visually validate l_m(jω)
    region = {1E-1, 1E5};
    hold on;
    bode(linearized_system, "r-", region);
    bode(feedback(10 * G_m_simple.NominalValue, 1) * G_bb, "b-", region);
    bode(linearized_system.NominalValue * (1 + l_m), "g-", region);
    legend("G_p_tilde", "Simple G_p", "G_p * (1 + l_m(jω))");
    hold off;
end

%% Wrap up
if is_main == mfilename('fullpath')
    clear is_main
end