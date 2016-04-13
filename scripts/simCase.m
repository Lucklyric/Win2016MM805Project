x = randi([50 70],1,100);
y = randi([50 70],1,100);
z = randi([500 550],1,100);
f = 100;
projection=zeros(50);
for i=1:100
    [px,py]=project(x(1,i),y(1,i),z(1,i),f);
    projection(ceil(px),ceil(py))=1;
end
projection=bwperim(projection);
[xbar,ybar]=xybar(projection);
imshow(projection);