
clc;
close all;
v= VideoReader('E:\3 Sem\CCTV\work\vid.avi');

for im = 1:40;
    tic;
     a=read(v,im);
     b=read(v,im+1);
    
    fig= imsubtract(a,b);
   
    I2=rgb2gray(fig);
    I3 = imadjust(I2, stretchlim(I2), [0 1]);
    level = graythresh(I3);
    bw = im2bw(I3,level);
    K = medfilt2(bw);
    I = medfilt2(K,[5,5]);
  
    

L = im2double(I);
    f = imfilter(L.^(-5+1),ones(5,5),'replicate');
    f = f ./(imfilter(L.^-5,ones(5,5),'replicate'));
      imshow(f);

    toc;
    
end
