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

%% 
clear
clc
%% Imported from Brightspace
% This section holds the basic values for Delauney Triangulation from
% Brightspace, it also includes all basic constants.

%Basic Constants
dwater = 1
dPLA = 1.25
dInfill = 50

%Array from Brightspace
vert = [57.662115 121.03123;
51.136875 119.59852;
49.269885 118.72802;
46.007915 115.27247;
45.423105 113.72127;
45.1818125 111.12697375;
45.801475 108.68435;
47.26467 106.60492125;
49.406495 105.17599;
49.705525 105.03215;
49.145165 104.22347;
48.179005 103.22335;
47.514385 102.57248;
47.134885 102.40087;
43.659745 100.98464;
41.548845 99.996988;
42.770745 98.792378;
46.605055 97.280438;
46.904325 97.021698;
47.360865 96.397098;
50.02388875 93.69863425;
52.951925 92.221148;
54.835745 91.971338;
56.515335 92.176898;
59.75531 94.2567255;
61.440055 98.030308;
60.991745 101.83638;
59.352185 103.84973;
58.994995 104.16588;
59.479185 104.41254;
66.51914375 106.51243375;
74.224825 106.25495;
80.120745 104.78055;
80.965445 104.53175;
80.270695 106.28722;
75.69694 113.482975;
69.414085 118.45012;
62.090625 120.84185];

%Tria is the relation of vert
tria = [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 9;9 10;10 11;11 12;12 13;13 14;14 15;15 16;16 17;17 18;18 19;19 20;20 21;21 22;22 23;23 24;24 25;25 26; 26 27;27 28;28 29;29 30;30 31;31 32;32 33;33 34;34 35;35 36;36 37;37 38;38 1];
%% Solving for the Duck Area

%Using Polyarea to solve for area of simplified duck shape.
%create an Xmatrix and a Ymatrix in order to run polyarea
delx = vert(:,1);
dely = vert(:,2);

xmean = mean(delx);
ymean = mean(dely);

areaduck = polyarea(delx,dely)

%% Solving for Mass of Duck
% Use M = V*d

dduck = dPLA; 
duckmass = areaduck * dduck  

%% Solving for the Centers of Mass of the Triangles

% To find the duck center of mass, the duck must first be simplified into a
% shape. We begin by drawing the delauney triangulation of the duck and
% plotting the triangulations

%Run Delauney Triangulation
deltriangulation = delaunayTriangulation(delx,-dely, tria);

%Find Centers of Triangles
ic = incenter(deltriangulation);

% Create Matricies for later storage
xic = [];
yic = [];
subDuck = [];

% Binary to show if triangle is inside duck or outside duck.
interiortri = deltriangulation.isInterior();

for c = 1:size(interiortri)
    if interiortri(c,1) == 1
        xic = [xic, ic(c,1)];
        yic = [yic, ic(c,2)];
    end
end

%Draw Duck using Figure Function
figure
    hold on
        triplot(deltriangulation);
            patch('faces',deltriangulation(interiortri,:), 'vertices', deltriangulation.Points, 'FaceColor','y','FaceAlpha',.3,'EdgeColor','y');
    scatter(xic,yic,4,'k')
hold off

%Finds every third point in order to calculate the area of a triangle
cl1 = [deltriangulation.Points(deltriangulation.ConnectivityList(:,1),1),deltriangulation.Points(deltriangulation.ConnectivityList(:,1),2)];
cl2 = [deltriangulation.Points(deltriangulation.ConnectivityList(:,2),1),deltriangulation.Points(deltriangulation.ConnectivityList(:,2),2)];
cl3 = [deltriangulation.Points(deltriangulation.ConnectivityList(:,3),1),deltriangulation.Points(deltriangulation.ConnectivityList(:,3),2)];

%Parts of the formula to calculate the surface of the individual triangles
a1 = cl1(:,1).*(cl2(:,2)-(cl3(:,2)));
a2 = cl2(:,1).*(cl3(:,2)-(cl1(:,2)));
a3 = cl3(:,1).*(cl1(:,2)-(cl2(:,2)));

