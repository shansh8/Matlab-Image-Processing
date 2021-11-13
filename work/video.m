clc;
clear all;
close all;
obj = VideoReader('E:\3 Sem\work\seagul.mp4');
vide=obj.read();
video1(:,:,:,:)=vide(:,:,:,1:40);
[x,y,z,t]=size(video1);
for i=1:t
    vidgry(:,:,i)=rgb2gray(video1(:,:,:,i));
end

for i=1:t-1
    diff(:,:,i)=vidgry(:,:,i+1)-vidgry(:,:,i);
end
diff=cast(diff,'double');
hotspot=sum(diff,3);


disk1=strel('disk',5);
hotspot_open=imopen(hotspot,disk1);

thresh1=graythresh(uint8(hotspot));
hotspot_bw=im2bw(uint8(hotspot_open),thresh1);

 s  = regionprops(hotspot_bw, 'centroid','area','perimeter');
   centroids = cat(1, s.Centroid);

centroids(:,3)=8;
for i=1:t
    op(:,:,:,i) = insertShape(video1(:,:,:,i), 'Circle', centroids,'Color','yellow');
end
implay(op);
