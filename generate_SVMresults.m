% This script generates the SVM results for the 16 color channels.
% The output of this file is "colorch_extend50.xlsx" &
% "colorch_trimmed50.xlsx" which is needed in Fig3.m and Fig4.m
% Please refer the following link for details: https://github.com/Soumyabrata/rough-sets

% =========================================================

clear all; clc;

%Output spreadsheet that contains the SVM results of 50 random selctions for 16 color channels. 
% Summary of the result
fileID = fopen(['colorch_trimmed','.xlsx'],'a');
fprintf(fileID,'Color_channel \t Accuracy \t Precision \t Recall \t FScore \n');

% Extended summary of the result
fileID2 = fopen(['colorch_extend','.xlsx'],'a');
fprintf(fileID2,'Color_channel \t Serial_number \t Accuracy \t Precision \t Recall \t FScore \n');


% Include HYTA database
% (Please contact authors of "http://journals.ametsoc.org/doi/abs/10.1175/JTECH-D-11-00009.1" for HYTA dataset)
Files=dir('./HYTA+GT/images/*.jpg');
Files_GT=dir('./HYTA+GT/GT/*.jpg');

% Resizing for faster computation
new_size = 32;

for obs = 1:16       % Looping for the 16 color channels
    
    acc_arr = [];
    pr_arr = [];
    rec_arr = [];
    fs_arr = [];
    
    for how_many_times = 1:50   % Looping for different experiments with random selection of images
        

        % Index of training and testing images
        Files_train = randperm(32,15);
        Files_test = 1:1:32; Files_test(Files_train)=[];
        
        % Training stage
        data_files=[];
        GT_files = [];
        for kot=1:length(Files_train)

            disp (['Processing image = ',num2str(Files_train(kot))]);
            FileNames=Files(Files_train(kot)).name;
            
            I_train=imread(['./HYTA+GT/images/', FileNames]);
            I_train = imresize(I_train,[new_size NaN]);

            % Extract the 16 color channels
            [color_ch]=color16_struct(I_train);

            % Vectorizing all the channels.
            color_select=eval(['color_ch.c',num2str(obs)]);
            color_select = color_select(:);
            data_files = cat(1,data_files,color_select);

            % Ground truth image
            GroundTruthName=FileNames;
            ind=length(GroundTruthName)-3:1:length(GroundTruthName);
            GroundTruthName(ind)=[];
            GroundTruthName=strcat(GroundTruthName,'_GT.jpg');
            I_GT=imread(['./HYTA+GT/GT/', GroundTruthName]);    

            I_GT = imresize(I_GT,[new_size NaN]);
            I_GT = double(I_GT);

            % Converting to a binary map
            I_GT(I_GT<128) = 0;
            I_GT(I_GT == 128) = 0;
            I_GT(I_GT>128) = 1;
            I_GT = I_GT(:);
            GT_files = cat(1,GT_files,I_GT);
            
        end 


        % Training the SVM model    
        disp (['Training the SVM model for color channel=c',num2str(obs)]);
        xdata = data_files;
        group = GT_files;
        options = statset('MaxIter',55000);
        svmStruct = svmtrain(xdata,group, 'Options',options);


        % Testing stage
        disp (['Testing for color channel=c',num2str(obs)]);
        pr_files = [];
        rec_files = [];
        fs_files = [];
        acc_files = [];
        
        for kot=1:length(Files_test)


            disp (['Testing image = ',num2str(Files_test(kot))]);
            FileNames=Files(Files_test(kot)).name;
            I_test=imread(['./HYTA+GT/images/', FileNames]);
            I_test = imresize(I_test,[new_size NaN]);
            [r,c,~]=size(I_test);
            
            [color_ch]=color16_struct(I_test); 
            
            color_select_test=eval(['color_ch.c',num2str(obs)]);
            color_select_test = color_select_test(:);


            % Checking the result
            Group = svmclassify(svmStruct,color_select_test);
            ThreshImage = reshape(Group,r,c);


            % Ground truth for HYTA images
            GroundTruthName=FileNames;
            ind=length(GroundTruthName)-3:1:length(GroundTruthName);
            GroundTruthName(ind)=[];
            GroundTruthName=strcat(GroundTruthName,'_GT.jpg');
            GroundTruth=imread(['./HYTA+GT/GT/' GroundTruthName]);
            GroundTruth=double(GroundTruth);    

            GroundTruth = imresize(GroundTruth,[new_size NaN]);

            % Quantative analysis.
            [Precision,Recall,FScore,acc] = accuracy(ThreshImage,GroundTruth)
            
            acc_files = cat(1,acc_files,acc);
            pr_files = cat(1,pr_files,Precision);
            rec_files = cat(1,rec_files,Recall);
            fs_files = cat(1,fs_files,FScore);           

        end
        
        % Removing NaN with blank
        acc_files(isnan(acc_files))=[];
        pr_files(isnan(pr_files))=[];
        rec_files(isnan(rec_files))=[];
        fs_files(isnan(fs_files))=[];
        
        % Printing in the extended spreadsheet
        fprintf(fileID2,'%d \t %d \t %f \t %f \t %f \t %f \n',obs,how_many_times,mean(acc_files),mean(pr_files),mean(rec_files),mean(fs_files));

        
        acc_arr = cat(1,acc_arr,mean(acc_files));
        pr_arr = cat(1,pr_arr,mean(pr_files));
        rec_arr = cat(1,rec_arr,mean(rec_files));
        fs_arr = cat(1,fs_arr,mean(fs_files));
        
        
    end
    

    acc_obs = mean(acc_arr);
    pr_obs = mean(pr_arr);
    rec_obs = mean(rec_arr);
    fs_obs = mean(fs_arr);
    
    % Printing in the trimmed spreadsheet
    fprintf(fileID,'%d \t %f \t %f \t %f \t %f \n',obs,acc_obs,pr_obs,rec_obs,fs_obs);


end
