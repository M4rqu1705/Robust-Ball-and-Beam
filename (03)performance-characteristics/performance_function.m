%% Determining p(jω) from the desired performance characteristics
% Note: This procedure to find p(jω) was heavily based on Rohrs, Melsa, and
%       Shultz (p. 346 - 349)

if false

    % Obtain required K to meet criteria number 2
    syms s complex
    syms K_sym positive
    syms zeta_sym real
    syms omega_n_sym real
    p_sym(s) = K_sym * (s + omega_n_sym /  100) * (s + omega_n_sym / 1000) / (s^2 * (s^2 + 2*zeta_sym*omega_n_sym*s + omega_n_sym^2));
    K_res = solve(abs(p_sym(1j*omega_n_sym / 10)) == 1, K_sym);
    K_res = simplify(expand(K_res), "IgnoreAnalyticConstraints", true, "Criterion", "preferReal");
    K = double(subs(K_res, [zeta_sym, omega_n_sym], [zeta, omega_n]));

    [num, den] = numden(subs(p_sym(s), [K_sym, zeta_sym, omega_n_sym], [K, zeta, omega_n]));
    p = zpk(tf(sym2poly(num), sym2poly(den)));
    
    % Cleaning up
    clear s K_sym zeta_sym omega_n_sym p_sym K_res K num den
else
    p = zpk([-3, -3.1], [0, 0], 1/100);
end