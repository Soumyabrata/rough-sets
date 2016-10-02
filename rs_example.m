% Illustration for a rough set problem
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================
%%

dec_table = [16 50 1; 16 0 0; 31 1 0; 31 1 1; 46 26 0; 16 26 1; 46 26 0];

[rows,cols]=size(dec_table);

age = dec_table(:,1);
[uni_age,ia_age,ic_age] = unique(age);
IND_age = cell(length(uni_age),1);

for t = 1:7
    temp = ic_age(t,1);
    IND_age{temp,1} = cat(1,IND_age{temp,1},t);
end


%%





lems = dec_table(:,2);
[uni_lems,ia_lems,ic_lems] = unique(lems);

walk = dec_table(:,3);
[uni_walk,ia_walk,ic_walk] = unique(walk);
IND_walk = cell(length(uni_walk),1);

for t = 1:7
    temp = ic_walk(t,1);
    IND_walk{temp,1} = cat(1,IND_walk{temp,1},t);
end




age_lems = cell(rows,1);
for i =1:rows

    age_lems{i,1} = strcat(num2str(age(i)),'-',num2str(lems(i)));
    
end

[uni_al, ia_al, ic_al] = unique(age_lems,'stable');

IND_al = cell(length(uni_al),1);

for t = 1:7
    temp = ic_al(t,1);
    IND_al{temp,1} = cat(1,IND_al{temp,1},t);
end

%%

% Calculating positive region.

POS_al = [];

for ent = 1:5
    A = IND_al{ent,1};

    for t = 1:2 
        B = IND_walk{t,1};
        Lia = ismember(A,B);

        temp = any(Lia==0);
        if temp == 0
            POS_al = cat(1,POS_al,A);
        end

    end
    

end
unique(POS_al)




%%


