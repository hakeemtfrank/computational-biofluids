% test sim %
close all; clear all; clc; format short;
 
outfile = fopen('simulation_data.txt','wt');
 
x = 0;
n_count = 0;
targetmaram = 4.6;

while x < targetparam,
    x = log(100*rand(1));
    n_count = n_count + 1;
    fprintf(outfile,'%10d %+6.3f\n',n_count,x);
    
    if abs(n_count - 300) < 1e-9, % if the random tries is almost 300
        break;
    end;
    %  Always include an escape for a while loop
    %  in case you screw up the programming.  Otherwise,
    %  you might get caught in an infinite loop.
    
end;
 
if n_count < 300,
    disp(['Iterations to break parameter: ',num2str(n_count)]);

else
    disp('Break simulation');
end;
 
fclose(outfile);

