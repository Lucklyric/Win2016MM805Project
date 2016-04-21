clear;close;
%% The parameters of the camera we used in this project
g_f = 6.1;
dx = 7.44/3648;
dy = 5.58/2736;
g_fx = g_f/dx;
g_fy = g_f/dy;
% Pre-set parameters of pan and roll angles in degree
pan_angle = 9;
til_angle = 3;
%% Read Real Image from files and
imgInitR = imread('../images/new/init.JPG');
imgPanR = imread('../images/new/p9.JPG');
imgTilR = imread('../images/new/t6.JPG');
imgRoll180R = imread('../images/new/r180.JPG');
%% Parse them to the grayscale image
imgInit = rgb2gray(imgInitR);
imgFakeR180 = flip(flip(imgInit,1),2);
imgPan = rgb2gray(imgPanR);
imgTil = rgb2gray(imgTilR);

imgRoll180 = rgb2gray(imgRoll180R);
[h,w] = size(imgInit);
%% Return Init Image countour
[x_bar,y_bar] = returnContour(imgInit,'Init');

% %% Return Fake 180 Image countour and compare the idea image center
% [x_fakeR180_bar,y_fakeR180_bar] = returnContour(imgFakeR180,'Fake_Roll_180');
% 
% delta_x = (x_bar+x_fakeR180_bar)/2;
% delta_y = (y_bar+y_fakeR180_bar)/2;
% fprintf('Ideal Image Center:cx:%.2f,cy:%.2f\n',w/2,h/2);
% fprintf('Fake Roll 180:delta_x:%.2f,delta_y:%.2f\n',delta_x,delta_y);

%% Return pan 5 Image countour
[x_pan_bar,y_pan_bar] = returnContour(imgPan,'Pan');

%% Return Til 5 Image countour
[x_til_bar,y_til_bar] = returnContour(imgTil,'Til');

%% Return roll 180 Image countour
[x_roll180_bar,y_roll180_bar] = returnContour(imgFakeR180,'roll_180');

%% Apply StrategyC
[Cfx,Cfy,Cdx,Cdy] = strategyC(x_bar,x_pan_bar,pan_angle*pi/180,y_bar,y_til_bar,til_angle*pi/180,180*pi/180,x_roll180_bar,y_roll180_bar); 

