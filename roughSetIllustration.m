% Illustration of a rough-set problem.

clear all; clc; 
addpath('./HYTA+GT/');
addpath('./helperScripts/');
addpath('./preComputed/');
addpath('./roughSetScripts/');

% The individual observations are provided below:
AGE_obs = [16;16;31;31;46;16;46];
LEMS_obs = [50;0;1;1;26;26;26];
WALK_obs = [1;0;0;1;0;1;0];
dec_table = cat(2,AGE_obs,LEMS_obs,WALK_obs);
disp ('The decision table is:');
disp (dec_table);
% Each row of the above decision table comprises an observation. In total
% there are 7 observations.
% Each column indicates an attribute. In total there are 3 attributes. The
% first and second attribute is AGE and LEMS score. The third and final
% attribute is the decision attribute. The decision attribute is binary in
% nature: 1 indicates ability to WALK and 0 indicates unable to WALK.


%% --------------------------------------------------------
% Illustration of indiscernibility for a particular attribute.

% Partioning the decision table based on indiscernibility of the first
% attribute (AGE)
[IND_att1] =  indisc_att(dec_table , 1);
% Here, 1 indicates the COLUMN number of the AGE attribute.
disp ('The partitions created by AGE attribute is:')
disp(IND_att1);


% Partioning the decision table based on indiscernibility of the second
% attribute (LEMS)
[IND_att2] =  indisc_att(dec_table , 2);
% Here, 2 indicates the COLUMN number of the LEMS attribute.
disp ('The partitions created by LEMS attribute is:')
disp(IND_att2);


% Partioning the decision table based on indiscernibility of the decision
% attribute (WALK)
[IND_att3] =  indisc_att(dec_table , 3);
% Here, 3 indicates the COLUMN number of the WALK attribute.
disp ('The partitions created by WALK attribute is:')
disp(IND_att3);


%% --------------------------------------------------------

% We can also create new attributes by concatenating original attributes. The
% concatenated attribute serves as a new attribute.
% For example, we combine AGE and LEMS to create a new attribute AGE-LEMS
% attribute.

[rows,~]=size(dec_table);

AGE_LEMS = cell(rows,1);
for i =1:rows
    AGE_LEMS{i,1} = strcat(num2str(AGE_obs(i)),'-',num2str(LEMS_obs(i)));    
end

newDecisionTable = cat(2,num2cell(AGE_obs),num2cell(LEMS_obs),AGE_LEMS,num2cell(WALK_obs));
% In general convention, the decision attribute is kept as the last
% attribute in the table.
disp ('The new and updated decision table is:');
disp (newDecisionTable);

[IND_concAtt] =  indisc_att(newDecisionTable , 3);
% Here, 3 indicates the COLUMN number of the AGE-LEMS attribute.
disp ('The partitions created by AGE-LEMS attribute is:')
disp(IND_concAtt);



%% --------------------------------------------------------

% Illustration of positive region and gamma value.
[POS_att , gamma_att] =  positive_region(dec_table , 1 , 3);
% Here, we calculate the POSITIVE region and gamma value of AGE attribute
% w.r.t. the decision attribute WALK attribute.
disp ('The observations that fall under positive region are:');
disp (POS_att);

disp ('The dependence value of the queried attribute w.r.t. decision attribute is:');
disp (gamma_att);



%%


