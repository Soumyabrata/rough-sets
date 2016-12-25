% This script generates the ROC values for HYTA images
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================

clear all; clc;

% Include HYTA database
% (Please contact authors of "http://journals.ametsoc.org/doi/abs/10.1175/JTECH-D-11-00009.1" for HYTA dataset)
% HYTA dataset
Files=dir('./HYTA+GT/images/*.jpg');
Files_GT=dir('./HYTA+GT/GT/*.jpg');

score_files = [];
dec_table_files = [];
colorch_ranks_files = [];


for kot=1:1:length(Files)


    ok_status = 1;
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
    I_GT(I_GT<128) = 0;
    I_GT(I_GT == 128) = 0;
    I_GT(I_GT>128) = 1;
    I_GT = double(I_GT);    
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

    combfeature = cat(1, C1', C2', C3', C4', C5', C6', C7', C8', C9', C10', C11', C12', C13', C14', C15', C16');
    Group = I_GT(:)' ;
    
    try
        [IDX, Z] = rankfeatures(combfeature, Group, 'Criterion', 'roc');
    catch 
       disp ('Skipping this mono-cluster image') ;
       continue; 
    end
    
    disp('All channels extracted');
   
    % Check if it contains Inf value
    TF = isinf(Z);
    if (isempty(find(TF==1)) == 0) % It is not empty = contains Inf
        ok_status = 0;
    end
    
    if (ok_status)
        score_files = cat(1,score_files,Z');
    end
    

end 


mv=mean(score_files);
% Saving the results
save('ROC_values.mat','mv');



