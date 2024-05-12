% Compute and assemble nodal boundary flux vector and point sources 

function f = src_and_flux(f);

f=zeros(neq)
f(1,2)=-20
f(1,4)=-20