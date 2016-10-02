% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================
function [IND_att] =  indisc_att(decision_table , attribute_number)
% This partitions the decision table based on attributes.
% INPUT
% decision_tale = matrix containing all the entries.
% attribute_number = serial number of column
% 
% OUTPUT
% IND_att = cell containing the array of elements.

%%
    [size_table,~]=size(decision_table);
     

    att = decision_table(:,attribute_number);
    
    [uni_att,ia_att,ic_att] = unique(att,'sorted');
    
    IND_att = cell(length(uni_att),1);

    for t = 1:size_table
        temp = ic_att(t,1);
        IND_att{temp,1} = cat(1,IND_att{temp,1},t);
    end
    
%%    

end
