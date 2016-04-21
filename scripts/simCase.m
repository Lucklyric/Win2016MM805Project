clear;
pointsize=10;
cx=0;
cy=0;
x = randi([250 270],1,pointsize);
y = randi([250 270],1,pointsize);
z = randi([1220,1240],1,pointsize);
meanx=mean(x);
meany=mean(y);
meanz=mean(z);
centroid=[meanx,meany,meanz];
fx = 400;
fy = 600;
thetar = 180*pi/180;
thetap = 2*pi/180;
thetat = 2*pi/180;
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
