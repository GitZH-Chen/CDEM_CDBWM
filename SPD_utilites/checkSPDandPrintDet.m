function checkSPDandPrintDet(A)
    % Check if A is symmetric
    if ~isequal(A, A')
        error('Matrix is not symmetric.');
    end

    % Compute the eigenvalues of A
    eigenvalues = eig(A);

    % Check if all eigenvalues are positive
    if any(eigenvalues <= 0)
        error('Matrix is not positive definite.');
    end

    % If the script reaches here, A is SPD
    % Compute and print the determinant
    detA = det(A);
    fprintf('The matrix is SPD. Its determinant is %f.\n', detA);
end
