clear;

%% Roll 180 Using the same image with init pose and roll 180 pose
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

imgInitR = imread('../images/test3-i.JPG');
imgRollR = imread('../images/test3-p.JPG');
imgInit = rgb2gray(imgInitR);
imgRotate = rgb2gray(imgRollR);
%imgRotate = flip(imgInit,1);
%imgRotate = flip(imgRotate,2);
% Find corner points inside the detected region.
points = detectMinEigenFeatures(imgInit);



% Re-initialize the point tracker.
xyPointsInit = points.Location;

initialize(pointTracker, xyPointsInit, imgInit);

videoFrameInit = insertMarker(imgInit, xyPointsInit, '+', 'Color', 'white');
figure,
imshow(videoFrameInit);

points = detectMinEigenFeatures(imgRotate);
xyPointsRoll = points.Location;

%[points, isFound] = step(pointTracker, videoFrame);

videoFrameRotate = insertMarker(imgRotate,xyPointsRoll, '+', 'Color', 'white');
figure,
imshow(videoFrameRotate);


% 

[points, isFound] = step(pointTracker, flip(flip(imgRotate,1),2));
visiblePoints = points(isFound, :);

x_bar = mean(xyPointsInit(:,1));
y_bar = mean(xyPointsInit(:,2));

x_bar_r = mean(xyPointsRoll(:,1));
y_bar_r = mean(xyPointsRoll(:,2));

delta_x = (x_bar + x_bar_r)/2;
delta_y = (y_bar + y_bar_r)/2;