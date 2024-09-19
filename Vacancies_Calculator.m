clear
clc

function vacancies_per_m3 = calculate_vacancies_from_energy(temperature_K, formation_energy_eV, density, molar_mass)
    % Input:
    % temperature_K: Temperature in Kelvin
    % formation_energy_eV: Vacancy formation energy in eV/atom
    % density: Density in g/cm^3
    % molar_mass: Molar mass in g/mol
    %
    % Output:
    % vacancies_per_m3: Number of vacancies per cubic meter

    % Boltzmann constant in eV/K
    k_B = 8.617333262145e-5;

    % Avogadro's number
    N_A = 6.022e23;

    % Calculate fraction of vacant sites
    fraction = exp(-formation_energy_eV / (k_B * temperature_K));

    % Convert density from g/cm^3 to kg/m^3
    density_SI = density * 1000;

    % Calculate number of atoms per cubic meter
    atoms_per_m3 = (density_SI / (molar_mass / 1000)) * N_A;

    % Calculate number of vacancies per cubic meter
    vacancies_per_m3 = fraction * atoms_per_m3;

    % Display the result
    fprintf('Number of vacancies per cubic meter at %.2f K: %.4e\n', temperature_K, vacancies_per_m3);
end

function formation_energy_eV = calculate_formation_energy(temperature_K, vacancies_per_m3, density, molar_mass)
    % Input:
    % temperature_K: Temperature in Kelvin
    % vacancies_per_m3: Number of vacancies per cubic meter
    % density: Density in g/cm^3
    % molar_mass: Molar mass in g/mol
    %
    % Output:
    % formation_energy_eV: Vacancy formation energy in eV/atom

    % Boltzmann constant in eV/K
    k_B = 8.617333262145e-5;

    % Avogadro's number
    N_A = 6.022e23;

    % Convert density from g/cm^3 to kg/m^3
    density_SI = density * 1000;

    % Calculate number of atoms per cubic meter
    atoms_per_m3 = (density_SI / (molar_mass / 1000)) * N_A;

    % Calculate fraction of vacant sites
    fraction = vacancies_per_m3 / atoms_per_m3;

    % Calculate formation energy
    formation_energy_eV = -k_B * temperature_K * log(fraction);

    % Display the result
    fprintf('Vacancy formation energy: %.4f eV/atom\n', formation_energy_eV);
end

function fraction = calculate_vacancy_fraction_temperature(temperature_K, formation_energy_eV)
    % Input:
    % temperature_K: Temperature in Kelvin
    % formation_energy_eV: Vacancy formation energy in eV/atom
    %
    % Output:
    % fraction: Fraction of vacant sites

    % Boltzmann constant in eV/K
    k_B = 8.617333262145e-5;

    % Calculate fraction of vacant sites
    fraction = exp(-formation_energy_eV / (k_B * temperature_K));

    % Display the result
    fprintf('Fraction of vacant sites at %.2f K: %.4e\n', temperature_K, fraction);
end

function vacancies = calculate_vacancies(temperature_K, eq_fraction, density, molar_mass)
    % Input:
    % temperature_K: Temperature in Kelvin (not used in calculation, but included for completeness)
    % eq_fraction: Equilibrium fraction of vacant sites
    % density: Density in g/cm^3
    % molar_mass: Molar mass in g/mol
    %
    % Output:
    % vacancies: Number of vacancies per cubic meter

    % Avogadro's number
    N_A = 6.022e23;

    % Convert density from g/cm^3 to kg/m^3
    density_SI = density * 1000;

    % Calculate number of moles per cubic meter
    moles_per_m3 = density_SI / (molar_mass / 1000);

    % Calculate number of atoms per cubic meter
    atoms_per_m3 = moles_per_m3 * N_A;

    % Calculate number of vacancies per cubic meter
    vacancies = atoms_per_m3 * eq_fraction;

    % Display the result
    fprintf('Number of vacancies per cubic meter: %.4e\n', vacancies);
