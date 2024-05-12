function f = lem_src_and_flux(f)
include_flags;

% Assemble point sources 
f(ID) = f(ID) + P(ID); %if f is in ID position then it all known f is at the top of f vector


% Compute nodal boundary flux vector
for i = 1:nbe %number of edges in natural boundary
    
        %fq      = [0 0 0 0]';            % initialize the nodal source vector
        node1   = n_bc(1,i);        % first node-singleelement-1
        node2   = n_bc(2,i);         % second node-singleelement-4
        %n_bce   = n_bc(3:6,i);      % flux value at an edge
        Tx1 = n_bc(3,i);             %first node x direction traction
        Ty1 = n_bc(4,i);             %first node y direction traction
        Tx2 = n_bc(5,i);            %second node x direction traction
        Ty2 = n_bc(6,i);             %second node y  direction traction
        
        x1 = x(node1); y1=y(node1);    % coord of the first node
        x2 = x(node2); y2=y(node2);    % coord of the second node
    
        leng = sqrt((x2-x1)^2 + (y2-y1)^2);  % edge length
        J    = leng/2;                       % 1D Jacobian 
    
        
        [w,gp] = gauss(ngp);                % get gauss points and weights
        % initialize some variable
        fq_x1 = 0; fq_y1 = 0;
        fq_x2 = 0; fq_y2 = 0;
        
        for i=1:ngp                         % integrate in psi direction (1D integration)  
               
            psi = gp(i);     
            wj = 1; % for two point gauss guadrature w1=w2=1 . or use another for loop

            N1   = 0.5*(1-psi); 
            N2   = 0.5*(1+psi);       % 1D  shape functions in parent domain (2 degree of freedom)
            
            Tx = N1 * Tx1 + N2 * Tx2;
            Ty = N1 * Ty1 + N2 * Ty2;
            
            % Properly use variables to accumulate forces
            fq_x1 = fq_x1 + wj * N1 * Tx * J
            fq_y1 = fq_y1 + wj * N1 * Ty * J
            fq_x2 = fq_x2 + wj * N2 * Tx * J
            fq_y2 = fq_y2 + wj * N2 * Ty * J
 
        end
      
        f(ID((node1*2)-1)) = f(ID((node1*2)-1)) + fq_x1; %node1=1 singleelement
        f(ID((node1*2))) = f(ID(node1*2)) + fq_y1;
        f(ID((node2*2)-1)) =  f(ID(node2*2)) + fq_x2; %node2=4 for singleelement
        f(ID(node2*2))   = f(ID(node2*2)) + fq_y2; %still now all known f is at the top of the f matrix
       
       
        
end    

    
    


                
                
                
        
