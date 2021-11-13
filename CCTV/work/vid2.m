
clc;
close all;
v= VideoReader('E:\3 Sem\CCTV\work\vid.avi');

for im = 1:40;
   tic;
    a=read(v,im);
    b=read(v,im+1);
    a1=a(:,:,1);
        a2=a(:,:,2);
        a3=a(:,:,3);
        [r c]=size(a1);
        b1=b(:,:,1);
        b2=b(:,:,2);
        b3=b(:,:,3);
        z1= imsubtract(a1,b1);
        z2= imsubtract(a2,b2);
        z3= imsubtract(a3,b3);

        fig(:,:,1)=z1;
        fig(:,:,2)=z2;
        fig(:,:,3)=z3;


        I2=rgb2gray(fig);
        I3 = imadjust(I2, stretchlim(I2), [0 1]);
        level = graythresh(I3);
        bw = im2bw(I3,level); 
        K = medfilt2(bw);
        K6 = medfilt2(K,[5,5]);
        imshow(K6);
      toc;  
end
