function all_spd = plotGeodesicInterpolations(P, Q,numInterpolations)
    % Define figure
    figure;
    FontSize=14;
    % Number of interpolations including the endpoints
    
    % Placeholder for 4 different geodesic interpolation functions
    % geodesicFunctions = {@geodesic_EM, @geodesic_LEM, @geodesic_AIM,@geodesic_LCM,@geodesic_CEM};
    EM_functioons={};
    powers = [1,0.5,0.1];
    for power = powers
        funcName = sprintf('geodesic_%.1f-EM', power); % Construct function name with power
        EM_functioons{end+1} = {@(P, Q, num) geodesic_EM(P, Q, num, power), funcName};
    end


    geodesicFunctions = {
    {@geodesic_LEM, 'geodesic_LEM'}, 
    {@geodesic_AIM, 'geodesic_AIM'},
    {@geodesic_BWM, 'geodesic_BWM'},
    {@geodesic_LCM, 'geodesic_LCM'}
    };
    geodesicFunctions=[EM_functioons';geodesicFunctions];
    
    % Add geodesic_CEM functions with powers from 0 to 2 (step 0.2)
    % powers = [0.1,0.25,0.5,0.75,1,1.25,1.5];
    powers = [0.1,0.5,1];
    for power = powers
        funcName = sprintf('geodesic_%.1f-CEM', power); % Construct function name with power
        geodesicFunctions{end+1} = {@(P, Q, num) geodesic_CEM(P, Q, num, power), funcName};
    end

    all_spd={};
    for gIndex = 1:length(geodesicFunctions)
        funcHandle = geodesicFunctions{gIndex}{1}; % Actual function handle
        funcName = geodesicFunctions{gIndex}{2}; % Name or description with power
        % Initialize array to hold determinants
        dets = zeros(1, numInterpolations);
        metricName = extractAfter(funcName, 'geodesic_');

        
        % Compute interpolations for the current geodesic
        interpolations = funcHandle(P, Q, numInterpolations);
        all_spd{gIndex}=interpolations;

        if i == 1
            % For the top row, adjust title to include 'Metric - Ellipsoid #'
            title(metricName, 'Interpreter', 'none');
        end

        % Plot the interpolations as ellipsoids in a row and calculate determinants
        for j = 1:numInterpolations
            subplot(length(geodesicFunctions), numInterpolations, (gIndex-1)*numInterpolations + j);
            % if gIndex==3 || gIndex==5
            %     if j==10
            %         a=1
            %     end
            % end
            plotSPDEllipsoid(interpolations{j});
            % title(sprintf('G%d - E%d', gIndex, j));
            
            % Calculate the determinant and store it
            dets(j) = det(interpolations{j});
            if j == 1
                % For the first subplot in each row, include the metric name
                zl = zlabel(metricName, 'Interpreter', 'none');
                set(zl, 'FontSize', FontSize); % Set the font size of z-label
                
                % Set the axes color to none to hide them while keeping the label
                % set(gca, 'YColor', 'none', 'XColor', 'none', 'ZColor', 'none');
            else
                % For other subplots, turn off the y-axis label
                set(gca, 'ZColor', 'none');
            end
        end
   
        % Print the determinants for the current geodesic in the command line
        fprintf('dets under %s: ', funcName);
        fprintf('%.2f, ', dets(1:end-1));
        fprintf('%.2f\n', dets(end)); % For the last element, add a newline
    end
end


