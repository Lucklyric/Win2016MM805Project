function [xbar,ybar]=xybar(simcasep)
    xbar=0;
    ybar=0;
    count=0;
    [r,c]=size(simcasep);
    for i=1:r
        for j=1:c
            if simcasep(i,j)==1
                xbar=xbar+i;
                ybar=ybar+j;
                count=count+1;
            end
        end
    end
    xbar=xbar/count;
    ybar=ybar/count;