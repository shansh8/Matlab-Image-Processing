clc;
close all;
E = dir('E:\3 sem\Post-processing\E\e*.jpg');
I = dir('E:\3 sem\Post-processing\I\i*.jpg');
F = dir('E:\3 sem\Post-processing\F\f*.jpg');
for im = 1:81;
   
    x = imread(strcat('E:\3 sem\Post-processing\E\',E(im).name));
    y = imread(strcat('E:\3 sem\Post-processing\I\',I(im).name));
    z = imread(strcat('E:\3 sem\Post-processing\F\',F(im).name));
    a=psnr(y,x);
    b=psnr(z,x);
    
    
   disp(a);
%    disp(b);
    
    
end