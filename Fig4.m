% This script generates the scatter plots as shown in Fig. 4
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets
% =========================================================

clear all; clc; 
addpath('./HYTA+GT/');
addpath('./helperScripts/');
addpath('./preComputed/');
addpath('./roughSetScripts/');

% The spreadsheet 'colorch_trimmed50.xlsx' is generated from
% 'generate_SVMresults.m'
% This file is pre-computed and archived here for reproducible purpose

% Correlation with relevance.
num = xlsread('colorch_trimmed50.xlsx');
load rel_value.mat ;
a = [1:16]'; b = num2str(a); c = cellstr(b);


% Fig. 4(a)
figure;
scatter(normalize(mv') , num(:,2),'b','filled'); hold on;
dx = 0.001; dy = 0.001;
x = normalize(mv');
y = num(:,2);
text(x+dx, y+dy, c);


% Correlation with bimodality.
bimod = [
    2.24
    2.83
    3.25
    3.11
    1.94
    3.26
    2.71
    3.98
    5.96
    2.86
    8.85
    4.59
    2.27
    4.43
    2.92
    4.27
    ];
bimod = bimod' ;
num = xlsread('colorch_trimmed50.xlsx');
a = [1:16]'; b = num2str(a); c = cellstr(b);

% Fig. 4(b)
figure;
scatter(normalize(bimod') , num(:,2),'b','filled'); hold on;
dx = 0.001; dy = 0.001;
x = normalize(bimod');
y = num(:,2);
text(x+dx, y+dy, c);


% Correlation with KL divergence
load entropy_HYTA.mat ;
entropy_values = mv ;
num = xlsread('colorch_trimmed50.xlsx');
a = [1:16]'; b = num2str(a); c = cellstr(b);

% Fig. 4(c)
figure;
scatter(normalize(entropy_values') , num(:,2),'b','filled'); hold on;
dx = 0.001; dy = 0.001;
x = normalize(entropy_values');
y = num(:,2);
text(x+dx, y+dy, c);



