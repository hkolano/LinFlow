% Joukowski transformation MATLAB code
%
% Example of conformal mapping of a circle to an airfoil
% AE425-ME425 Aerodynamics
% Daniel T. Valentine .................... January 2009
% Circle in (xp,yp) plane: R = sqrt(xp�2 + yp�2), R > 1
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
theta = 0:pi/200:2*pi;  
yp = R * sin(theta);     
xp = R * cos(theta);
% Step 3: Transform coordinates of circle from zp-plane to z-plane:
z = (xp - e) + j.*(yp + f);
% Step 4: Transform circle from z-plane to airfoil in w-plane
% (the w-plane is the "physical" plane of the airfoil):
rot = exp(j*a); % Application of angle of attack.
w = rot .* (z + tea*1./z); % Joukowski transformation.
% Step 5: Plot of circle in z-plane on top of airfoil in w-plane
plot(xp,yp), hold on
plot(real(w),imag(w),'r'),axis image, hold off