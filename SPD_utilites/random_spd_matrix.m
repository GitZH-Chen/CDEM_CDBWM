function A = random_spd_matrix(n)
    % Generate a random nxn matrix
    R = randn(n, n);
    sym=R*R';
    
    % Make it symmetric
    S = (sym + sym') / 2;
    
    % Make the eigenvalues positive
    A = S + 1e-3 * eye(n);
end
