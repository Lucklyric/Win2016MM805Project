function [px,py]=project(x,y,z,fx,fy,cx,cy)
    px=(fx*x+cx*z)/z;
    py=(fy*y+cy*z)/z;