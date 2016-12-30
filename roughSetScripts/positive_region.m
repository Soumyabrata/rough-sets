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


    % Find the size of the decision table. The variable "tot_len" indicates the number of observations.
    [tot_len,~] = size(decision_table) ;
    
    % Generate the corresponding partitions
    IND_att =  indisc_att(decision_table , attribute_number) ;
    IND_decision =  indisc_att(decision_table , dec_attribute_number) ;
    
    % This array contains all the observations that fall under positive region.
    POS_al = [];    % Initialization

    for ent = 1:length(IND_att) % We loop for all sets of the partition contained in the cell array.
        A = IND_att{ent,1}; % Corresponding set of the cell array.

        for t = 1:length(IND_decision)  % We check "A" against all sets of the decision partition.
            B = IND_decision{t,1};
            Lia = ismember(A,B);    % Returns a logical "1" if data of A is found in B

            temp = any(Lia==0);
            % This is the case when "Lia" is all 1's. That means all elements of A are found in B; which in fact means "positive region".
            if temp == 0
                POS_al = cat(1,POS_al,A);
            end

        end


    end
    POS_att = unique(POS_al);
    
    gamma_att = length(POS_att)/tot_len ;
    


end
