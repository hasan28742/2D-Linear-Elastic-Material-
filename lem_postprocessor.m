% plot displacement contour on undeformed plot
function lem_postprocessor(d)
lem_include_flags

% plot the displacement field
if strcmpi(plot_temp,'yes')==1;  
   d1 = d(ID);
   figure(2); 
   for e=1:nel
       XX = [x(IEN(1,e))  x(IEN(2,e))  x(IEN(3,e))  x(IEN(4,e))  x(IEN(1,e))];
       YY = [y(IEN(1,e))  y(IEN(2,e))  y(IEN(3,e))  y(IEN(4,e))  y(IEN(1,e))];
       dd = [d1(IEN(1,e)) d1(IEN(2,e)) d1(IEN(3,e)) d1(IEN(4,e)) d1(IEN(1,e))];
       patch(XX,YY,dd);hold on;  
   end
title('displacement contour'); xlabel('X'); ylabel('Y'); colorbar;
end
%{
%new editing starts from here
% Extract nodal displacements
ux = d(1:2:end);  % x-displacements happen after 1 interval 
uy = d(2:2:end);  % y-displacements, first y displacemnet is at location 2 and it happens after inter 2
 % Create figure for plotting
figure;
hold on;

    % Loop over each element
    for e = 1:nel
        % Original and new coordinates
        originalX = x(IEN(:,e));
        originalY = y(IEN(:,e));
        newX = originalX + ux(IEN(:,e));
        newY = originalY + uy(IEN(:,e));

        % Close the loop for plotting by repeating the first node at the end
        originalX(end+1) = originalX(1);
        originalY(end+1) = originalY(1);
        newX(end+1) = newX(1);
        newY(end+1) = newY(1);

        % Plot undeformed mesh
        plot(originalX, originalY, 'b-o', 'LineWidth', 1.5, 'DisplayName', 'Undeformed Mesh');

        % Plot deformed mesh
        plot(newX, newY, 'r-o', 'LineWidth', 1.5, 'DisplayName', 'Deformed Mesh');
    end

    % Add legend and labels
    legend show;
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    title('Undeformed and Deformed Mesh Comparison');
    grid on;
    hold off;
end
%}