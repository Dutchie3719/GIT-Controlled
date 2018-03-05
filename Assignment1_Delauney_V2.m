%Daniel Shor
%Modeling Assignment 1
%4745094
%% Question 1
% Will the duck float in the illustrated configuration?
% 
%  For this assignment, Delauney Triangulation was used to create a shape
%  approximation.
% 

%% Question 2
% Can we change density or emerged height to show that 2d shape will float
% in upright configuration
% 
% 
%  For this assignment, Delauney Triangulation was used to create a shape
%  approximation.
% 

%% Question 3
% What are the new densities and heights? Otherwise, why does it not float
% as intended
% 
% 
%  For this assignment, Delauney Triangulation was used to create a shape
%  approximation.
% 

%% Question 4 
% Which Shape moddeling technique was used?$
% 
% 
%  For this assignment, Delauney Triangulation was used to create a shape
%  approximation.
% 

%% Question 5
% Why this shape modelling technique?
% 
% 
%  Triangulation is a more accurate way of approximating shapes than a
%  cubic or circular shape simplification. After an initial assessment and
%  discussion with the MATLAB TA on how the Triduck.m file worked, I was
%  already begining to understand the implementation of Triduck.m and how
%  shape triangulation could be used. I was however not able to fully
%  implement the 
% 

%% Clear Windows & Vars 
clear
clc

%% Basic Constants

dwater = 1
dPLA = 1.25
dInfill = .50

%% Preallocating Matricies
xic = [];
yic = [];
subDuck = [];
%% Read Polyline Data

fileID = fopen('duckPolyline.txt','r'); % duckPolyline.txt testPolyline.txt testPolyline_sub.txt
formatSpec = '%f %f';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
A=A';

%% Triangulation
node = A;
[m,n] = size(A);

edge = zeros(m,2);
for i=1:m-1
    edge(i,1) = i;
    edge(i,2) = i+1;
end
edge(m,1) = m;
edge(m,2) = 1;

%------------------------------------------- call mesh-gen.
   [vert,etri, ...
    tria,tnum] = refine2(node,edge) ;

%------------------------------------------- draw tria-mesh
    figure(1);
    patch('faces',tria(:,1:3),'vertices',vert, ...
        'facecolor','w', ...
        'edgecolor',[.2,.2,.2]) ;
    hold on; %axis image off;
    axis equal;
    patch('faces',edge(:,1:2),'vertices',node, ...
        'facecolor','w', ...
        'edgecolor',[.1,.1,.1], ...
        'linewidth',1.5) ;
 
    drawnow;
    
    set(figure(1),'units','normalized', ...
        'position',[.05,.50,.30,.35]) ;

%% Caculate the center and the area of the shape
nTri = size(tria, 1); % The number of triangles
nVert = size(vert,1); % The number of vertices

AreaPerTriangle = zeros(nTri,1);
CenterPerTriangle = zeros(nTri,2);
for i=1:nTri
    i1 = tria(i,1); % The index of the first vertex in the i-th triangle
    i2 = tria(i,2);
    i3 = tria(i,3);
    
    v1x = vert(i1,1);   % x-cooridinate of the first vertex
    v1y = vert(i1,2);   % y-cooridinate of the first vertex
    v2x = vert(i2,1);
    v2y = vert(i2,2);
    v3x = vert(i3,1);
    v3y = vert(i3,2);
    
    cen1 = [v1x v1y];
    cen2 = [v2x v2y];
    cen3 = [v3x v3y];

        
end
    a1 = cen1(:,1).*(cen2(:,2)-(cen3(:,2)));
    a2 = cen2(:,1).*(cen3(:,2)-(cen1(:,2)));
    a3 = cen3(:,1).*(cen1(:,2)-(cen2(:,2)));

    %create an array of the area of all triangles
    area = (a1+a2+a3)/3;
    areaduck = 0;
        
ShapeCenter = [0 0];
areaduck = 0;

%% Solving for the Duck Area

%Using Polyarea to solve for area of simplified duck shape.
%create an Xmatrix and a Ymatrix in order to run polyarea
delx = vert(:,1);
dely = vert(:,2);

areaduck = polyarea(delx,dely);

%% Solving for Mass of Duck
% Use M = V*d

dduck = dPLA * dInfill; 
duckmass = areaduck * dduck 


hold on;
plot(ShapeCenter(1,1),ShapeCenter(1,2),'r*');
disp([' Center: ' sprintf('%6.3f %6.3f',ShapeCenter(1,1), ShapeCenter(1,2))]);
disp([' Area: ' sprintf('%6.3f',areaduck)]);
  