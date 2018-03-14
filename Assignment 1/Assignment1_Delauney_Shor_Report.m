%Daniel Shor
%Modeling Assignment 1
%4745094

%% Introduction to Forces
%  
%  There are two forces acting on the duck. The first, is the force of
%  gravity -- Fg(N) = M(g)*9.8(m*s^2). The second is the buoyant force on
%  the duck -- Fb(N) = ?(g/m^3)*9.8(m*s^2)V(m^3). ? is the density of the
%  object, and V is the volume of the displaced fluid (submerged volume).
%  If the duck is to float, the force vector must be equivilent (have the
%  same length) and opposite (have the same x-axis value). In order to
%  determine if the duck will float, we must do the following:
%       1) Find the total area of the duck
%       2) Find the center of mass
%       3) Find the force of gravity on the duck (Fg)
%       4) Find the submerged area
%       5) Find the center of mass for the submerged area
%       6) Find the force of bouyancy (Fb)        

%% 1) Find the total area of the duck
% 
%%
% 
%   for x = 1:10
%       disp(x)
%   end
% 
AreaPerTriangle(i) = abs(((v1x*(v2y - v3y)) + (v2x*(v3y - v1y)) + (v3x*(v1y - v2y))) / 2);
%  PREFORMATTED
%  TEXT
% 

