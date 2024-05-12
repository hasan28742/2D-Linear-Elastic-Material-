 function [ke, fe] = lem_2Delem(e)
 %element wise stiffness and force matrix
include_flags;

%ke  = zeros(nen,nen);    % initialized element conductance matrix
ke  = zeros(nen*ndof,nen*ndof); %heat transfer conductance was 4*4 matrix, linearElastic is 8*8 matrix
fe  = zeros(nen*ndof,1);      % initialize element nodal source vector equal to body force


% get coordinates of element nodes 
je = IEN(:,e);  
C  = [x(je); y(je)]'; 

[w,gp] = gauss(ngp);    % calling gauss subroutine
%{
% compute element conductance matrix and nodal flux vector 
for i=1:ngp
   for j=1:ngp
       eta = gp(i);            
       psi = gp(j);
 
       N             = NmatHeat2D(eta,psi);       % shape functions matrix  
       [B, detJ]     = BmatHeat2D(eta,psi,C);     % derivative of the shape functions

       ke = ke + w(i)*w(j)*B'*D*B*detJ;   % element conductance matrix
       se = N*s(:,e);                     % compute s(x)
       fe = fe + w(i)*w(j)*N'*se*detJ;    % element nodal source vector

   end       
end
%}

% compute element stifness matrix and elemental force matrix for 2d material
for i=1:ngp
   for j=1:ngp
       eta = gp(i);            
       psi = gp(j);
 
       N             = Nmat2Dmaterial(eta,psi);       % shape functions matrix  
       [B, detJ]     = Bmat2Dmaterial(eta,psi,C);     % derivative of the shape functions

       ke = ke + w(i)*w(j)*B'*D*B*detJ;   % element conductance matrix
       se = N*s(:,e);                     % compute s(x)or body force calculation
       fe = fe + w(i)*w(j)*N'*se*detJ;    
       % element nodal source or body force matrix vector which is zero since no body force

   end       
end




