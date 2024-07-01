function interpolations = geodesic_LEM(P, Q, num)
    % Geodesic interpolation using the Log-Euclidean Metric (LEM)
    logP = logm(P);
    logQ = logm(Q);
    interpolations = cell(1, num);
    for i = 1:num
        t = (i-1)/(num-1);
        logX = (1-t)*logP + t*logQ; % Linear interpolation in the log domain
        interpolations{i} = expm(logX); % Exponentiating to get back to the SPD domain
    end
end