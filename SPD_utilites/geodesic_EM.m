function interpolations = geodesic_EM(P, Q, num,pow)
    % Geodesic interpolation using the Euclidean Metric (EM)
    % Placeholder for a geodesic interpolation function
    % This should be replaced with actual computation.
    % The output is a cell array of SPD matrices.
    interpolations = cell(1, num);
    if nargin < 4
        pow = 1; % Default value for c
    end

    pow_P=spd_pow(P,pow);
    pow_Q=spd_pow(Q,pow);

    for i = 1:num
        t = (i-1)/(num-1);
        tmp=(1-t)*pow_P + t*pow_Q; % Simple linear interpolation (not a true geodesic)
        interpolations{i} = spd_pow(tmp,1/pow);
    end
end
