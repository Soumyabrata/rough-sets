% This script generates the box plots as shown in Fig. 3
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================


% The spreadsheet 'colorch_extend50.xlsx' is generated from
% 'generate_SVMresults.m'

% This file is pre-computed and archived here for reproducible purpose
num = xlsread('colorch_extend50.xlsx');

acc_array = [];
pr_array = [];
re_array = [];
fs_array = [];

for t=1:16
   
    first_col = num(:,1);
    ind = find(first_col==t);
    
    acc = num(ind,3);
    pr = num(ind,4);
    re = num(ind,5);
    fs = num(ind,6);
    
    acc_array = cat(2,acc_array,acc);
    pr_array = cat(2,pr_array,pr);
    re_array = cat(2,re_array,re);
    fs_array = cat(2,fs_array,fs);
    
end

% Generates Fig. 3(a) Accuracy
figure; boxplot(acc_array,'whisker',6.5,'Labels',{'c1','c2','c3','c4','c5','c6','c7','c8','c9','c10','c11','c12','c13','c14','c15','c16'}); grid on;

% Generates Fig. 3(b) F-score
figure; boxplot(fs_array,'whisker',6.5,'Labels',{'c1','c2','c3','c4','c5','c6','c7','c8','c9','c10','c11','c12','c13','c14','c15','c16'});
