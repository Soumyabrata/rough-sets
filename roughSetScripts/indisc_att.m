function [IND_att] =  indisc_att(decision_table , attribute_number)
% This function partitions the decision table based on indiscernibility of the attributes.

% INPUT: 
% (a) decision_table = Array containing the universe. Rows correspond to
% different observations, and columns correspond to characteristics.
% (b) attribute_number = COLUMN number for a particular attribute in the decision
% table to indicate that particular attribute.
% 
% OUTPUT:
% IND_att = A cell containing the array of observations that are indiscernible, based on the queried attribute.


    [size_table,~]=size(decision_table);
     

    att = decision_table(:,attribute_number);
    
    [uni_att,ia_att,ic_att] = unique(att,'sorted');
    
    IND_att = cell(length(uni_att),1);

    for t = 1:size_table
        temp = ic_att(t,1);
        IND_att{temp,1} = cat(1,IND_att{temp,1},t);
    end
    

end
