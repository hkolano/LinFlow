clf
mu = 1; gam = 0; V=1;
x = -3:.02:3;
y = -2:.02:2;
for m = 1:length(x)
for n = 1:length(y)
xx(m,n) = x(m); yy(m,n) = y(n);
psis(m,n) = V * y(n) - mu * y(n)/(x(m)^2+(y(n)+.01)^2) ...
- (gam/4/pi)*log(x(m)^2+(y(n)+.01)^2);
end
end
% contour(xx,yy,psis,[-3:.3:3],'k'), axis image
% figure;

% Joukowski transformation MATLAB code
%
% Example of conformal mapping of a circle to an airfoil
% AE425-ME425 Aerodynamics
% Daniel T. Valentine .................... January 2009
% Circle in (xp,yp) plane: R = sqrt(xpˆ2 + ypˆ2), R > 1
% Complex variables of three complex planes of interest:
% zp = xp + i*yp ==> Circle plane
% z = x + i*y ==> Intermediate plane
% w = u + i*v ==> Airfoil (or physical) plane
clear;clc
% Step 1: Select the parameters that define the airfoil of interest.
% (1) Select the a == angle of attack alpha
a = -2; % in degrees
a = a*pi/180; % Conversion to radians
% (2) Select the parameter related to thickness of the airfoil:
e = 0.1;
% (3) Select the shift of y-axis related to camber of the airfoil:
f = 0;
% (4) Select the trailing edge angle parameter:
te = .05; % 0 < te < 1 (0 ==> cusped trailing edge)
n = 2 - te; % Number related to trailing edge angle.
tea = (n^2-1)/3; % This is a Karman-Trefftz extension.
% Step 2: Compute the coordinates of points on circle in zp-plane:
R = 1 + e;
mu = 1; gam = 0; V=1;


theta = 0:pi/200:2*pi;  
yp = R * sin(theta);     
xp = R * cos(theta);

x = -3:.02:3;
y = -3:.02:3;
% Step 3: Transform coordinates of circle from zp-plane to z-plane:
for m = 1:length(x)
for n = 1:length(y)
z = (x(m) - e) + 1i.*(y(n) + f);
% Step 4: Transform circle from z-plane to airfoil in w-plane
% (the w-plane is the "physical" plane of the airfoil):
rot = exp(1i*a); % Application of angle of attack.
w(m,n) = rot .* (z + tea.*1./z); % Joukowski transformation.
% Step 5: Plot of circle in z-plane on top of airfoil in w-plane

xx(m,n) = real(w(m)); yy(m,n) = imag(w(n));
psis(m,n) = V * imag(w(n)) - mu * imag(w(n))/(real(w(m))^2+(imag(w(n))+.01)^2) ...
- (gam/4/pi)*log(real(w(m))^2+(imag(w(n))+.01)^2);


end
end
contour(xx,yy,psis,[-3:.02:3],'k'), axis image
% plot(x,y), hold on
plot(real(w),imag(w),'r'),axis image