function plotSPDEllipsoid(A)
    % Eigen decomposition to get the axes and lengths of the ellipsoid
    [V, D] = eig(A);

    % Ensure eigenvalues are sorted in descending order
    [eigenvalues, order] = sort(diag(D), 'descend');
    V = V(:, order); % Rearrange the eigenvectors according to sorted eigenvalues
    
    % Using sorted eigenvalues for semi-axis lengths
    semi_axes = sqrt(eigenvalues);
    
    % Plotting the ellipsoid
    [x, y, z] = ellipsoid(0, 0, 0, semi_axes(1), semi_axes(2), semi_axes(3), 50);
    g = surf(x, y, z);
    set(g, 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    
    % Adjusting the ellipsoid orientation
    rotate(g, [0, 0, 1], rad2deg(atan2(V(2,1), V(1,1))), [0, 0, 0]);
    direction = cross([V(1,1), V(2,1), V(3,1)], [0, 0, 1]);
    angle = acos(dot([V(1,1), V(2,1), V(3,1)], [0, 0, 1]));
    rotate(g, direction, rad2deg(angle), [0, 0, 0]);
    
    % Standardizing axis limits
    axisLimits = [-max(semi_axes) max(semi_axes)];
    xlim(axisLimits);
    ylim(axisLimits);
    zlim(axisLimits);
    
    % Setting the same ticks for fair comparison
    % ticks = linspace(-max(semi_axes), max(semi_axes), 5); % Example: 5 ticks
    % set(gca, 'XTick', ticks, 'YTick', ticks, 'ZTick', ticks);
    
    axis equal;
    % Optionally turn off the axis lines
    % axis off;
    set(gca, 'XTick', [], 'YTick', [], 'ZTick', [], ...
        'XColor', 'none', 'YColor', 'none');

    % set(gca, 'XTick', [], 'YTick', [], 'ZTick', [], ...
    %     'XColor', 'none', 'YColor', 'none', 'ZColor', 'none', 'Box', 'off');
    set(gca, 'Color', 'none');
    
    % Adding labels for clarity
    % xlabel('X-axis');
    % ylabel('Y-axis');
    % zlabel('Z-axis');
    
    camlight;
    lighting phong;
end
