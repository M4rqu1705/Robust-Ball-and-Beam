%% Set up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');
    
    % Run pre-requisite programs
    n01_UncertainSystemModels;
    n02_NonlinearModelEquations;
    n03_Linearize;
    n04_PerformanceCharacteristics;
end


%% Design and test the compensator
zeroes = [];
poles = [];
G_c = zpk(zeroes, poles, 1 * abs(prod(poles) / prod(zeroes)));

G_tilde = G_p_tilde * G_c;
G = G_tilde.NominalValue;

ran = {1E-2, 1E2};


if is_main == mfilename('fullpath')
    close all;

    if true
        hold on;
        yline(0, "k--");
        bodemag(p, "r--", ran);
        bodemag(1/l_m, "g--", ran);
        bodemag(G, "b-", ran);
        legend("0dB", "p", "1/l_m", "G");
        grid on;
        hold off;
    else
        hold on;
        T = feedback(G_bb * feedback(G_m_tilde * 10, 1) * G_c, G_f_tilde) * G_f_tilde * G_l_tilde;
        S = 1 - T;
        bodemag(T);
        bodemag(1/l_m);
        bodemag(S);
        bodemag(1/p);
        legend("T", "l_m", "S", "1/p");
        % bodemag(S*p + T*l_m);
        grid on;
        hold off;
    end
end

%% Wrap up
if is_main == mfilename('fullpath')
    clear is_main
end