function main
I=imread('B6.jpg');
K=imread('B7.jpg');
J=imsubtract(I,K);
[labeledImage, numberOfBlobs] = bwlabel(J);

biggestBlob = ExtractNLargestBlobs(J,1);
st = regionprops(biggestBlob, 'BoundingBox' );

figure, imshow(J, [])
thisBB = st.BoundingBox;
rectangle('Position', thisBB,'EdgeColor','b','LineWidth',2 );
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
