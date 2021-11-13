
clc;
close all;
v= VideoReader('E:\3 Sem\CCTV\work\vid.avi');


for im = 1:40;
    tic;
     a=read(v,im);
     b=read(v,im+1);
    [img1_hsv]=round(rgb2hsv(a));
    [img2_hsv]=round(rgb2hsv(b));
    Out = bitxor(img1_hsv,img2_hsv);
    Out=rgb2gray(Out);
    [rows columns]=size(Out);
    for i=1:rows
        for j=1:columns
            
            if Out(i,j) >0
                
                BinaryImage(i,j)=1;
                
            else
                
                BinaryImage(i,j)=0;
                
            end
            
        end
    end
    BImage=medfilt2(BinaryImage);
    I=medfilt2(BImage,[5 5]);
    
    [L num]=bwlabel(I);
    
    STATS=regionprops(L,'all');
    cc=[];
    removed=0;
    for i=1:num
        dd=STATS(i).Area;
        
        if (dd <500)
            
            L(L==i)=0;
            removed = removed + 1;
            num=num-1;
            
        else
            
        end
        
    end
   imshow(L);
     toc;
end
