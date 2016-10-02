% This script generates the relevance values across all images of HYTA
% dataset.
% This generates the values as shown in Table II.
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================

clear all; clc; 

% Include HYTA database
% (Please contact authors of "http://journals.ametsoc.org/doi/abs/10.1175/JTECH-D-11-00009.1" for HYTA dataset)
% HYTA dataset
Files=dir('./HYTA+GT/images/*.jpg');
Files_GT=dir('./HYTA+GT/GT/*.jpg');

rel_band_files = [];
dec_table_files = [];
colorch_ranks_files = [];

% Generating relevance values across all images
for kot=1:1:length(Files)

    disp (['Processing image = ',num2str(kot)]);
    FileNames=Files(kot).name;
    I=imread(['./HYTA+GT/images/', FileNames]);
    
    % Size resizing for faster computation
    new_size = 32;
    I_small = imresize(I,[new_size NaN]);
    I_small = double(I_small);
    I = I_small;

    % Ground truths for HYTA
    GroundTruthName=FileNames;
    ind=length(GroundTruthName)-3:1:length(GroundTruthName);
    GroundTruthName(ind)=[];
    GroundTruthName=strcat(GroundTruthName,'_GT.jpg');
    IGT=imread(['./HYTA+GT/GT/', GroundTruthName]);    
     
    % Size resizing
    IGT_small = imresize(IGT,[new_size NaN]);
    IGT_small = double(IGT_small);
    I_GT = IGT_small;
    
    % Converting to binary map
    I_GT(I_GT<128) = 0;
    I_GT(I_GT == 128) = 0;
    I_GT(I_GT>128) = 1;
    I_GT = double(I_GT);
    
    % Extracting color channels
    [color_ch]=color16_struct(I);    
    
    % Normalizing to 0 - 255
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

    % Vectorizing all the channels.
    C1 = C1(:);
    C2 = C2(:);
    C3 = C3(:);
    C4 = C4(:);
    C5 = C5(:);
    C6 = C6(:);
    C7 = C7(:);
    C8 = C8(:);
    C9 = C9(:);
    C10 = C10(:);
    C11 = C11(:);
    C12 = C12(:);
    C13 = C13(:);
    C14 = C14(:);
    C15 = C15(:);
    C16 = C16(:);
    
    dec_table = cat(2,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,I_GT(:));
    disp(['Decision table generated for ', num2str(kot)]);
    
    disp('All channels extracted');
    dec_attribute_number = 17;   
    
    S = [];
    B = 1:1:16;
    no_of_bands = 16;

    % Aprior calculation of relevance of each band
    rel_band = zeros(no_of_bands,1);
    for t = 1:no_of_bands
        [~ , gamma_att] =  positive_region(dec_table , t , dec_attribute_number);
        rel_band(t,1)= gamma_att;
    end

    % This contains the "relevance values" for all the files individually
    rel_band_files = cat(1,rel_band_files,rel_band');
    
end  

mv=mean(rel_band_files);  % Average is done across all images.
disp(['The relevance values across all images are: ', num2str(mv),' respectively.']);

% Saving the results
save('rel_value.mat','mv');


