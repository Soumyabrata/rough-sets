function [POS_att , gamma_att] =  positive_region(decision_table , attribute_number , dec_attribute_number)

% This function outputs the POSITIVE region for an attribute and its
% gamma-value.

% INPUT: 
% (a) decision_table = Array containing the universe. Rows correspond to
% different observations, and columns correspond to characteristics.
% (b) attribute_number = COLUMN number for a particular attribute in the decision
% table to indicate that particular attribute.
% (c) dec_attribute_number = COLUMN number of the decision variable in the
% decision table.

% OUTPUT:
% (a) POS_att = Positive region of the particular attribute queried.
% (b) gamma_att = Gamma value of the particular attribute queried.


    
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
    


end