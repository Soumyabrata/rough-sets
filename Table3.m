% This script generates the correlation values for all approaches.
% This generates the values as shown in Table III.
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets
% =========================================================

clear all; clc; 
addpath('./HYTA+GT/');
addpath('./helperScripts/');
addpath('./preComputed/');
addpath('./roughSetScripts/'); 


% Proposed approach

% The spreadsheet "colorch_trimmed50.xlsx" is generated from
% 'generate_SVMresults.m'
num = xlsread('colorch_trimmed50.xlsx');

% The mat file "rel_value.mat" is generated from Table2.m
load rel_value.mat ;
a = [1:16]'; b = num2str(a); c = cellstr(b);
R_proposed = corr(mv',num(:,2))


% Bimodality 
% Correlation with bimodality.
% The values of bimodality are generated from the paper 'S. Dev, S. Winkler, Y. H. Lee, Systematic study of color spaces and components for the segmentation of sky/cloud images, Proc. IEEE International Conference on Image Processing (ICIP), 2014.'
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
R_bimod = corr(bimod',num(:,2))


% Loading factors
% This mat file is generated from 'generate_LF.m'
load loading_1D.mat ;
lfactors = mv ;
num = xlsread('colorch_trimmed50.xlsx');
a = [1:16]'; b = num2str(a); c = cellstr(b);
R_LF = corr(lfactors',num(:,2))



% ROC values
% This mat file is generated from 'generate_ROC.m'
load ROC_values.mat ;
lfactors = mv ;
num = xlsread('colorch_trimmed50.xlsx');
a = [1:16]'; b = num2str(a); c = cellstr(b);
R_ROC = corr(lfactors',num(:,2))


% KL values
% This mat file is generated from 'generate_KL.m'
load KL_values.mat ;
lfactors = mv ;
num = xlsread('colorch_trimmed50.xlsx');
a = [1:16]'; b = num2str(a); c = cellstr(b);
R_KL = corr(lfactors',num(:,2))



