% Set up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');  
end

% Run scripts
SRV02;
BB01;
SS01;
linearize_plant;

% Wrap up
if strcmp(is_main, mfilename('fullpath'))
    clear is_main
end