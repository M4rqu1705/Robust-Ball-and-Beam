% Setting up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');  
end

performance_specifications;
performance_function;

if strcmp(is_main, mfilename('fullpath'))
    plot_performance;
end

% Wrapping up
if strcmp(is_main, mfilename('fullpath'))
    clear is_main
end