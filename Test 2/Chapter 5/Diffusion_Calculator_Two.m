clear
clc

function diffusion_calculator()
    while true
        fprintf('\nDiffusion Calculator\n');
        fprintf('1. Calculate position for given concentration (constant surface concentration)\n');
        fprintf('2. Calculate concentration at given position and time\n');
        fprintf('3. Calculate time for given concentration and position\n');
        fprintf('4. Exit\n');
        choice = input('Enter your choice (1-4): ');

        switch choice
            case 1
                calculate_position();
            case 2
                calculate_concentration();
            case 3
                calculate_time();
            case 4
                break;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end

        fprintf('\nPress Enter to continue...\n');
        input('');
    end

    fprintf('Thank you for using the Diffusion Calculator 2!\n');
end

function calculate_position()
    fprintf('Calculate position for given concentration (constant surface concentration)\n');
    C0 = input('Enter initial concentration (wt%): ');
    Cs = input('Enter surface concentration (wt%): ');
    Cx = input('Enter concentration at position x (wt%): ');
    D = input('Enter diffusion coefficient (m^2/s): ');
    t = input('Enter time (h): ');

    erf_value = 1 - (Cx - C0) / (Cs - C0);
    
    % Define erf table
    z_table = [0.00, 0.025, 0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85, 0.90, 0.95, 1.00, 1.10, 1.20, 1.30, 1.40, 1.50, 1.60, 1.70, 1.80, 1.90, 2.00, 2.20, 2.40, 2.60, 2.80];
    erf_table = [0.0000, 0.0282, 0.0564, 0.1125, 0.1680, 0.2227, 0.2763, 0.3286, 0.3794, 0.4284, 0.4755, 0.5205, 0.5633, 0.6039, 0.6420, 0.6778, 0.7112, 0.7421, 0.7707, 0.7970, 0.8209, 0.8427, 0.8802, 0.9103, 0.9340, 0.9523, 0.9661, 0.9763, 0.9838, 0.9891, 0.9928, 0.9953, 0.9981, 0.9993, 0.9998, 0.9999];

    % Find the two closest values in the table
    [~, idx] = min(abs(erf_table - erf_value));
    if idx == 1
        idx_low = 1;
        idx_high = 2;
    elseif idx == length(erf_table)
        idx_low = length(erf_table) - 1;
        idx_high = length(erf_table);
    else
        if erf_table(idx) > erf_value
            idx_low = idx - 1;
            idx_high = idx;
        else
            idx_low = idx;
            idx_high = idx + 1;
        end
    end

    % Perform linear interpolation
    z_low = z_table(idx_low);
    z_high = z_table(idx_high);
    erf_low = erf_table(idx_low);
    erf_high = erf_table(idx_high);
    
    z = z_low + (erf_value - erf_low) * (z_high - z_low) / (erf_high - erf_low);

    x = 2 * z * sqrt(D * t * 3600);

    fprintf('Position: %.4f mm\n', x * 1000);
end

function calculate_concentration()
    fprintf('Calculate concentration at given position and time\n');
    Cs = input('Enter surface concentration (wt%): ');
    x = input('Enter position (mm): ');
    t = input('Enter time (h): ');
    D = input('Enter diffusion coefficient (m^2/s): ');

    z = x / (1000 * 2 * sqrt(D * t * 3600));
    Cx = Cs * (1 - erf(z));

    fprintf('Concentration: %.4f wt%%\n', Cx);
end

function calculate_time()
    fprintf('Calculate time for given concentration and position\n');
    x1 = input('Enter reference position (mm): ');
    t1 = input('Enter reference time (h): ');
    x2 = input('Enter new position (mm): ');

    t2 = t1 * (x2 / x1)^2;

    fprintf('Time: %.2f h\n', t2);
end

% Run the calculator
diffusion_calculator();