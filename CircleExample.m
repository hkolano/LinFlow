clf
mu = 1; gam = 0; V=1;
x = -3:.02:3;
y = -2:.02:2;
for m = 1:length(x)
for n = 1:length(y)
xx(m,n) = x(m); yy(m,n) = y(n);
psis(m,n) = V * y(n) - mu * y(n)/(x(m)^2+(y(n)+.01)^2) ...
- (gam/4/pi)*log(x(m)^2+(y(n)+.01)^2);
phis(m,n)= V * x(m) + mu * y(n)/(x(m)^2+(y(n)+.01)^2) ...
+ (gam/2/pi)*atan2(y(n),x(m));

[dx, dy] = gradient(phis,0.2,0.2);
end
end
%contour(xx,yy,psis,[-3:.3:3],'k'), axis image, hold on
%contour(xx,yy,grad,[-3:.3:3],'r'), axis image
starty = [-1:.1:1]
startx = -1.*ones(size(starty))
quiver(xx, yy, dx, dy)
streamline(xx, yy, dx, dy,startx, starty)


