function ExtractBiggestBlob()
clc;
close all;
for im = 1:40;
    tic;
    a=imread(strcat('frame',num2str(im),'.jpg'));
    b=imread(strcat('frame',num2str(im+1),'.jpg'));
    
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
 biggestBlob = ExtractNLargestBlobs(f, 1);
 st = regionprops(biggestBlob, 'BoundingBox' );
figure, imshow(b, [])
 for k = 1 : length(st)
  thisBB = st(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 )
end
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
	binaryImage = biggestBlob > 0;
catch ME
	errorMessage = sprintf('Error in function ExtractNLargestBlobs().\n\nError Message:\n%s', ME.message);
	fprintf(1, '%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
end
