% testscript

close all; clear all; clc; format short;

output_file = fopen('matrix_data.txt','wt');

a = -100; % beginning number in interval
b = 100; % end number in interval
r = a + (b-a).*rand(1000,4); % random numbers generated btwn a and b

matrix_input = r; % matrix of rsandoms 
new_matrix = zeros(1000,4); % empty matrix for new numbers
entries = numel(matrix_input); % number of entries in the matrix

for i = 1:entries
    if mod(matrix_input,2) == 0; % if the entry is an even number
        new_matrix(i) = matrix_input(i)*7; % then multiply it by 7
    else 
        new_matrix(i) = matrix_input(i)^2*cos(matrix_input(i)); % square it and mult by cos(entry)
    end
end

fprintf(output_file,'%10d %+6.3f\n',new_matrix); % print the new matrix in the file
fclose(output_file);

        
