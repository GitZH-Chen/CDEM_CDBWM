function sqrtAB = sqrt_of_product_spd(A, B)
    % Validate that A and B are symmetric and positive definite
    if ~isequal(A, A') || ~isequal(B, B') || min(eig(A)) <= 0 || min(eig(B)) <= 0
        error('Both A and B must be symmetric positive definite matrices.');
    end
    
    % Compute the square root and inverse square root of A
    A_half = sqrtm(A);
    A_inv_half = inv(A_half);
    
    % Compute the square root of (A^(1/2) * B * A^(1/2))
    M = A_half * B * A_half;
    M_half = sqrtm(M);
    
    % Now compute the square root of the product AB
    sqrtAB = A_half * M_half * A_inv_half;
end
