function interpolations = geodesic_LCM(P, Q, num)
    % Geodesic interpolation using the Affine-Invariant Metric (AIM)
    L = chol(P, 'lower');
    K = chol(Q, 'lower');
    L_strictly_lower = tril(L, -1);
    K_strictly_lower = tril(K, -1);
    log_D_L = log(diag(L));
    log_D_K = log(diag(K));

    interpolations = cell(1, num);
    for i = 1:num
        t = (i-1)/(num-1);
        
        G_strictly_lower = L_strictly_lower + t * (K_strictly_lower - L_strictly_lower);
        G_diag_vec = exp(log_D_L + t * (log_D_K - log_D_L));
        chol_new =  G_strictly_lower + diag(G_diag_vec);

        interpolations{i} = chol_new*chol_new';
    end
end


