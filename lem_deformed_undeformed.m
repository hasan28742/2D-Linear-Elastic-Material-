function lem_deformed_undeformed(d, x, y, IEN, nel, e,nen, ID, scale_factor)
    % Create a new figure for plotting
    figure;
    hold on;
    title('Comparison of Undeformed and Deformed Meshes');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    axis equal;  % Ensure aspect ratio that reflects true proportions

    % Loop over each element to plot
    for e = 1:nel
        % Initialize vectors to store the original and deformed coordinates
        originalX = zeros(nen + 1, 1);  % +1 to close the loop on plots
        originalY = zeros(nen + 1, 1);
        newX = zeros(nen + 1, 1);
        newY = zeros(nen + 1, 1);

        % Extract node numbers and coordinates for the current element
        for i = 1:nen
            nodeIndex = IEN(i, e);  % Global node index
            originalX(i) = x(nodeIndex);
            originalY(i) = y(nodeIndex);
            globalDOF_X = ID(2*nodeIndex-1);  % Global index for x displacement
            globalDOF_Y = ID(2*nodeIndex);    % Global index for y displacement

            % Add scaled displacements to original coordinates
            newX(i) = originalX(i) + scale_factor * d(globalDOF_X);
            newY(i) = originalY(i) + scale_factor * d(globalDOF_Y);
        end

        % Close the loop for plotting
        originalX(end) = originalX(1);
        originalY(end) = originalY(1);
        newX(end) = newX(1);
        newY(end) = newY(1);

        % Plot undeformed and deformed configurations
        plot(originalX, originalY, 'k-o', 'LineWidth', 1, 'MarkerFaceColor', 'k', 'DisplayName', 'Undeformed Mesh');
        plot(newX, newY, 'r-o', 'LineWidth', 1, 'MarkerFaceColor', 'r', 'DisplayName', 'Deformed Mesh');
    end

    legend('Undeformed Mesh', 'Deformed Mesh', 'Location', 'best');
    grid on;
    hold off;
end