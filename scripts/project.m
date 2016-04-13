function [px,py]=project(x,y,z,f)
    px=(x/z)*f;
    py=(y/z)*f;