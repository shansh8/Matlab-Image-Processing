clc;
close all;
%Create the Video Device System object.

vidDevice = imaq.VideoDevice('winvideo', 1, 'MJPG_320x240', 'ROI', [1 1 320 240],  'ReturnedColorSpace', 'rgb', ...
                             'DeviceProperties.Brightness', 130, ...
                             'DeviceProperties.Sharpness', 220);
                         
%Create a System object to estimate direction and speed of object motion from one video frame to another using optical flow.
optical = vision.OpticalFlow( ...
    'OutputValue', 'Horizontal and vertical components in complex form');

%Initialize the vector field lines.
maxWidth = imaqhwinfo(vidDevice,'MaxWidth');
maxHeight = imaqhwinfo(vidDevice,'MaxHeight');
shapes = vision.ShapeInserter;
shapes.Shape = 'Lines';
shapes.BorderColor = 'white';
r = 1:5:maxHeight;
c = 1:5:maxWidth;
[Y, X] = meshgrid(c,r);

%Create VideoPlayer System objects to display the videos.
hVideoIn = vision.VideoPlayer;
hVideoIn.Name  = 'Original Video';
hVideoOut = vision.VideoPlayer;
hVideoOut.Name  = 'Motion Detected Video';

%Create a processing loop to perform motion detection in the input video. This loop uses the System objects you instantiated above.
% Set up for stream
nFrames = 0;
while (nFrames<100)     % Process for the first 100 frames.
    % Acquire single frame from imaging device.
    rgbData = step(vidDevice);

    % Compute the optical flow for that particular frame.
    optFlow = step(optical,rgb2gray(rgbData));

    % Downsample optical flow field.
    optFlow_DS = optFlow(r, c);
    H = imag(optFlow_DS)*50;
    V = real(optFlow_DS)*50;

    % Draw lines on top of image
    lines = [Y(:)'; X(:)'; Y(:)'+V(:)'; X(:)'+H(:)'];
    rgb_Out = step(shapes, rgbData,  lines');

    % Send image data to video player
    % Display original video.
    step(hVideoIn, rgbData);
    % Display video along with motion vectors.
    step(hVideoOut, rgb_Out);

    % Increment frame count
    nFrames = nFrames + 1;
end

%Here you call the release method on the System objects to close any open files and devices.
release(vidDevice);

release(hVideoIn);
release(hVideoOut);

