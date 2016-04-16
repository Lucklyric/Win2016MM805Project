clear;

g_f = 6.1;
dx = 7.44/3648;
dy = 5.58/2736;
g_fx = g_f/dx;
g_fy = g_f/dy;
%% Roll 180 Using the same image with init pose and roll 180 pose
pointTracker = vision.PointTracker('MaxBidirectionalError', 10);

imgInitR = imread('../images/new/init.JPG');
imgPanR = imread('../images/new/p5.JPG');
imgPanT = imread('../images/new/t5.JPG');

imgInit = rgb2gray(imgInitR);
imgPan = rgb2gray(imgPanR);
imgTil = rgb2gray(imgPanT);

figure,
imshow(imgInit);
rectInit = getrect;

maskInit = imgInit(floor(rectInit(2)):floor(rectInit(2)+rectInit(4)),floor(rectInit(1)):floor(rectInit(1)+rectInit(3)));
R = im2bw(maskInit,graythresh(maskInit));
[r,c] = ind2sub(size(R),find(R==0));

y_bar = mean(r)+rectInit(2);
x_bar = mean(c)+rectInit(1);



figure,
imshow(imgPan);
rectPan = getrect;
maskPan = imgPan(floor(rectPan(2)):floor(rectPan(2)+rectPan(4)),floor(rectPan(1)):floor(rectPan(1)+rectPan(3)));
panR = im2bw(maskPan,graythresh(maskPan));
[r,c] = ind2sub(size(panR),find(panR==0));

y_bar_p = mean(r)+rectPan(2);
x_bar_p = mean(c)+rectPan(1);

figure,
imshow(imgTil);
rectTil = getrect;
maskTil = imgTil(floor(rectTil(2)):floor(rectTil(2)+rectTil(4)),floor(rectTil(1)):floor(rectTil(1)+rectTil(3)));
tilR = im2bw(maskTil,graythresh(maskTil));
[r,c] = ind2sub(size(tilR),find(tilR==0));

y_bar_t = mean(r)+rectTil(2);
x_bar_t = mean(c)+rectTil(1);


[Cfx,Cfy] = strategyC(x_bar,x_bar^2,x_bar_p,8*pi/180 ...
             ,y_bar,y_bar^2,y_bar_t,4*pi/180); 
