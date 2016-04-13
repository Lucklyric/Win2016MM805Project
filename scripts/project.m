function [px,py]=project(x,y,z,f,cx,cy)
    px=(f*x+cx*z)/z;
    py=(f*y+cy*z)/z;