clf; clear; clc
mu = 1; gam = 0; V=1;a = -2; % in degrees
a = a*pi/180; % Conversion to radians
e = 0.1; f = 0;te = .05; n = 2 - te; % Number related to trailing edge angle.
tea = (n^2-1)/3;
rot = exp(j*a);


R = 1 + e;
theta = 0:pi/100:2*pi;  
y = R * sin(theta);     
x = R * cos(theta);

for m = 1:length(x)
    for n = 1:length(y)      
        u = 1+(y(n)^2-x(m)^2)/((y(n)^2+x(m)^2).^2) - (gam/2/pi)*y(n)/(y(n)^2+x(m)^2);
        v = -(2*x(m)*y(n))/(y(n)^2+x(m)^2) + (gam/2/pi)*x(m)/(y(n)^2+x(m)^2);
        z = (u - e) + j.*(v + f);
        w = rot .*(z + tea*1./z);
        uTRAN(m, n) = real(w); vTRAN(m, n) = imag(w);
        xx(m,n) = x(m); yy(m,n) = y(n);
    end
end
figure
quiver(x, y, uTRAN, vTRAN)
%streamline(xx,yy,uTRAN,vTRAN,[0:0:0],[-1:.1:1]), axis image
%axis([-5 5 -5 5])
