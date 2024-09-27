clear
clc

function diffusion_calculator()
    while true
        fprintf('\nSemiconductor Diffusion Calculator\n');
        fprintf('1. Perform comprehensive diffusion calculations\n');
        fprintf('2. Calculate predeposition time\n');
        fprintf('3. Exit\n');
        choice = input('Enter your choice (1-3): ');

        switch choice
            case 1
                comprehensive_diffusion_calc();
            case 2
                calculate_predeposition_time();
            case 3
                break;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end

        fprintf('\nPress Enter to continue...\n');
        input('');
    end

    fprintf('Thank you for using the Semiconductor Diffusion Calculator!\n');
end

function D = calculate_D(D0, Qd, T)
    k = 8.62e-5; % Boltzmann constant in eV/K
    D = D0 * exp(-Qd / (k * (T + 273.15)));
end

function comprehensive_diffusion_calc()
    fprintf('Comprehensive Diffusion Calculations\n');
    
    % Input parameters
    Cs = input('Enter surface concentration (atoms/m^3): ');
    Cb = input('Enter background concentration (atoms/m^3): ');
    D0 = input('Enter D0 (m^2/s): ');
    Qd = input('Enter Qd (eV): ');
    T_pre = input('Enter predeposition temperature (°C): ');
    t_pre = input('Enter predeposition time (hours): ');
    T_drive = input('Enter drive-in temperature (°C): ');
    t_drive = input('Enter drive-in time (hours): ');
    C_target = input('Enter target concentration for position calculation (atoms/m^3): ');

    % Convert times to seconds
    t_pre = t_pre * 3600;
    t_drive = t_drive * 3600;

    % Calculate diffusion coefficients
    D_pre = calculate_D(D0, Qd, T_pre);
    D_drive = calculate_D(D0, Qd, T_drive);

    % Calculate Q0
    Q0 = 2 * Cs * sqrt(D_pre * t_pre / pi);

    % Calculate junction depth
    xj = sqrt(4 * D_drive * t_drive * log(Q0 / (Cb * sqrt(pi * D_drive * t_drive))));

    % Calculate position for target concentration
    x = sqrt(4 * D_drive * t_drive * log(Q0 / (C_target * sqrt(pi * D_drive * t_drive))));

    % Output results
    fprintf('\nResults:\n');
    fprintf('(a) Q0: %.4e atoms/m^2\n', Q0);
    fprintf('(b) Junction depth (xj): %.4e m\n', xj);
    fprintf('(c) Position for concentration %.4e atoms/m^3: %.4e m\n', C_target, x);
end


function calculate_predeposition_time()
    fprintf('Calculate predeposition time\n');
    Cs = input('Enter surface concentration (atoms/m^3): ');
    Cb = input('Enter background concentration (atoms/m^3): ');
    D0 = input('Enter D0 (m^2/s): ');
    Qd = input('Enter Qd (eV): ');
    T_pre = input('Enter predeposition temperature (°C): ');
    T_drive = input('Enter drive-in temperature (°C): ');
    t_drive = input('Enter drive-in time (hours): ');
    xj = input('Enter junction depth from drive-in (μm): ') * 1e-6; % Convert μm to m

    % Calculate drive-in diffusion coefficient
    D_drive = calculate_D(D0, Qd, T_drive);

    % Calculate Q0
    t_drive_seconds = t_drive * 3600;
    exp_term = exp((xj^2) / (4 * D_drive * t_drive_seconds));
    Q0 = (Cb * sqrt(pi * D_drive * t_drive_seconds)) * exp_term;

    % Calculate predeposition diffusion coefficient
    D_pre = calculate_D(D0, Qd, T_pre);

    % Calculate predeposition time
    t_pre = (pi * Q0^2) / (4 * Cs^2 * D_pre);

    % Output results
    fprintf('\nResults:\n');
    fprintf('Predeposition time: %.2f seconds (%.2f minutes)\n', t_pre, t_pre/60);
end

% Run the calculator
diffusion_calculator();