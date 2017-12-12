clear;clc; clf
V = 1;
mu = 1; gam = -2;
a = -2; a = a*pi/180; 
e = 0.2;
f = .1;
te = .05; 
n = 2 - te; 
tea = (n^2-1)/3; 

R = 1 + e;
theta = 0:pi/400:2*pi;  
y = R * sin(theta) ;   
x = R * cos(theta);
zeta = (x - e) + j.*(y + f);
rot = exp(j*a); 
whoop = rot .* (zeta + tea*1./zeta); 
airx = real(whoop); airy = imag(whoop);
plot(airx, airy, 'r'), axis image, hold on

rads = R:.05:2*R

for m = 1:length(theta)
    for n = 1:length(rads)  
         xp = rads(n)*cos(theta(m));
         yp = rads(n)*sin(theta(m));
         
         z = (xp - e) + j.*(yp + f);
         rot = exp(j*a); 
         w = rot .* (z + tea*1./z); 
         xnew = real(w);
         ynew = imag(w);
        
        xx(m,n) = xnew; yy(m,n) = ynew;
        psis(m,n) = V * yp/R - mu * (yp/R)/((xp/R)^2+(yp/R)^2) ...
           - (gam/4/pi)*log((xp/R)^2+(yp/R)^2);

        %psis(m,n) = V * ynew - mu * ynew/(xnew^2+(ynew+.01)^2) ...
         %  - (gam/4/pi)*log(xnew^2+(ynew+.01)^2);
        %phis(m,n) = V * xnew(m) + mu * xnew(m)/(xnew(m)^2+(ynew(n)+.01)^2) ...
        %    + (gam/2/pi)*atan2(ynew(n), xnew(m));
       
        %scatter(xnew,ynew), hold on
    end
end
contour(xx,yy,psis,[-3:.05:3],'k'), axis image