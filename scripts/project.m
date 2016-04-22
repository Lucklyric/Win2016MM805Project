%% this function contain the projection model that project the 3D object to 2D plane
function [px,py]=project(x,y,z,fx,fy,cx,cy)
    px=(fx*x+cx*z)/z;
    py=(fy*y+cy*z)/z;