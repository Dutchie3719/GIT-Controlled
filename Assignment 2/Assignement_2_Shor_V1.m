%% Modelling Assignement Two
% Daniel Shor
% 4745094

%% Reset MATLAB for New Run
%clear
%clc

%% Basic Constants
g = 9.8;                                                                    %% Force of Gravity
dpla = 1.25;
dwater = 1;
%% Preallocating Matricies
vert = [1,2,6;2,4,6;6,4,5;2,4,3;];
tria = [0,0;1,3;1,7;5,3;6,0;2,0];

%% Centers of Triangles
c1 = [1,1];                                                                 %Center Triangle 1
c2 = [2.667,2];                                                             %Center Triangle 2
c3 = [4.333,1];                                                             %Center Triangle 3
c4 = [2.333,4.333];                                                         %Center Triangle 4

centers = vertcat(c1,c2,c3,c4);
centersx = centers(:,1);
centersy = centers(:,2);

centerswet = vertcat(c1,c2,c3);
centersxwet = centerswet(:,1);
centersywet = centerswet(:,2);
%% Area of Triangles
a1 = 3;
a2 = 6;
a3 = 6;
a4 = 8;
areatri = [a1;a2;a3;a4];
totalarea = sum(areatri);
areatriwet = [a1;a2;a3];

areawet = a1+a2+a3;
areadry = totalarea - areawet;

%% Centers of Mass
cx = sum(areatri.*centers(:,1))/totalarea;
cy = sum(areatri.*centers(:,2))/totalarea;
ShapeCenter = [cx cy]

cxwet = sum(areatriwet.*centerswet(:,1))/areawet;
cywet = sum(areatriwet.*centerswet(:,2))/areawet;
ShapeCenterwet = [cxwet cywet]

%% Solve for Bouyant Force
fb = g*dwater*areawet;
fbrem = fb/g;


%% Function to Optimize 
%inputs
m = zeros(4,1);
forces = [fb;fbrem];
x = centersx';
y = centersy';
scalars = [1,1,1,1];

Aeq = vertcat(x,scalars);
Beq = forces;

