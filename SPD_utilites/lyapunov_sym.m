function X_new = lyapunov_sym(S, X)
    % S spd matrix
    % X is the right-hand side matrix of the Lyapunov equation
    % P is the matrix of eigenvectors of S
    % The function returns X_new, the solution to the Lyapunov equation
    % D is the diagonal matrix of eigenvalues of S
    
    [P,D,] = svd(S);
    n = size(P, 1); % Assuming S is n by n
    di = diag(D); % Extract the diagonal elements (eigenvalues)
    
    X = P' * X * P; % Change basis to the eigenbasis of S
    Lorenzo = zeros(n,n);
    for i = 1:n
        for j = 1:n
            Lorenzo(i, j) = X(i, j) / (di(i) + di(j));
        end
    end
    X_new = P * Lorenzo * P'; % Change basis back to the original
end