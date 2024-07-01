function G_cm = geodesic_cm(L, X, t)
    trilL = tril(L, -1);
    trilX = tril(X, -1);
    diagL = diag(L);
    diagX = diag(X);
    diagL_matrix = diag(diagL);
    diagX_matrix = diag(diagX);
    G_cm = trilL + t * trilX + diagL_matrix .* diag(exp(t * (diagX ./ diagL)));
    if any(isinf(G_cm(:))) || any(isnan(G_cm(:)))
        a=-1;
    end
end