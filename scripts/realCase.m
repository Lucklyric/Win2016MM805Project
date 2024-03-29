clear;close all;
%% Acquire Factory Parameters 
prompt = {'Enter the Focal Length (mm):',...
    'Enter the Sensor Width(mm):','Enter the Sensor Height(mm):',...
    'Enter the Image Resolution Width(pixel):','Enter the Image Resolution Width(pixel):'};
dlg_title = 'Setup parameters';
defaultans = {'6.1','7.44','5.58','3648','2736'};
parameters = inputdlg(prompt,dlg_title,1,defaultans);
% Parse parameters
g_f = str2double(parameters(1));
dx = str2double(parameters(2))/str2double(parameters(4));
dy = str2double(parameters(3))/str2double(parameters(5));
g_fx = g_f/dx;
g_fy = g_f/dy;
g_cx = str2double(parameters(4))/2; 
g_cy = str2double(parameters(5))/2;

%% Acquire path of images and rotate angles
prompt = {'File Name for Init Image'...
    'File Name Pan Image'...
    'Pan Angle(degree)'...
    'File Name Tilt Image'...
    'Tilt Angle(degree)'...
    'File Name Roll Image'};
defaultans = {'../images/new/init.JPG','../images/new/p9.JPG','9','../images/new/t6.JPG','6','../images/new/r180.JPG'};
parameters = inputdlg(prompt,dlg_title,1,defaultans);

% Parse parameters
pan_angle = str2double(parameters(3));
til_angle = str2double(parameters(5));

%% Read Real Image from files and
imgInitR = imread(parameters{1});
imgPanR = imread(parameters{2});
imgTilR = imread(parameters{4});
imgRoll180R = imread(parameters{6});
%% Parse them to the grayscale image
imgInit = rgb2gray(imgInitR);
imgFakeR180 = flip(flip(imgInit,1),2);
imgPan = rgb2gray(imgPanR);
imgTil = rgb2gray(imgTilR);

imgRoll180 = rgb2gray(imgRoll180R);
[h,w] = size(imgInit);
%% Return Init Image countour
[x_bar,y_bar] = returnContour(imgInit,'Init');

%% Return Fake 180 Image countour and compare the idea image center
[x_fakeR180_bar,y_fakeR180_bar] = returnContour(imgFakeR180,'Fake_Roll_180');

fake_delta_x = (x_bar+x_fakeR180_bar)/2;
fake_delta_y = (y_bar+y_fakeR180_bar)/2;
% fprintf('Ideal Image Center:cx:%.2f,cy:%.2f\n',w/2,h/2);
% fprintf('Fake Roll 180:delta_x:%.2f,delta_y:%.2f\n',delta_x,delta_y);

%% Return pan 5 Image countour
[x_pan_bar,y_pan_bar] = returnContour(imgPan,'Pan');

%% Return Til 5 Image countour
[x_til_bar,y_til_bar] = returnContour(imgTil,'Til');

%% Return roll 180 Image countour
[x_roll180_bar,y_roll180_bar] = returnContour(imgRoll180,'roll_180');

%% Apply StrategyC
[Cfx,Cfy,Cdx,Cdy] = strategyC(x_bar,x_pan_bar,pan_angle*pi/180,y_bar,y_til_bar,til_angle*pi/180,180*pi/180,x_roll180_bar,y_roll180_bar); 

%% Apply StrategyD
[Dfx,Dfy,Ddx,Ddy] = strategyD(x_bar,x_pan_bar,y_bar,y_til_bar,til_angle*pi/180,pan_angle*pi/180,x_roll180_bar,y_roll180_bar);

%% Output Result
result_fake=struct2table(struct('ideal_cx',g_cx,'ideal_cy',g_cy,'fake_delatx',fake_delta_x,'fake_deltay',fake_delta_y));
result_all=struct2table(struct('ideal_fx',g_fx,'ideal_fy',g_fy,'ideal_cx',g_cx,'ideal_cy',g_cy,'pan_angle',pan_angle',...
    'tilt_angle',til_angle','Cfx',Cfx','Cfy',Cfy','Cdeltax',Cdx','Cdeltay',Cdy','Dfx',Dfx','Dfy',Dfy','Ddeltax',Ddx','Ddeltay',Ddy'));

disp(result_fake);
disp(result_all);