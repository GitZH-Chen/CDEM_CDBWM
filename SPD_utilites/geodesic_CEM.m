function interpolations = geodesic_CEM(P, Q, num,pow)
    % Geodesic interpolation using the Affine-Invariant Metric (AIM)
    if nargin < 4
        pow = 1; % Default value for c
    end
    L = chol(P, 'lower');
    K = chol(Q, 'lower');
    L_strictly_lower = tril(L, -1);
    K_strictly_lower = tril(K, -1);
    pow_D_L = power(diag(L),pow);
    pow_D_K = power(diag(K),pow);

    interpolations = cell(1, num);
    for i = 1:num
        t = (i-1)/(num-1);
        
        G_strictly_lower = L_strictly_lower + t * (K_strictly_lower - L_strictly_lower);
        G_diag_vec = power(pow_D_L + t * (pow_D_K - pow_D_L),1/pow);
        chol_new =  G_strictly_lower + diag(G_diag_vec);

        interpolations{i} = chol_new*chol_new';
    end
end


