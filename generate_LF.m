% This script generates the Loading Factors for HYTA images
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================

% Include HYTA database
% (Please contact authors of "http://journals.ametsoc.org/doi/abs/10.1175/JTECH-D-11-00009.1" for HYTA dataset)
Files=dir('./HYTA+GT/images/*.jpg');
Files_GT=dir('./HYTA+GT/GT/*.jpg');

lf_files = [];
dec_table_files = [];

for kot=1:length(Files)


    disp (['Processing image = ',num2str(kot)]);
    FileNames=Files(kot).name;

    % HYTA
    I=imread(['./HYTA+GT/images/', FileNames]);    
 
    % Down-sampled for faster computation
    new_size = 32;
    I_small = imresize(I,[new_size NaN]);
    I_small = double(I_small);
    I = I_small;

    % Ground truths
    GroundTruthName=FileNames;
    ind=length(GroundTruthName)-3:1:length(GroundTruthName);
    GroundTruthName(ind)=[];
    GroundTruthName=strcat(GroundTruthName,'_GT.jpg');


    % HYTA
    IGT=imread(['./HYTA+GT/GT/', GroundTruthName]);    
    
    % Down sampled for faster computation
    IGT_small = imresize(IGT,[new_size NaN]);
    IGT_small = double(IGT_small);
    I_GT = IGT_small;

    % Converting to binary map
    I_GT(I_GT<128) = 0;
    I_GT(I_GT == 128) = 0;
    I_GT(I_GT>128) = 1;
    I_GT = double(I_GT);
    
    % Extract the 16 color channels
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
    comb_channel = cat(2,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16);


    CovMat=cov(comb_channel);       % calculating the covariance matrix    
    check_nan = isnan(CovMat);
    check_nan_vc = check_nan(:);    
    isthere = length(find(check_nan_vc==1));
    
    if isthere>0
       continue;
    else        
        [Ve,De] = eig(CovMat);      % calculating the eigen values
        p1=Ve(:,16);
        lf_ind = abs(p1)';
        lf_files = cat(1,lf_files,lf_ind);        
    end
end  


mv=mean(lf_files)
% Saving the results
save('loading_1D.mat','mv');