end

function fraction = calculate_vacancy_fraction(temperature_K, vacancies, density, molar_mass)
    % Input:
    % temperature_K: Temperature in Kelvin (not used in calculation, but included for completeness)
    % vacancies: Number of vacancies per cubic meter
    % density: Density in g/cm^3
    % molar_mass: Molar mass in g/mol
    %
    % Output:
    % fraction: Fraction of vacancies

    % Avogadro's number
    N_A = 6.022e23;

    % Convert density from g/cm^3 to kg/m^3
    density_SI = density * 1000;

    % Calculate number of moles per cubic meter
    moles_per_m3 = density_SI / (molar_mass / 1000);

    % Calculate number of atoms per cubic meter
    atoms_per_m3 = moles_per_m3 * N_A;

    % Calculate fraction of vacancies
    fraction = vacancies / atoms_per_m3;

    % Display the result
    fprintf('Fraction of vacancies: %.4e\n', fraction);
end

% Main script
while true
    fprintf('\nVacancies Calculator\n');
    fprintf('1. Calculate number of vacancies\n');
    fprintf('2. Calculate fraction of vacancies\n');
    fprintf('3. Calculate fraction of vacancies using temperature and formation energy\n');
    fprintf('4. Calculate number of vacancies from formation energy\n');
    fprintf('5. Calculate formation energy from number of vacancies\n');
    fprintf('6. Exit\n');
    choice = input('Enter your choice (1-6): ');

    if choice == 1
        temperature_K = input('Enter temperature in Kelvin: ');
        eq_fraction = input('Enter equilibrium fraction of vacant sites: ');
        density = input('Enter density in g/cm^3: ');
        molar_mass = input('Enter molar mass in g/mol: ');
        calculate_vacancies(temperature_K, eq_fraction, density, molar_mass);
    elseif choice == 2
        temperature_K = input('Enter temperature in Kelvin: ');
        vacancies = input('Enter number of vacancies per cubic meter: ');
        density = input('Enter density in g/cm^3: ');
        molar_mass = input('Enter molar mass in g/mol: ');
        calculate_vacancy_fraction(temperature_K, vacancies, density, molar_mass);
    elseif choice == 3
        temperature_K1 = input('Enter first temperature in Kelvin: ');
        temperature_K2 = input('Enter second temperature in Kelvin (enter 0 if not applicable): ');
        formation_energy_eV = input('Enter vacancy formation energy in eV/atom: ');
        
        fraction1 = calculate_vacancy_fraction_temperature(temperature_K1, formation_energy_eV);
        
        if temperature_K2 > 0
            fraction2 = calculate_vacancy_fraction_temperature(temperature_K2, formation_energy_eV);
            ratio = fraction1 / fraction2;
            fprintf('Ratio of fractions (%.2f K / %.2f K): %.4e\n', temperature_K1, temperature_K2, ratio);
        end
    elseif choice == 4
        temperature_K = input('Enter temperature in Kelvin: ');
        formation_energy_eV = input('Enter vacancy formation energy in eV/atom: ');
        density = input('Enter density in g/cm^3: ');
        molar_mass = input('Enter molar mass in g/mol: ');
        calculate_vacancies_from_energy(temperature_K, formation_energy_eV, density, molar_mass);
    elseif choice == 5
        temperature_K = input('Enter temperature in Kelvin: ');
        vacancies_per_m3 = input('Enter number of vacancies per cubic meter: ');
        density = input('Enter density in g/cm^3: ');
        molar_mass = input('Enter molar mass in g/mol: ');
        calculate_formation_energy(temperature_K, vacancies_per_m3, density, molar_mass);
    elseif choice == 6
        break;
    else
        fprintf('Invalid choice. Please try again.\n');
    end
    
    fprintf('\nPress Enter to continue...\n');
    input('');
end

fprintf('Thank you for using the Vacancies Calculator!\n');