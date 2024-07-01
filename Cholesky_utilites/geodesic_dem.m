function G_dem = geodesic_dem(L, X, t, theta)
    trilL = tril(L, -1);
    trilX = tril(X, -1);
    diagL = diag(L);
    diagX = diag(X);
    diagL_matrix = diag(diagL);
    diagX_matrix = diag(diagX);
    G_dem = trilL + t * trilX + diagL_matrix * diag((1 + t * theta * (diagX ./ diagL)).^(1/theta));
end