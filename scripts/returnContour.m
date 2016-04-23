function [ x_bar,y_bar ] = returnContour( img,titletext )
%RETURNCONTOUR This function ask user to select the ROI on a given image
%  It returns the x_bar and y_bar of the countours points in selected ROI 
figure('name',titletext),
imshow(img);
% ask user to select a rectangle
rect = getrect;
mask = img(floor(rect(2)):floor(rect(2)+rect(4)),floor(rect(1)):floor(rect(1)+rect(3)));
% create the mask with graythresh value
R = im2bw(mask,graythresh(mask));
img(floor(rect(2)):floor(rect(2)+rect(4)),floor(rect(1)):floor(rect(1)+rect(3))) = double(~R).*255;
imshow(img);
% extract the position from original image
[r,c] = ind2sub(size(R),find(R==0));
y_bar = mean(r)+rect(2);
x_bar = mean(c)+rect(1);
end

