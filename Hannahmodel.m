clf; clear; clc
mu = 1; gam = 0; V=1;a = -2; % in degrees
a = a*pi/180; % Conversion to radians
e = 0.1; f = 0;te = .05; n = 2 - te; % Number related to trailing edge angle.
tea = (n^2-1)/3;

R = 1 + e;
theta = 0:pi/100:2*pi;  
y = R * sin(theta);     
x = R * cos(theta);

rot = exp(j*a);

for m = 1:length(x)
for n = 1:length(y)
    
    z = (x(m) - e) + j.*(y(n) + f);
    w = rot .*(z + tea*1./z);
    newx = real(w); newy = imag(w);
    
    xx(m,n)= newx; 
    yy(m,n)= newy;  
    psis(m,n) = (V * y(n)) - mu * y(n)./(x(m).^2+y(n).^2) ...
    - (gam/4/pi).*log(x(m)^2+y(n)^2); 
    %xx(m,n) = newx; yy(m,n) = newy;
    %plot(newx,newy,'r'),axis image, hold on
end
end
contour(xx,yy,psis,[-3:.1:3],'k'), axis image, hold on
axis([-5 5 -5 5])
