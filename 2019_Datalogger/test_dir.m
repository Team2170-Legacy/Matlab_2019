top_dir         = pwd;

dirmask_top     = 'Log_*.txt';

dir_content_top = dir( [ top_dir '\' dirmask_top ] );

num_dir_top     = length(dir_content_top);

disp('Last log file is')

name = dir_content_top(num_dir_top).name
