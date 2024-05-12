% Input Data for Example Problem 8.1 (1 element )
%{
1--------f=20------------4
|                        | 
ux=uy=0                  3                              
|        
2  
%}

global ndof nnp nel nen nsd neq ngp nee neq 
global nd e_bc s P D
global LM ID IEN flags n_bc e_bc_plot 
global x y nbe number_e_bc
global compute_flux plot_mesh plot_temp plot_flux plot_nod

% material property for 2d linear elastic  material
E=3e7;
niu=0.3;
m=E/(1-niu*niu);
D = m*[1  niu    0;
      niu  1     0;
       0   0 (1-niu)/2];
       
% mesh specifications for 2d liner elastic material
nsd  = 2;         % number of space dimensions
nnp  = 4;         % number of total nodes
nel  = 1;         % number of elements
nen  = 4;         % number of element nodes 
ndof = 2;         % degrees-of-freedom per node --2d vector
neq  = nnp*ndof;  % number of equations
       

f = zeros(neq,1);      % initialize nodal flux vector
d = zeros(neq,1);      % initialize nodal temperature vector vector
K = zeros(neq);        % initialize stiffness matrix

flags = zeros(neq,1);  % array to set B.C flags 
e_bc  = zeros(neq,1);  % essential B.C array
n_bc  = zeros(neq,1);  % natural B.C array
P    = zeros(neq,1);   % initialize point source defined at a node equivalent to boundary flux matrix
%s     = 6*zeros(nen,nel);  % here no  body force which is equivalent to heat source 
s     = 6*zeros(nen*ndof,nel); %it would be 8*16 matrix
% gauss Integration (this variable will call accurate gauss point


ngp    = 2;                          % number of gauss points

% essential BCs
nd   = 2;         % number of nodes on essential boundary -temperature known node
% node:    1x  1y  2x  2y     3x   3y     4x  4y 
flags   =  [2   2  2    2     0     0      0   0]';     % essential boundary is flagged
e_bc(1,1)   =  0; e_bc(2,1)   =  0; e_bc(3,1)   =  0; e_bc(4,1)   =  0; 
% what to plot
compute_flux = 'yes';
plot_mesh    = 'yes';
plot_nod     = 'yes';
plot_temp    = 'yes';
%plot_flux    = 'yes';
% natural BC node number - defined on edges positioned on natural boundary
n_bc  = [ 1              %  node 1 
          4              %  node 2   
          0             %  flux at node 1---fx
          -20            % flux at node 1---fy
           0             %flux at node 2 ---fx
          -20];         %flux at node 2 ----fy
nbe = 1;   % number of edges on the natural boundary
% essential B.C (2d material)node number - defined on edges positioned on natural boundary
%this will be used only for ploting boundary condition
e_bc_plot    = [  1            % node 1
                  2            % node 2
                  0             % flux value at node 1 
                  0 ];          % flux value at node 2 
number_e_bc = 1;   % number of (elemental) edges on the essential boundary

% mesh generation
% node:  1    2    3    4
x   =  [0.0  0.0  2.0  2.0];     % X coordinate
y   =  [1.0  0.0  0.5  1.0];     % Y coordinate

IEN =  [1    2    3    4  ]';     % connectivity array

lem_plotmesh;



 
 