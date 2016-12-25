% This function normalizes a matrix in range [0,255]
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================
function [OutputMatrix] = showasImage(InputMatrix)
[rows,cols]=size(InputMatrix);

minValue=min(min(InputMatrix));
maxValue=max(max(InputMatrix));
Range=maxValue-minValue;

for i=1:rows
    for j=1:cols
        OutputMatrix(i,j)=((InputMatrix(i,j)-minValue)/Range)*255;
    end
end