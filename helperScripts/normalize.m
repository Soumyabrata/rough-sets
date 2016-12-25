% This script normalizes an array
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================
function [output] =  normalize(input)

    max_value = max(input);
    min_value = min(input);

    output = zeros(length(input),1);
    
    for t = 1:length(input)
        output(t,1) = (input(t,1)-min_value)/(max_value-min_value);
    end

end
