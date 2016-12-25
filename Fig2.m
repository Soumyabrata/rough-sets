% This script displays the 16 color channels of a sample image of HYTA
% database.
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets
% =========================================================

clear all; clc; 
addpath('./HYTA+GT/');
addpath('./helperScripts/');
addpath('./preComputed/');
addpath('./roughSetScripts/');

% Sample image from HYTA database
FileNames = 'B1.jpg';
I=imread(['./preComputed/', FileNames]);    
    
% Ground truths for HYTA
GroundTruthName=FileNames;
ind=length(GroundTruthName)-3:1:length(GroundTruthName);
GroundTruthName(ind)=[];
GroundTruthName=strcat(GroundTruthName,'_GT.jpg');
IGT=imread(['./preComputed/', GroundTruthName]);    
 
% Generating a binary map of ground truth image
I_GT = IGT;    
I_GT(I_GT<128) = 0;
I_GT(I_GT == 128) = 0;
I_GT(I_GT>128) = 1;
I_GT = double(I_GT);

% Generate 16 color channels    
[color_ch]=color16_struct(I);
    
% Normalizing the extracted color channels to [0 - 255]
C1 = round(showasImage(color_ch.c1));
C2 = round(showasImage(color_ch.c2));
C3 = round(showasImage(color_ch.c3));
C4 = round(showasImage(color_ch.c4));
C5 = round(showasImage(color_ch.c5));
C6 = round(showasImage(color_ch.c6));
C7 = round(showasImage(color_ch.c7));
C8 = round(showasImage(color_ch.c8));
C9 = round(showasImage(color_ch.c9));
C10 = round(showasImage(color_ch.c10));
C11 = round(showasImage(color_ch.c11));
C12 = round(showasImage(color_ch.c12));
C13 = round(showasImage(color_ch.c13));
C14 = round(showasImage(color_ch.c14));
C15 = round(showasImage(color_ch.c15));
C16 = round(showasImage(color_ch.c16));
   

% Display the color channels
% (A few color channels are inverted such that cloud pixels have lighter shade than sky pixels)
figure; imshow(uint8(C1));
figure; imshow(uint8(C2));
figure; imshow(uint8(C3));
figure; imshow(uint8(255-C4));
figure; imshow(uint8(255-C5));
figure; imshow(uint8(C6));
figure; imshow(uint8(C7));
figure; imshow(uint8(C8));
figure; imshow(uint8(255-C9));
figure; imshow(uint8(C10));
figure; imshow(uint8(C11));
figure; imshow(uint8(C12));
figure; imshow(uint8(C13));
figure; imshow(uint8(C14));
figure; imshow(uint8(255-C15));
figure; imshow(uint8(255-C16));


