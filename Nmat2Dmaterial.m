% Shape function 
 
function N = Nmat2Dmaterial(eta,psi)
        % shape functions 2d scaler
        N_prime  = 0.25 * [(1-psi)*(1-eta)  (1+psi)*(1-eta)  (1+psi)*(1+eta)  (1-psi)*(1+eta)]; % shape functions 2d scaler
        % shape functions 2d vector
        N  =[N_prime(1)    0    N_prime(2)   0   N_prime(3)  0   N_prime(4)    0;
                0      N_prime(1)   0    N_prime(2)  0    N_prime(3)  0   N_prime(4)];