%create an array of the weight of all triangles
area = (a1+a2+a3)/2;
totalArea = 0;

%Put all the triangles into the array
for g = 1:size(interiortri)
    if interiortri(g,1) == 1
        subDuck = [subDuck, area(g,1)];
    end
end

%Center of Mass X Direction
xCOM = subDuck.*xic;
medianPointX = sum(xCOM)/areaduck;

%Center of Mass Y Direction
yCOM = subDuck.*yic;
medianPointY = sum(yCOM)/areaduck;

%% Calculating Water Line
% This section uses the default 1/3 of duck submerged and plots the duck as
% under water

%Duck height scalar
a = .3;

%Calculating the total height of the duck by min and max of Y matrix values
topduck = max(vert(:,2));
bottomduck = min(vert(:,2));
leftduck = min(vert(:,1))
rightduck = max(vert(:,1))
heightDuck = topduck - bottomduck;

%Waterline
waterLine = topduck-a*heightDuck;

%drawing the water line and plotting the center of mass
hold on
    line([40,85],[-waterLine,-waterLine],'Color','blue','LineStyle','--','linewidth',1)
    scatter(medianPointX,medianPointY,'*','MarkerEdgeColor','b')
hold off

%% Waterbox
% This visualizes the vater that is in contact with the duck.


%Create Box of Water
waterboxX = [rightduck, leftduck, leftduck, rightduck]
waterboxY = [-waterLine, -waterLine, -topduck, -topduck]
hold on
    patch(waterboxX,waterboxY,'b','FaceAlpha',.3)
hold off

%Find Area of submerged duck

%Create new delauney that uses the waterline intersection as well
vert_sub = [57.662115 121.03123;
51.136875 119.59852;
49.269885 118.72802;
46.007915 115.27247;
45.423105 113.72127;
45.1818125 111.12697375;
45.801475 108.68435;
47.26467 106.60492125;
49.406495 105.17599;
49.705525 105.03215;
49.145165 104.22347;
48.179005 103.22335;
47.514385 102.57248;
47.134885 102.40087;
43.659745 100.98464;
41.548845 99.996988;
42.770745 98.792378;
46.605055 97.280438;
46.904325 97.021698;
47.360865 96.397098;
50.02388875 93.69863425;
52.951925 92.221148;
54.835745 91.971338;
56.515335 92.176898;
59.75531 94.2567255;
61.440055 98.030308;
60.991745 101.83638;
59.352185 103.84973;
58.994995 104.16588;
59.479185 104.41254;
66.51914375 106.51243375;
74.224825 106.25495;
80.120745 104.78055;
80.965445 104.53175;
80.270695 106.28722;
75.69694 113.482975;
69.414085 118.45012;
62.090625 120.84185];

tria = [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 9;9 10;10 11;11 12;12 13;13 14;14 15;15 16;16 17;17 18;18 19;19 20;20 21;21 22;22 23;23 24;24 25;25 26; 26 27;27 28;28 29;29 30;30 31;31 32;32 33;33 34;34 35;35 36;36 37;37 38;38 1];
%% Solving for the Duck Area

%Using Polyarea to solve for area of simplified duck shape.
%create an Xmatrix and a Ymatrix in order to run polyarea
delxwet = vert(:,1);
delywet = vert(:,2);



%find out which elements are below waterline and creates and index
iswet = dely > waterLine;

%creates new delx and dely of only the values where Y < waterline
delxwet2 = delx(iswet);
delywet2 = dely(iswet);

refmatrix = zeros(38,1);
refmatrix = refmatrix(iswet)

%creates two new matricies that are the left and right points of the duck

lxwet = 0; %left intersection point placeholder var
rxwet = 0; %right intersection point placeholder var

wetleft = [lxwet, -waterLine]; %leftpoint of intersection
wetright = [rxwet,-waterLine]; %right point of intersection

areaduckwet = polyarea(delxwet2,delywet2)
    

