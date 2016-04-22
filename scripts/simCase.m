clear;
prompt = {'Enter the fx:','Enter the fy:','Enter the cx:', 'Enter the cy:'};
dlg_title = 'Setup parameters';
num_lines = 1;
defaultans = {'3000','3000','0','0'};
parameters = inputdlg(prompt,dlg_title,num_lines,defaultans);
fx = str2double(parameters(1));
fy = str2double(parameters(2));
cx = str2double(parameters(3));
cy = str2double(parameters(4));
pointsize=10;
x = randi([250 270],1,pointsize);
y = randi([250 270],1,pointsize);
z = randi([1220,1240],1,pointsize);
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
angle_array=[1,2,3,4,5,6,7,8,9];
choice = menu('Choose an angle((if not 180 degree only show result for strategy C)','30 degree','60 degree','90 degree','180 degree');
if choice==3
    roll_array=[90,90,90,90,90,90,90,90,90];
elseif choice==1
    roll_array=[30,30,30,30,30,30,30,30,30];
elseif choice==2
    roll_array=[60,60,60,60,60,60,60,60,60];
else
    roll_array=[180,180,180,180,180,180,180,180,180];
end
for angle=1:length(angle_array)
    thetar = roll_array(angle)*pi/180;
    thetap = angle_array(angle)*pi/180;
    thetat = angle_array(angle)*pi/180;
    projectionx=zeros(1,pointsize);
    projectiony=zeros(1,pointsize);
    projectionrx=zeros(1,pointsize);
    projectionry=zeros(1,pointsize);
    projectiontx=zeros(1,pointsize);
    projectionty=zeros(1,pointsize);
    projectionpx=zeros(1,pointsize);
    projectionpy=zeros(1,pointsize);
    [xr,yr,zr]=rotate(2,centroid,-thetar,x,y,z);%roll=2, z-axis
    [xt,yt,zt]=rotate(0,centroid,-thetat,x,y,z);%tilt=0, x-axis
    [xp,yp,zp]=rotate(1,centroid,-thetap,x,y,z);%pan=1, y-axis

    for i=1:pointsize
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

    [Cfx,Cfy,cdx,cdy] = strategyC(mean(projectionx),mean(projectionpx),thetap,mean(projectiony),mean(projectionty),thetat,thetar,mean(projectionrx),mean(projectionry)); 


    [Dfx,Dfy,ddx,ddy] = strategyD(mean(projectionx),mean(projectionpx),mean(projectiony),mean(projectionty),thetat,thetap,mean(projectionrx),mean(projectionry));
    delta_x = (mean(projectionx)+mean(projectionrx))/2;
    delta_y = (mean(projectiony)+mean(projectionry))/2;
    
    results_Cfx=[results_Cfx Cfx];
    results_Cfy=[results_Cfy Cfy];
    results_Cdx=[results_Cdx cdx];
    results_Cdy=[results_Cdy cdy];
    results_Dfx=[results_Dfx Dfx];
    results_Dfy=[results_Dfy Dfy];
    results_Ddx=[results_Ddx ddx];
    results_Ddy=[results_Ddy ddy];
end
fx_list=zeros(length(angle_array),1);
fy_list=zeros(length(angle_array),1);
cx_list=zeros(length(angle_array),1);
cy_list=zeros(length(angle_array),1);
for j=1:length(angle_array)
    fx_list(j)=fx;
    fy_list(j)=fy;
    cx_list(j)=cx;
    cy_list(j)=cy;
end
if choice==4
    result_all=struct('fx',fx_list,'fy',fy_list,'deltax',cx_list,'deltay',cy_list,'pan_tilt_angle',angle_array','roll_angle',roll_array','Cfx',results_Cfx','Cfy',results_Cfy','Cdeltax',results_Cdx','Cdeltay',results_Cdy','Dfx',results_Dfx','Dfy',results_Dfy','Ddeltax',results_Ddx','Ddeltay',results_Ddy');
else
    result_all=struct('fx',fx_list,'fy',fy_list,'deltax',cx_list,'deltay',cy_list,'pan_tilt_angle',angle_array','roll_angle',roll_array','Cfx',results_Cfx','Cfy',results_Cfy','Cdeltax',results_Cdx','Cdeltay',results_Cdy');
end
result_all=struct2table(result_all);
disp(result_all);