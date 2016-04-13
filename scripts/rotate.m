function [newx,newy,newz]=rotate(axis,center,angle,x,y,z)
    newx=zeros(1,length(x));
    newy=zeros(1,length(x));
    newz=zeros(1,length(x));
    Rx=[1 0 0;0 cos(angle) -sin(angle);0 sin(angle) cos(angle)];
    Ry=[cos(angle) 0 sin(angle);0 1 0;-sin(angle) 0 cos(angle)];
    Rz=[cos(angle) -sin(angle) 0;sin(angle) cos(angle) 0;0 0 1];
    for i=1:length(x)
        points=[x(i) y(i) z(i)];
        if axis==0
            new_points=Rx*points';
        elseif axis==1
            new_points=Ry*points';
        elseif axis==2
            new_points=Rz*points';
        else
        end
        newx(i)=new_points(1);
        newy(i)=new_points(2);
        newz(i)=new_points(3);
    end