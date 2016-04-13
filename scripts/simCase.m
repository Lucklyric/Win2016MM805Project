clear
x = randi([50 70],1,100);
y = randi([50 70],1,100);
z = randi([500 550],1,100);
meanx=mean(x);
meany=mean(y);
meanz=mean(z);
centroid=[meanx,meany,meanz];
f = 100;
projection=zeros(150);
projectionr=zeros(150);
projectiont=zeros(150);
projectionp=zeros(150);
[xr,yr,zr]=rotate(0,centroid, -30,x,y,z);%roll=0, x-axis
[xt,yt,zt]=rotate(1,centroid, -30,x,y,z);%tilt=1, y-axis
[xp,yp,zp]=rotate(2,centroid, -30,x,y,z);%pan=2, z-axis

for i=1:100
    [px,py]=project(x(1,i),y(1,i),z(1,i),f);
    [pxr,pyr]=project(xr(1,i),yr(1,i),zr(1,i),f);
    [pxt,pyt]=project(xt(1,i),yt(1,i),zt(1,i),f);
    [pxp,pyp]=project(xp(1,i),yp(1,i),zp(1,i),f);
    projection(ceil(px),ceil(py))=1;
    projectionr(ceil(pxr),ceil(pyr))=1;
    projectiont(ceil(pxt),ceil(pyt))=1;
    projectionp(ceil(pxp),ceil(pyp))=1;
end
projection=bwperim(projection);
[xbar,ybar]=xybar(projection);
figure(1),imshow(projection);
projectionr=bwperim(projectionr);
[xbarr,ybarr]=xybar(projectionr);
figure(2),imshow(projectionr);
projectiont=bwperim(projectiont);
[xbart,ybart]=xybar(projectiont);
figure(3),imshow(projectiont);
projectionp=bwperim(projectionp);
[xbarp,ybarp]=xybar(projectionp);
figure(4),imshow(projectionp);