clc;
close all;
srcFiles = dir('E:\3 sem\CCTV\work\*.jpg');  
M= length(srcFiles);
for i = 1 :M
    filename = strcat('E:\3 sem\CCTV\work\',srcFiles(i).name);
    I = imread(filename);
    I=imresize(I,5.5);
    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i);
    imshow(I);
    
end

