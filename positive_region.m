% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================

function [POS_att , gamma_att] =  positive_region(decision_table , attribute_number , dec_attribute_number)
% This function outputs the POSITIVE region for an attribute and its
% gamma-value.

% decision_table = array containing the universe. Rows correspond to rows
% and columns correspond to characteristics.
% attribute_number = COL. number for a particular attribute in the decision
% table.
% dec_attribute_number = COL. number of the decision variable.

%%
    
    [tot_len,~] = size(decision_table) ;
    
    IND_att =  indisc_att(decision_table , attribute_number) ;
    IND_decision =  indisc_att(decision_table , dec_attribute_number) ;
    
    
    POS_al = [];

    for ent = 1:length(IND_att)
        A = IND_att{ent,1};

        for t = 1:length(IND_decision)
            B = IND_decision{t,1};
            Lia = ismember(A,B);

            temp = any(Lia==0);
            if temp == 0
                POS_al = cat(1,POS_al,A);
            end

        end


    end
    POS_att = unique(POS_al);
    
    gamma_att = length(POS_att)/tot_len ;
    
%%    

end