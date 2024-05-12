% partition and solve the system of equations
% partition and solve the system of equations
function [d,f_E] = lem_solvedr(K,f,d)
lem_include_flags;

% partition the matrix K, vectors f and d for heat transfer nd= number of nodes in essential boundary
K_E	= K(1:nd*ndof,1:nd*ndof);                     	  % Extract K_E matrix 
K_F	= K(nd*ndof+1:neq,nd*ndof+1:neq);                   % Extract K_E matrix
K_EF    = K(1:nd*ndof,nd*ndof+1:neq);                   % Extract K_EF matrix
f_F  	= f(nd*ndof+1:neq);                        % Extract f_F vector
d_E  	= d(1:nd*ndof);                            % Extract d_E vector

% solve for d_F
d_F	=K_F\( f_F - K_EF'* d_E);
 
% reconstruct the global displacement d
d = [d_E             
     d_F];                
 
% compute the reaction f_E
f_E = K_E*d_E+K_EF*d_F; %this f_E include reaction force

f_prime=f(1:nd*ndof); % this gather only traction force in essential boundary
%write to the workspace
reaction_force=f_E - f_prime


 
% write to the workspace
%solution_vector_d	= d
%reactions_vector 	= f_E