function [newx,newy,newz]=rotate(axis,center,angle,x,y,z)
    newx=zeros(1,length(x));
    newy=zeros(1,length(x));
    newz=zeros(1,length(x));
    Rx=[1 0 0;0 cos(angle) -sin(angle);0 sin(angle) cos(angle)];
    Ry=[cos(angle) 0 sin(angle);0 1 0;-sin(angle) 0 cos(angle)];
    Rz=[cos(angle) -sin(angle) 0;sin(angle) cos(angle) 0;0 0 1];
    for i=1:length(x)
        nx=x(i)-center(1);
        ny=y(i)-center(2);
        nz=z(i)-center(3);
        points=[nx ny nz];
        if axis==0
            points=points*Rx;
        elseif axis==1
            points=points*Ry;
        elseif axis==2
            points=points*Rz;
        else
        end
        nx=points(1)+center(1);
        ny=points(2)+center(2);
        nz=points(3)+center(3);
        newx(i)=nx;
        newy(i)=ny;
        newz(i)=nz;
    end