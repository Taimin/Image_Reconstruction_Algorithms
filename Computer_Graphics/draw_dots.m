hold on; %together with bio_chaos.m
% for n=1:N   %two fold iteration, so slow and frustrating
%    for m=50:200
%        plot(u(n),X(m,n),'k.','markersize',2);
%    end
% end

for m=200:301 %much better and quicker
    plot(u,X(m,:),'k.','markersize',2);
end