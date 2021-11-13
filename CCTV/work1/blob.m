function ExtractBiggestBlob()
clc;
close all;
v= VideoReader('E:\3 Sem\CCTV\work1\vid.avi');
n=v.NumberOFFrames;

for im = 900:5:1000;
    tic;
    a=read(v,im);
    a=imresize(a,0.5);
    b=read(v,im+5);
    b=imresize(b,0.5);
    
    
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
    f= im2bw(f);
    
    
    [labeledImage, numberOfBlobs] = bwlabel(f);
    
    biggestBlob = ExtractNLargestBlobs(f,1);
    st = regionprops(biggestBlob, 'BoundingBox' );
    
    thisBB = st.BoundingBox;
    sub=imcrop(b,[],thisBB);
    sub=imresize(sub,4);
    imshow(sub);
    toc;
end
end
function binaryImage = ExtractNLargestBlobs(binaryImage, numberToExtract)
try
    
    [labeledImage, numberOfBlobs] = bwlabel(binaryImage);
    blobMeasurements = regionprops(labeledImage, 'area');
    
    allAreas = [blobMeasurements.Area];
    if numberToExtract > 0
        [sortedAreas, sortIndexes] = sort(allAreas, 'descend');
    elseif numberToExtract < 0
        [sortedAreas, sortIndexes] = sort(allAreas, 'ascend');
        numberToExtract = -numberToExtract;
    else
        binaryImage = false(size(binaryImage));
        return;
    end
    biggestBlob = ismember(labeledImage, sortIndexes(1:numberToExtract));
    binaryImage = biggestBlob >=0.9;
catch ME
    errorMessage = sprintf('Error in function ExtractNLargestBlobs().\n\nError Message:\n%s', ME.message);  
end
end
