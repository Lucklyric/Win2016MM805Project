function [ x_bar,y_bar ] = returnContour( img,titletext )
%RETURNCONTOUR Summary of this function goes here
%   Detailed explanation goes here
figure('name',titletext),
imshow(img);
rect = getrect;
mask = img(floor(rect(2)):floor(rect(2)+rect(4)),floor(rect(1)):floor(rect(1)+rect(3)));
R = im2bw(mask,graythresh(mask));
img(floor(rect(2)):floor(rect(2)+rect(4)),floor(rect(1)):floor(rect(1)+rect(3))) = double(~R).*255;
imshow(img);
[r,c] = ind2sub(size(R),find(R==0));
y_bar = mean(r)+rect(2);
x_bar = mean(c)+rect(1);
end

