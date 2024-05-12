% Input Data for Example Problem 8.1 (16 element mesh)
%{
21---22---23---24---25
|                ---20
|           ---19   
|      ---18        15
|    17         14
16---       13      10        
|    12          9   
11           8      5
|    7           4
6           3     
|    2    
1  
%}
global ndof nnp nel nen nsd neq ngp nee neq
global nd e_bc s P D
global LM ID IEN flags n_bc 
global x y nbe
global compute_flux plot_mesh plot_temp plot_flux plot_nod

%{             
% material property for heat transfer
k  = 5;        % thermal conductivity
D  = k*eye(2); % conductivity matrix
%}

% material property for 2d linear elastic  material
E=3e11;
niu=0.3;
m=E/(1-niu*niu);
D = m*[1  niu    0;
      niu  1     0;
       0   0 (1-niu)/2];
%{
% mesh specifications for heat transfer
nsd  = 2;         % number of space dimensions
nnp  = 25;         % number of nodal nodes
nel  = 16;         % number of elements
nen  = 4;         % number of element nodes 
ndof = 1;         % degrees-of-freedom per node ,it will be change for 2d material
neq  = nnp*ndof;  % number of equations
%}

% mesh specifications for 2d liner elastic material
nsd  = 2;         % number of space dimensions
nnp  = 25;         % number of nodal nodes
nel  = 16;         % number of elements
nen  = 4;         % number of element nodes 
ndof = 2;         % degrees-of-freedom per node --2d vector
neq  = nnp*ndof;  % number of equations

%{
f = zeros(neq,1);      % initialize nodal source vector
d = zeros(neq,1);      % initialize nodal temperature vector
K = zeros(neq);        % initialize stiffness matrix
%}

f = zeros(neq,1);      % initialize nodal force(sum of boundary flux+ body force+ reaction force) vector
d = zeros(neq,1);      % initialize nodal displacement vector
K = zeros(neq);        % initialize stiffness matrix

%{
flags = zeros(neq,1);  % array to set B.C flags 
e_bc  = zeros(neq,1);  % essential B.C array
n_bc  = zeros(neq,1);  % natural B.C array
P    = zeros(neq,1);   % initialize point source defined at a node
s     = 6*ones(nen,nel);  % heat source- uniform heat source throughout matereial
%}

flags = zeros(neq,1);  % array to set B.C flags 
e_bc  = zeros(neq,1);  % essential B.C array
n_bc  = zeros(neq,1);  % natural B.C array
P    = zeros(neq,1);   % initialize point source defined at a node equivalent to boundary flux matrix
%s     = 6*zeros(nen,nel);  % here no  body force which is equivalent to heat source 
s     = 6*zeros(nen*ndof,nel);
% gauss Integration (this variable will call accurate gauss point
ngp    = 2;                          % number of gauss points

%{
% boundary conditions and point forces for heat transfer
nd = 9;     % number of nodes on essential boundary
%}

% boundary conditions and point forces for heat transfer
nd = 5;     % number of nodes on essential boundary, it would be twice since dof=2

%{
% essential B.C. for heat transfer
No of equation is 25
flags(1:5)    = 2;      e_bc(1:5)     = 0.0;
flags(6:5:21) = 2;      e_bc(6:5:21)  = 0.0;
%}

% essential B.C. for 2d liner elastic material
%no of equation is 50
flags(1:10:50) = 2;      e_bc(1:10:50)  = 0.0; %x component ( only this was count in heat transfer)
flags(2:10:50) = 2;      e_bc(2:10:50)  = 0.0; % completely constraint so dx=dy=0 for this point
%flag value 2 is assigned for creating ID and LM matrix, flag will be check and


%{
% plots for heat transfer
compute_flux = 'yes';
plot_mesh    = 'yes';
plot_nod     = 'yes';
plot_temp    = 'yes';
plot_flux    = 'yes';
%}
% plots for 2d linear elastic material
compute_flux = 'yes'; %equivalent to total force =flux
plot_mesh    = 'yes';
plot_nod     = 'yes';
plot_temp    = 'yes'; %equivalent to displacement= temp
%plot_flux    = 'yes'; %no need to plot total force at each nodal point

%{
% natural B.C (heat transfer)node number - defined on edges positioned on natural boundary
n_bc    = [  21    22    23    24                % node 1
                   22    23    24    25          % node 2
                  20     20    20    20          % flux value at node 1 
                  20     20    20    20 ];       % flux value at node 2 
nbe = 4;   % number of edges on the natural boundary
%}
% natural B.C (2d material)node number - defined on edges positioned on natural boundary
n_bc    = [  1    6    11    16                % node 1
                  6    11    16    21          % node 2
                  20   20    20    20          % flux value at node 1 
                  20   20    20    20 ];       % flux value at node 2 
nbe = 4;   % number of (elemental) edges on the natural boundary

%%- setup the mesh (this section is same for heat transfer and 2d linear elastic material)
for node = 1:nnp    % loop over all nodes
     
% Node #, x coords
if (mod(node,5) == 1)
    x(node) = 0*(2/4);
elseif (mod(node,5) == 2)
    x(node) = 1*(2/4);
elseif (mod(node,5) == 3)
    x(node) = 2*(2/4);
elseif (mod(node,5) == 4)
    x(node) = 3*(2/4);
elseif (mod(node,5) == 0)
    x(node) = 4*(2/4);
end
 
% Node #, y coords
if ((node/5) <= 1)
    y(node) = 0 + (0.5/2)*((node-1)/2);
elseif ((1 < (node/5)) && ((node/5) <= 2))
    y(node) = 0.25 + ((0.5-(1/8))/2)*((node-6)/2);
elseif ((2 < (node/5)) && ((node/5) <= 3))
    y(node) = 0.5 + ((0.5-(2/8))/2)*((node-11)/2);
elseif ((3 < (node/5)) && ((node/5) <= 4))
    y(node) = 0.75 + ((0.5-(3/8))/2)*((node-16)/2);
elseif ((4 < (node/5)) && ((node/5) <= 5))
    y(node) = 1 + ((0.5-(4/8))/2)*((node-21)/2);
end
 
end
% Element #, connectivity
rowcount = 0;
for elementcount = 1:nel
    IEN(1,elementcount) = elementcount + rowcount;
    IEN(2,elementcount) = elementcount + 1 + rowcount;
    IEN(3,elementcount) = elementcount + 6 + rowcount;
    IEN(4,elementcount) = elementcount + 5 + rowcount;
    if mod(elementcount,4) == 0
        rowcount = rowcount + 1;
    end
end


lem_plotmesh;

%
% generate ID array and LM array 

 
 