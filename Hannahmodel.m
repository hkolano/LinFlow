clf; clear; clc
mu = 1; gam = 0; V=1;a = -2; % in degrees
a = a*pi/180; % Conversion to radians
e = 0.1; f = 0;te = .05; n = 2 - te; % Number related to trailing edge angle.
tea = (n^2-1)/3;
rot = exp(j*a);


R = 2 + e;
theta = 0:pi/100:2*pi;  
y = R * sin(theta);     
x = R * cos(theta);

for m = 1:length(x)
    for n = 1:length(y)
        psis(m,n) = V * y(n) - mu * y(n)/(x(m)^2+(y(n)+.01)^2) ...
            - (gam/4/pi)*log(x(m)^2+(y(n)+.01)^2);
        phis(m,n) = V * x(m) + mu * x(m)/(x(m)^2+(y(n)+.01)^2) ...
            + (gam/2/pi)*atan2(y(n), x(m));
        func = phis(m,n) + j.*psis(m,n);
        w = rot .*(func + tea*1./func);
        PHI(m, n) = real(w); PSI(m, n) = imag(w);
        
         %z = (x(m) - e) + 1i.*(y(n) + f);
         %zed = z + tea.*1./z; 
         %xx(m,n) = real(zed); yy(m,n) = imag(zed);
        xx(m,n) = x(m); yy(m,n) = y(n);
    end
end
contour(xx,yy,PHI,[-3:.3:3],'c'), axis image, hold on
contour(xx,yy,PSI,[-3:.3:3],'k'), axis image
%axis([-5 5 -5 5])
%figure
%quiver(x, y, uTRAN, vTRAN)
%streamline(xx,yy,uTRAN,vTRAN,[0:0:0],[-1:.1:1]), axis image

