function f=koch(ax,ay,bx,by,c)

if (bx-ax)^2+(by-ay)^2<c
    x=[ax,bx];
    y=[ay,by];
    plot(x,y);
    hold on;
else
    cx=ax+(bx-ax)/3;
    cy=ay+(by-ay)/3;
    dx=bx-(bx-ax)/3;
    dy=by-(by-ay)/3;
    lens=sqrt((dx-cx)^2+(dy-cy)^2);%length of the triangle
    alpha=atan((dy-cy)/(dx-cx));
    
    if (alpha>=0&(dx-cx)<0)|(alpha<=0&(dx-cx)<0)%make sure that the orientation of the triangle is outside
       alpha=alpha+pi;
    end
    
    ey=cy+sin(alpha+pi/3)*lens;
    ex=cx+cos(alpha+pi/3)*lens;
    koch(ax,ay,cx,cy,c);
    koch(dx,dy,bx,by,c);
    koch(cx,cy,ex,ey,c);
    koch(ex,ey,dx,dy,c);
    
end


end
% function f=koch(ax,ay,bx,by,c)
% if (bx-ax)^2+(by-ay)^2<c
%    x=[ax,bx];y=[ay,by];
%    plot(x,y);hold on;
% else
%    cx=ax+(bx-ax)/3;    cy=ay+(by-ay)/3;
%    ex=bx-(bx-ax)/3;   ey=by-(by-ay)/3;
%    l=sqrt((ex-cx)^2+(ey-cy)^2);
%    alpha=atan((ey-cy)/(ex-cx));
%    if (alpha>=0&(ex-cx)<0)|(alpha<=0&(ex-cx)<0)
%        alpha=alpha+pi;
%    end
%    dy=cy+sin(alpha+pi/3)*l;
%    dx=cx+cos(alpha+pi/3)*l;
%    koch(ax,ay,cx,cy,c);
%    koch(ex,ey,bx,by,c);
%    koch(cx,cy,dx,dy,c);
%    koch(dx,dy,ex,ey,c);
% end