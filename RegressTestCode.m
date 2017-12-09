sig = 1;
 % Source strength
 % GRID:
 x = -150:.02:150;
 y = 0:.02:100;
 for m = 1:length(x)
   for n = 1:length(y)
     xx(m,n) = x(m);
     yy(m,n) = y(n);
     % Velocity potential function:
     phi_Source(m,n) = (sig/4/pi) * log(x(m)^2+(y(n)+.01)^2);
     % Stream function:
     psi_Source(m,n) = (sig/2/pi) * atan2(y(n),x(m));
   end
 end
 % Plots 
 % Source at origin of coordinate system:
 contour(xx,yy,psi_Source,(-0.5:.5:5),'k')
 hold on
 contour(xx,yy,phi_Source,10,'r')
 legend('streamlines' ,'potential')
 title(' Source at origin')
 axis image
 hold off