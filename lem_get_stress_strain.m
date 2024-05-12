function lem_get_stress_strain(d,e,D);
include_flags;

%de = d(LM(:,e));    % extract displacement at  element nodes

% get coordinates of element nodes 
je = IEN(:,e);  
C  = [x(je); y(je)]'; 

[w,gp] = gauss(ngp);   % get Gauss points and weights

% compute flux vector
%ind = 1;
for i=1:ngp
   for j=1:ngp
       eta = gp(i);  psi = gp(j);
      
       %N             = NmatHeat2D(eta,psi);
       N             = Nmat2Dmaterial(eta,psi);
       %[B, detJ]     = BmatHeat2D(eta,psi,C);
       [B, detJ]     = Bmat2Dmaterial(eta,psi,C);
       
       strain = B*d %strain at gauss each points
       
       sigma = D*strain %stress at each gauss points
       
       von_misses= sqrt(square(sigma(1,1))+ square(sigma(2,1)) - 2*sigma(1,1)*sigma(2,1)) 

   end
end



%{
q_x = q(1,:);
q_y = q(2,:);

%          #x-coord     y-coord    q_x(eta,psi)  q_y(eta,psi)
flux_e1  = [X(:,1)       X(:,2)        q_x'              q_y'];
fprintf(1,'\t\t\tx-coord\t\t\t\ty-coord\t\t\t\tq_x\t\t\t\t\tq_y\n');
fprintf(1,'\t\t\t%f\t\t\t%f\t\t\t%f\t\t\t%f\n',flux_e1');

if strcmpi(plot_flux,'yes')==1 & strcmpi(plot_mesh,'yes') ==1;  
    figure(1); 
    quiver(X(:,1),X(:,2),q_x',q_y','k');%-- see quiver document https://www.mathworks.com/help/matlab/ref/quiver.html
    plot(X(:,1),X(:,2),'rx');
    title('Heat Flux');
    xlabel('X');
    ylabel('Y');
end
%}

