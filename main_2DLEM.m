%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Liner elastic 2d material         %
%  problem 9.1 of first course of finite element analysis jacob fish    %
%heat transfer code is transfere to liner elastic material  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all; 

% include global variables
lem_include_flags;

% Preprocessing
[K,f,d] = lem_preprocessor;
 
% Evaluate element conductance matrix, nodal source vector and assemble
for e = 1:nel
    [ke, fe] = lem_2Delem(e); 
    [K,f] = lem_assembly(K,f,e,ke,fe);
end

% Compute and assemble nodal boundary flux vector and point sources
%f = lem_src_and_flux(f);
f = lem_src_and_flux(f)


% Solution
[d,f_E] = lem_solvedr(K,f,d);

%PPostprocessor
lem_postprocessor(d);
%stress, strain, von misses stress
%for 16 element stress strain calculation will be compelicated since d is a 50*1 matric. I can improve in this point
%ranning this for multiple elements suppress the next line
lem_get_stress_strain(d,e)
%scale_factor=10000 %one element
scale_factor=10000 %16 elements
lem_deformed_undeformed(d, x, y, IEN, nel,e, nen, ID, scale_factor)
 