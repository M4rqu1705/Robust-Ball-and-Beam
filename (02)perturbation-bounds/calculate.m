%% Finding l_m(jω) for the desired transfer function.
% Note: This procedure to find l_m(jω) was heavily based on Rohrs, Melsa, and
%       Shultz (p. 275 - 277), and inspired by C. G. Bolivar Vicenty, K. Z. 
%       Rosa Medina, and G. Beauchamp Baez in their paper “Control Robusto del
%       Sistema de Bola y Viga” (p. 6)

% Generating samples of G_p_tilde (which is the linearized system)
samples = usample(G_p_tilde, 500);

% Fit the function. Confirm G_p_tilde(s) and find error from the nominal model.
[~, Info] = ucover(samples, G_p, 4);

% Equation 5.6-5 from Rorhs, Melsa, and Shcultz (p. 275)
alpha = G_p * (1 - Info.W1*3);
beta = G_p * (1 + Info.W1*3);

% Uncertain dynamics kick in at 3 rad/s (Bolivar Vicenty, et al. p. 6)
alpha = alpha * zpk([], -3, 3);
beta = beta * 1 / zpk([], -3, 3);

% Equation 5.6-6 from Rorhs, Melsa, Shcultz (p. 275)
l_m = (beta - alpha) / (2 * G_p);
l_m = 1/minreal(1/l_m);

% Cleaning up
clear Info samples

