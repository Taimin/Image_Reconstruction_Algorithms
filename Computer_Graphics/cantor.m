function [ f ] = cantor( ax,ay,bx,by )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=0.005;
d=0.005;

if (bx-ax)>c
    x=[ax,bx];
    y=[ay,by];
    hold on;
    plot(x,y,'Linewidth',2);
    hold off;
    cx=ax+(bx-ax)/3;
    cy=ay-d;
    dx=bx-(bx-ax)/3;
    dy=by-d;
    ay=ay-d;
    by=by-d;
    cantor(ax,ay,cx,cy);
    cantor(dx,dy,bx,by);
end

end

