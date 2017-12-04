R=50;
plot(0,0,'o', 'MarkerSize', 2*R);
hold on;

V=10;
[x,y] = meshgrid(-0.01:0.005:0.01,-0.01:0.005:0.01);
% Convert to Cartesian
% x = r.*cos(t);
% y = r.*sin(t);


r=sqrt(x.^2+y.^2);
t=atan2(y,x);


Vr=V.*cos(t).*(1-R.^2./r.^2);
Vt=-V.*sin(t).*(1+R.^2./r.^2);

u=Vr.*cos(Vt);
v=Vr.*sin(Vt);


quiver(x,y,u,v);

hold on;
startx=-0.015:0.002:0.015;
starty=zeros(size(startx));
streamline(x,y,u,v,startx,starty);