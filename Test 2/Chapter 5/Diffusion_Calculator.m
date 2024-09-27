clear
clc

function diffusion_calculator()
    while true
        fprintf('\nDiffusion Calculator\n');
        fprintf('1. Calculate mass flow rate (given: D, concentrations, dimensions)\n');
        fprintf('2. Calculate concentration at a point (given: D, flux, dimensions, boundary concentrations)\n');
        fprintf('3. Calculate diffusion coefficient (given: flux, concentrations, dimensions)\n');
        fprintf('4. Calculate distance for given concentration (given: D, flux, thickness, boundary and target concentrations)\n');
        fprintf('5. Exit\n');
        choice = input('Enter your choice (1-5): ');

        switch choice
            case 1
                calculate_mass_flow_rate();
            case 2
                calculate_concentration_at_point();
            case 3
                calculate_diffusion_coefficient();
            case 4
                calculate_distance_for_concentration();
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

function calculate_mass_flow_rate()
    fprintf('Calculate mass flow rate (given: D, concentrations, dimensions)\n');
    D = input('Enter diffusion coefficient (m^2/s): ');
    c_high = input('Enter concentration at high-pressure side (kg/m^3): ');
    c_low = input('Enter concentration at low-pressure side (kg/m^3): ');
    thickness = input('Enter thickness of the sheet (mm): ');
    area = input('Enter area of the sheet (m^2): ');

    flux = D * (c_high - c_low) / (thickness / 1000); % kg/(m^2*s)
    mass_flow = flux * area * 3600; % kg/h

    fprintf('Mass flow rate: %.4f kg/h\n', mass_flow);
end

function calculate_concentration_at_point()
    fprintf('Calculate concentration at a point (given: D, flux, dimensions, boundary concentrations)\n');
    D = input('Enter diffusion coefficient (m^2/s): ');
    flux = input('Enter diffusion flux (kg/(m^2*s)): ');
    thickness = input('Enter thickness of the sheet (mm): ');
    c_high = input('Enter concentration at high-pressure surface (kg/m^3): ');
    x = input('Enter distance from high-pressure side (mm): ');

    thickness_m = thickness / 1000;
    x_m = x / 1000;
    c_low = c_high - (flux * thickness_m / D);
    c_x = c_high - (x_m / thickness_m) * (c_high - c_low);

    fprintf('Concentration at %.3f mm: %.4f kg/m^3\n', x, c_x);
end

function calculate_diffusion_coefficient()
    fprintf('Calculate diffusion coefficient (given: flux, concentrations, dimensions)\n');
    flux = input('Enter diffusion flux (kg/(m^2*s)): ');
    thickness = input('Enter thickness of the sheet (mm): ');
    concentration_unit = input('Enter concentration unit (1 for kg/m^3, 2 for wt%): ');
    
    if concentration_unit == 1
        c_high = input('Enter concentration at high-pressure side (kg/m^3): ');
        c_low = input('Enter concentration at low-pressure side (kg/m^3): ');
    else
        c_high_wt = input('Enter concentration at high-pressure side (wt%): ');
        c_low_wt = input('Enter concentration at low-pressure side (wt%): ');
        rho_solvent = input('Enter density of solvent (g/cm^3): ');
        rho_solute = input('Enter density of solute (g/cm^3): ');
        c_high = wt_to_kgm3(c_high_wt, rho_solute, rho_solvent);
        c_low = wt_to_kgm3(c_low_wt, rho_solute, rho_solvent);
    end

    D = (flux * thickness * 1e-5) / (c_high - c_low);  % Changed 1e-3 to 1e-6

    fprintf('Diffusion coefficient: %.4e m^2/s\n', D);
end

function calculate_distance_for_concentration()
    fprintf('Calculate distance for given concentration (given: D, flux, thickness, boundary and target concentrations)\n');
    D = input('Enter diffusion coefficient (m^2/s): ');
    flux = input('Enter diffusion flux (kg/(m^2*s)): ');
    thickness = input('Enter thickness of the sheet (mm): ');
    c_high = input('Enter concentration at high-pressure surface (kg/m^3): ');
    c_target = input('Enter target concentration (kg/m^3): ');

    thickness_m = thickness / 1000;
    c_low = c_high - (flux * thickness_m / D);
    x_m = thickness_m * (c_high - c_target) / (c_high - c_low);
    x_mm = x_m * 1000;

    fprintf('Distance from high-pressure side: %.3f mm\n', x_mm);
end

function c_kgm3 = wt_to_kgm3(c_wt, rho_solute, rho_solvent)
    c_kgm3 = (c_wt * rho_solvent) / (c_wt + (100 - c_wt) * (rho_solvent / rho_solute)) * 10;
end

% Run the calculator
diffusion_calculator();