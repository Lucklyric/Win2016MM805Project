%%This is the sythetic case for our experiment.
clear;
%% ask user to input parameters
prompt = {'Enter the fx:','Enter the fy:','Enter the cx:', 'Enter the cy:','Enter the min x value:','Enter the max x value:','Enter the min y value:','Enter the max y value:','Enter the min z value:','Enter the max z value:','Total points in the object:'};
dlg_title = 'Setup parameters';
num_lines = 1;
defaultans = {'3000','3000','0','0','250','270','250','270','1220','1240','10'};
parameters = inputdlg(prompt,dlg_title,num_lines,defaultans);
fx = str2double(parameters(1));
fy = str2double(parameters(2));
cx = str2double(parameters(3));
cy = str2double(parameters(4));
pointsize=str2double(parameters(11));
%create 3D object
x = randi([str2double(parameters(5)) str2double(parameters(6))],1,str2double(parameters(11)));
y = randi([str2double(parameters(7)) str2double(parameters(8))],1,str2double(parameters(11)));
z = randi([str2double(parameters(9)),str2double(parameters(10))],1,str2double(parameters(11)));
meanx=mean(x);
meany=mean(y);
meanz=mean(z);
centroid=[meanx,meany,meanz];
results_Cfx=[];
results_Cfy=[];
results_Cdx=[];
results_Cdy=[];
results_Dfx=[];
results_Dfy=[];
results_Ddx=[];
results_Ddy=[];
pan_array=[];
tilt_array=[];
%% ask user to input the pan and tilt angle
prompt = {'Enter the lower bound for pan angle(will test for 10 angles):', 'Enter the lower bound for tilt angle(will test for 10 angles):'};
dlg_title = 'Setup angles';
num_lines = 1;
defaultans = {'1','1'};
ptangles = inputdlg(prompt,dlg_title,num_lines,defaultans);
for m=str2double(ptangles(1)):str2double(ptangles(1))+9
    pan_array=[pan_array m];
end
for n=str2double(ptangles(2)):str2double(ptangles(2))+9
    tilt_array=[tilt_array n];
end
len=10;
%% ask user to input roll angle
choice = menu('Choose an angle((if not 180 degree only show result for strategy C)','30 degree','60 degree','90 degree','180 degree');
if choice==3
    roll_array=[90,90,90,90,90,90,90,90,90,90];
elseif choice==1
    roll_array=[30,30,30,30,30,30,30,30,30,30];
elseif choice==2
    roll_array=[60,60,60,60,60,60,60,60,60,60];
else
    roll_array=[180,180,180,180,180,180,180,180,180,180];
end
%% This is the main algorithm for the sim case.
for angle=1:len
    thetar = roll_array(angle)*pi/180;
    thetap = pan_array(angle)*pi/180;
    thetat = tilt_array(angle)*pi/180;
    projectionx=zeros(1,pointsize);
    projectiony=zeros(1,pointsize);
    projectionrx=zeros(1,pointsize);
    projectionry=zeros(1,pointsize);
    projectiontx=zeros(1,pointsize);
    projectionty=zeros(1,pointsize);
    projectionpx=zeros(1,pointsize);
    projectionpy=zeros(1,pointsize);
    %rotate the 3D object
    [xr,yr,zr]=rotate(2,centroid,-thetar,x,y,z);%roll=2, z-axis
    [xt,yt,zt]=rotate(0,centroid,-thetat,x,y,z);%tilt=0, x-axis
    [xp,yp,zp]=rotate(1,centroid,-thetap,x,y,z);%pan=1, y-axis

    for i=1:pointsize
        %project the 3D object onto 2D plane
        [px,py]=project(x(1,i),y(1,i),z(1,i),fx,fy,cx,cy);
        [pxr,pyr]=project(xr(1,i),yr(1,i),zr(1,i),fx,fy,cx,cy);
        [pxt,pyt]=project(xt(1,i),yt(1,i),zt(1,i),fx,fy,cx,cy);
        [pxp,pyp]=project(xp(1,i),yp(1,i),zp(1,i),fx,fy,cx,cy);
        projectionx(i)= px;
        projectiony(i)= py;
        projectionrx(i)= pxr;
        projectionry(i)= pyr;
        projectiontx(i)= pxt;
        projectionty(i)= pyt;
        projectionpx(i)= pxp;
        projectionpy(i)= pyp;
    end
    %use strategy C
    [Cfx,Cfy,cdx,cdy] = strategyC(mean(projectionx),mean(projectionpx),thetap,mean(projectiony),mean(projectionty),thetat,thetar,mean(projectionrx),mean(projectionry)); 
    %use strategy D
    [Dfx,Dfy,ddx,ddy] = strategyD(mean(projectionx),mean(projectionpx),mean(projectiony),mean(projectionty),thetat,thetap,mean(projectionrx),mean(projectionry));
    delta_x = (mean(projectionx)+mean(projectionrx))/2;
    delta_y = (mean(projectiony)+mean(projectionry))/2;
    %collect result
    results_Cfx=[results_Cfx Cfx];
    results_Cfy=[results_Cfy Cfy];
    results_Cdx=[results_Cdx cdx];
    results_Cdy=[results_Cdy cdy];
    results_Dfx=[results_Dfx Dfx];
    results_Dfy=[results_Dfy Dfy];
    results_Ddx=[results_Ddx ddx];
    results_Ddy=[results_Ddy ddy];
end
fx_list=zeros(len,1);
fy_list=zeros(len,1);
cx_list=zeros(len,1);
cy_list=zeros(len,1);
for j=1:len
    fx_list(j)=fx;
    fy_list(j)=fy;
    cx_list(j)=cx;
    cy_list(j)=cy;
end
if choice==4
    result_all=struct('fx',fx_list,'fy',fy_list,'deltax',cx_list,'deltay',cy_list,'pan_angle',pan_array','tilt_angle',tilt_array','roll_angle',roll_array','Cfx',results_Cfx','Cfy',results_Cfy','Cdeltax',results_Cdx','Cdeltay',results_Cdy','Dfx',results_Dfx','Dfy',results_Dfy','Ddeltax',results_Ddx','Ddeltay',results_Ddy');
else
    result_all=struct('fx',fx_list,'fy',fy_list,'deltax',cx_list,'deltay',cy_list,'pan_angle',pan_array','tilt_angle',tilt_array','roll_angle',roll_array','Cfx',results_Cfx','Cfy',results_Cfy','Cdeltax',results_Cdx','Cdeltay',results_Cdy');
end
result_all=struct2table(result_all);
%display result
disp(result_all);