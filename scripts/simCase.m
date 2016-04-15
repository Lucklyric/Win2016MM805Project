clear;
pointsize=1;
cx=0;
cy=0;
x = randi([50 70],1,pointsize);
y = randi([50 70],1,pointsize);
z = randi([220,240],1,pointsize);
meanx=mean(x);
meany=mean(y);
meanz=mean(z);
centroid=[meanx,meany,meanz];
fx = 100;
fy = 100;
theta = pi/180;
projectionx=zeros(1,pointsize);
projectiony=zeros(1,pointsize);
projectionrx=zeros(1,pointsize);
projectionry=zeros(1,pointsize);
projectiontx=zeros(1,pointsize);
projectionty=zeros(1,pointsize);
projectionpx=zeros(1,pointsize);
projectionpy=zeros(1,pointsize);
[xr,yr,zr]=rotate(2,centroid,-theta,x,y,z);%roll=0, z-axis
[xt,yt,zt]=rotate(1,centroid,-theta,x,y,z);%tilt=2, x-axis
[xp,yp,zp]=rotate(0,centroid,-theta,x,y,z);%pan=1, y-axis

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
[fx,fy] = strategyC(mean(projectionx),mean(projectionx.*projectionx),mean(projectionpx),mean(projectionpx.*projectionpx),theta*180/pi...
             ,mean(projectiony),mean(projectiony.*projectiony),mean(projectionty),mean(projectionty.*projectionty),theta*180/pi); 
% [fx,fy] = strategyC(mean(projectionx),(mean(projectionx))^2,mean(projectionpx),(mean(projectionpx))^2,theta*180/pi...
%              ,mean(projectiony),mean(projectiony.*projectiony),mean(projectionty),mean(projectionty.*projectionty),theta*180/pi); 
delta_x = (mean(projectionx)+mean(projectionrx))/2;
delta_y = (mean(projectiony)+mean(projectionry))/2;