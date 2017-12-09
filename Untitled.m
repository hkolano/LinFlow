%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Flow Around a Joukowski Airfoil Using Complex Variables %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This program will plot the streamlines about a Joukowski airfoil at an
% angle of attack.  Before running this script in Matlab, you may need to
% set some variables:
%  U: the flow velocity at infinity.  Defaults to 1 if not set.
%  alp: the angle of attack, in degrees.  Defaults to 0 if not set.
%  r0: the radius of the cylinder from which the airfoil is mapped.
%      To get a Joukowski airfoil, this must be a bit greater than 1.  If it
%      is 1, you get a flat plate "airfoil".  Defaults to 1 if not set.
%  Gamma: the circulation around the cylinder/airfoil.
%         Defaults to 0 if not set.
%         Warning: the value of Gamma will be overwritten if variable auto
%         below is nonzero.
%  auto: if this variable is nonzero, Gamma is automatically computed from
%        the Kutta condition, overwriting its current value.
%        Defaults to 1 if not set.
%  phi_te: undocumented feature.  Defaults to zero if not set.

% set the flow velocity at large distance if it is not yet set
if exist('U') ~= 1
  U=1
end

% set the angle of attack in degrees if it is not yet set
if exist('alp') ~= 1
  alp=0
end

% set radius of the cylinder if it is not yet set
if exist('r0') ~= 1
    r0=2
end

% set a value for the circulation if it is not yet set
if exist('Gamma') ~= 1
    Gamma=0
end
% set a value for automatically changing Gamma if it is not yet set
if exist('auto') ~= 1
    auto=1
end

% location of the trailing edge on the cylinder in degrees
if exist('phi_te') ~= 1
    phi_te=0
end

% create mesh points around the cylinder in the zeta (i.e. zeta_2) plane
[phi,rho]=meshgrid([-.001:5:360]*pi/180,[r0-.0001:.05:3]);
[xi,eta]=pol2cart(phi,rho);
zeta=xi+i*eta;

% If auto is nonzero, compute Gamma from the Kutta condition
if auto ~= 0
    Gamma=4*pi*U*r0*sin((alp-phi_te)/180*pi)
end

% compute the complex velocity potential at the mesh points
F=U*(zeta*exp(-j*alp/180*pi)+r0^2*exp(j*alp/180*pi)./zeta)+...
    j*Gamma/(2*pi)*log(zeta/r0);

% compute the real streamfunction
psi=imag(F);

% compute the Joukowski mapped physical coordinate z = x + i y
shift=r0*exp(j*phi_te/180.*pi)-1;
z=(zeta-shift)+1./(zeta-shift);

% compute the corresponding real coordinates
x=real(z);
y=imag(z);

% plot the streamlines in the zeta plane
figure(1)
contour(xi,eta,psi,floor(min(min(psi))):.25:ceil(max(max(psi))))
axis('equal')

% plot the streamlines in the z-plane
figure(2)
contour(x,y,psi,floor(min(min(psi))):.25:ceil(max(max(psi))))
axis('equal')

% plot the pressure
W=(U*(exp(-j*alp/180*pi)-r0^2*exp(j*alp/180*pi)./zeta.^2)+...
    j*Gamma./(2*pi*zeta))./(1.-1./(zeta-shift).^2);
p=-.5*W.*conj(W);
figure(3)
contour(x,y,psi,floor(min(min(psi))):.25:ceil(max(max(psi))))
hold on
contour(x,y,p,-5:.25:5)
axis('equal')
hold off