% Set up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');  
end

% Run scripts
calculate;

if strcmp(is_main, mfilename('fullpath'))
    plot_perturbations;
end

% Wrap up
if strcmp(is_main, mfilename('fullpath'))
    clear is_main
end