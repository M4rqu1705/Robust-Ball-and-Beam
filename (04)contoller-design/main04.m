% Setting up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');  
end

design;

if strcmp(is_main, mfilename('fullpath'))
    plot_results;
end

% Wrapping up
if strcmp(is_main, mfilename('fullpath'))
    clear is_main
end