

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
    
    v1 = [v1x v1y];
    v2 = [v2x v2y];
    v3 = [v3x v3y];
    
    
    % WRITE YOUR CODE HERE %
    % CenterPerTriangle(i,:) = ?  
    % AreaPerTriangle(i) = ?
        
end

ShapeCenter = [0 0];
totalArea = 0;

% WRITE YOUR CODE HERE %
% ShapeCenter = ?
% totalArea = ?

hold on;
plot(ShapeCenter(1,1),ShapeCenter(1,2),'r*');
disp([' Center: ' sprintf('%6.3f %6.3f',ShapeCenter(1,1), ShapeCenter(1,2))]);
disp([' Area: ' sprintf('%6.3f',totalArea)]);
  