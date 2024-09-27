clear
clc

function diffusion_calculator()
    while true
        fprintf('\nDiffusion Calculator\n');
        fprintf('1. Calculate diffusion coefficient (given D0, Qd, T)\n');
        fprintf('2. Calculate temperature (given D, D0, Qd)\n');
        fprintf('3. Calculate D0 and Qd (given D at two temperatures)\n');
        fprintf('4. Calculate time for equivalent diffusion at different temperatures\n');
        fprintf('5. Exit\n');
        choice = input('Enter your choice (1-5): ');

        switch choice
            case 1
                calculate_diffusion_coefficient();
            case 2
                calculate_temperature();
            case 3
                calculate_D0_and_Qd();
            case 4
                calculate_equivalent_time();
            case 5
                break;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end

        fprintf('\nPress Enter to continue...\n');
        input('');
    end

    fprintf('Thank you for using the Diffusion Calculator!\n');
end

function calculate_diffusion_coefficient()
    fprintf('Calculate diffusion coefficient (given D0, Qd, T)\n');
    D0 = input('Enter D0 (m^2/s): ');
    Qd = input('Enter Qd (kJ/mol): ');
    T = input('Enter temperature (°C): ');
    
    T_K = T + 273.15;
    R = 8.31; % J/(mol·K)
    Qd = Qd * 1000; % Convert kJ/mol to J/mol
    
    D = D0 * exp(-Qd / (R * T_K));
    
    fprintf('Diffusion coefficient: %.4e m^2/s\n', D);
end

function calculate_temperature()
    fprintf('Calculate temperature (given D, D0, Qd)\n');
    D = input('Enter D (m^2/s): ');
    D0 = input('Enter D0 (m^2/s): ');
    Qd = input('Enter Qd (kJ/mol): ');
    
    R = 8.31; % J/(mol·K)
    Qd = Qd * 1000; % Convert kJ/mol to J/mol
    
    T_K = -Qd / (R * log(D / D0));
    T_C = T_K - 273.15;
    
    fprintf('Temperature: %.2f K (%.2f °C)\n', T_K, T_C);
end

function calculate_D0_and_Qd()
    fprintf('Calculate D0 and Qd (given D at two temperatures)\n');
    T1 = input('Enter first temperature (°C): ');
    D1 = input('Enter D at first temperature (m^2/s): ');
    T2 = input('Enter second temperature (°C): ');
    D2 = input('Enter D at second temperature (m^2/s): ');
    
    T1_K = T1 + 273.15;
    T2_K = T2 + 273.15;
    R = 8.31; % J/(mol·K)
    
    Qd = R * (log(D2/D1) / (1/T1_K - 1/T2_K));
    D0 = D1 / exp(-Qd / (R * T1_K));
    
    fprintf('Activation energy (Qd): %.2f J/mol\n', Qd);
    fprintf('Preexponential (D0): %.4e m^2/s\n', D0);
    
    % Calculate D at a third temperature
    T3 = input('Enter the temperature to calculate D (°C): ');
    T3_K = T3 + 273.15;
    D3 = D0 * exp(-Qd / (R * T3_K));
    
    fprintf('Diffusion coefficient at %.2f °C: %.4e m^2/s\n', T3, D3);
end

function calculate_equivalent_time()
    fprintf('Calculate time for equivalent diffusion at different temperatures\n');
    T1 = input('Enter first temperature (°C): ');
    t1 = input('Enter time at first temperature (h): ');
    T2 = input('Enter second temperature (°C): ');
    Qd = input('Enter Qd (kJ/mol): ');
    
    T1_K = T1 + 273.15;
    T2_K = T2 + 273.15;
    R = 8.31; % J/(mol·K)
    Qd = Qd * 1000; % Convert kJ/mol to J/mol
    
    t2 = t1 * exp(Qd/R * (1/T2_K - 1/T1_K));
    
    fprintf('Equivalent time at %.2f °C: %.4f h\n', T2, t2);
end

% Run the calculator
diffusion_calculator();