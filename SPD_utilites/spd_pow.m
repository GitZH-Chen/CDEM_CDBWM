function [Ap] = spd_pow(A,p)

% Compute the Singular Value Decomposition
[U, S, V] = svd(A);

% % Ensure U = V for a symmetric matrix, which should be the case for SPD matrices
% assert(isequal(U, V), 'U and V should be equal for SPD matrices.');

% Compute S^p, which is just raising each singular value to the power p
Sp = diag(diag(S).^p);

% Compute A^p using SVD components
Ap = U * Sp * U'; % U * Sp * V' is also valid since U = V

% Ap now contains A raised to the power p

end