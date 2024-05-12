% B matrix function
 
function [B, detJ] = Bmat2Dmaterial(eta,psi,C)
        
      % Calculate the Grad(N) matrix
        GN    = 0.25 * [eta-1  1-eta   1+eta   -eta-1;
                        psi-1  -psi-1  1+psi    1-psi];

        J     = GN*C;       % compute Jacobian matrix 
        detJ  = det(J);     % Jacobian
      
        %B    = J\GN;       % compute the B matrix for 2d scaler heat tranfer
        %B_sigma= inv(J)*derivative_shape; here GN= derivative_shape
        B_sigma= inv(J)*GN; 


        %-- J\GN means solve the solution of x for GN*x=J, equivalent to (GN)^{-1}*J
        %now convert this to 2d vector problem: linear elastic 2d material
        
        B=[B_sigma(1,1)          0       B_sigma(1,2)     0      B_sigma(1,3)      0         B_sigma(1,4)      0;
               0            B_sigma(2,1)     0        B_sigma(2,2)    0         B_sigma(2,3)     0        B_sigma(2,4);
           B_sigma(2,1)     B_sigma(1,1) B_sigma(2,2) B_sigma(1,2) B_sigma(2,3) B_sigma(1,3) B_sigma(2,4) B_sigma(1,4)];
        
   
