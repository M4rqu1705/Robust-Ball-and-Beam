% Setting up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');  
end

calculate;

if strcmp(is_main, mfilename('fullpath'))
    plot_perturbations;
end

% Wrapping up
if strcmp(is_main, mfilename('fullpath'))
    clear is_main
end