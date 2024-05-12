% assemble element matrices and vectors
function [K,f] = lem_assembly(K,f,e,ke,fe)
include_flags;


for loop1 = 1:nen*ndof %no of node per element
    i = LM(loop1,e);
    f(i) =  f(i) + fe(loop1);   % assemble forces at paralel to essential position, need to change it to down side
    for loop2 = 1:nen*ndof
        j = LM(loop2,e);
        K(i,j) = K(i,j) + ke(loop1,loop2);  % assemble stiffness
    end
end

