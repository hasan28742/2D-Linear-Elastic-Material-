function lem_plotmesh
lem_include_flags;

if strcmpi(plot_mesh,'yes')==1;  
% plot essential BC
for i=1:number_e_bc  %number_e_bc = 4; umber of (elemental) edges on the essentiaL boundary

    
        node1 = e_bc_plot(1,i);        % first node
        node2 = e_bc_plot(2,i);        % second node
   
        x1 = x(node1); y1=y(node1);    % coord of the first node
        x2 = x(node2); y2=y(node2);    % coord of the second node

        plot([x1 x2],[y1 y2],'r','LineWidth',4); hold on
end
    legend('essential B.C. (totally constraint)');

    for i = 1:nel
        XX = [x(IEN(1,i)) x(IEN(2,i)) x(IEN(3,i)) x(IEN(4,i)) x(IEN(1,i))];
        YY = [y(IEN(1,i)) y(IEN(2,i)) y(IEN(3,i)) y(IEN(4,i)) y(IEN(1,i))];
        plot(XX,YY);hold on;

        if strcmpi(plot_nod,'yes')==1;   
            text(XX(1),YY(1),sprintf('%0.5g',IEN(1,i)));
            text(XX(2),YY(2),sprintf('%0.5g',IEN(2,i)));
            text(XX(3),YY(3),sprintf('%0.5g',IEN(3,i)));
            text(XX(4),YY(4),sprintf('%0.5g',IEN(4,i)));
        end
    end
end



fprintf(1,'  Mesh information \n');
fprintf(1,'No. of Elements  %d \n',nel);
fprintf(1,'No. of Nodes     %d \n',nnp);
fprintf(1,'No. of Equations %d \n\n',neq);





