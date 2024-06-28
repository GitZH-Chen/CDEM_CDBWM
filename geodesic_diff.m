% Clear workspace and command window
clear;
clc;

% Parameters
n = 3; % Matrix size
small_values = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5,1e-10,1e-15]; % Different small positive values for the smallest diagonal element
t = 0.5; % Example value for t
theta = 0.5; % Example value for theta
num_samples = 100000; % Number of samples to test

% Initialize results table
failures_cm = zeros(1, length(small_values));
failures_dem = zeros(1, length(small_values));
failures_dgbwm = zeros(1, length(small_values));

% Seed for reproducibility
rng(0);

% Repeat the process for each small_value
for sv_idx = 1:length(small_values)
    small_value = small_values(sv_idx);
    
    % Initialize failure counters for current small_value
    failures_cm(sv_idx) = 0;
    failures_dem(sv_idx) = 0;
    failures_dgbwm(sv_idx) = 0;
    
    % Repeat the process over the specified number of samples
    for i = 1:num_samples
        % Generate the Cholesky matrix with drastically different eigenvalues
        L = generate_cholesky(n, small_value);

        % Generate random Cholesky matrix
        X = random_cholesky(n, 1);

        % Calculate geodesics
        G_cm = geodesic_cm(L, X, t);
        G_dem = geodesic_dem(L, X, t, theta);
        G_dgbwm = geodesic_dem(L, X, t, theta * 0.5);

        % Check for failures (inf or nan in the resulting matrices)
        if any(isinf(G_cm(:))) || any(isnan(G_cm(:)))
            failures_cm(sv_idx) = failures_cm(sv_idx) + 1;
        end

        if any(isinf(G_dem(:))) || any(isnan(G_dem(:)))
            failures_dem(sv_idx) = failures_dem(sv_idx) + 1;
        end

        if any(isinf(G_dgbwm(:))) || any(isnan(G_dgbwm(:)))
            failures_dgbwm(sv_idx) = failures_dgbwm(sv_idx) + 1;
        end
        
        % Print progress for the current small_value
        % if mod(i, 100000) == 0
        %     fprintf('Small value %e: %d samples completed.\n', small_value, i);
        % end
    end
    
    % Convert counts to percentages
    percent_failures_cm = (failures_cm / num_samples) * 100;
    percent_failures_dem = (failures_dem / num_samples) * 100;
    percent_failures_dgbwm = (failures_dgbwm / num_samples) * 100;

    % Create table of results
    results_table = table(small_values', percent_failures_cm', percent_failures_dem', percent_failures_dgbwm', ...
        'VariableNames', {'SmallValue', 'PercentFailures_CM', 'PercentFailures_DEM', 'PercentFailures_DGBWM'});

    % Display the results
    disp(['Percentage of failures after testing small_value = ', num2str(small_value), ':']);
    disp(results_table);
end

% Function to generate a random lower triangular matrix with small positive diagonal values
function Cholesky = random_cholesky(n, eps)
    tril_part = tril(randn(n), -1) * eps;
    diag_part = diag(abs(randn(n, 1)) * eps);
    Cholesky = tril_part + diag_part;
end

% Function to generate a Cholesky matrix with eigenvalues differing by a large factor
function Cholesky = generate_cholesky(n, small_value)
    diag_values = [small_value * rand(), rand(1, n-1)];
    tril_part = tril(randn(n), -1);
    diag_part = diag(diag_values);
    Cholesky = tril_part + diag_part;
end

