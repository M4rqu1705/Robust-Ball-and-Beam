% Setting up
if ~exist("is_main", "var")
    is_main = mfilename('fullpath');  
end

SRV02;
BB01;
SS01;
linearize_plant;

% Wrapping up
if strcmp(is_main, mfilename('fullpath'))
    clear is_main
end