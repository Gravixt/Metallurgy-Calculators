clear
clc

function [at_percents, wt_percents, density, atomic_weight] = calculate_composition(wt_percents, densities, atomic_weights)
    % Calculate moles of each component
    moles = wt_percents ./ atomic_weights;
    
    % Calculate total moles
    total_moles = sum(moles);
    
    % Calculate atom percents
    at_percents = (moles / total_moles) * 100;
    
    % Calculate density
    volumes = wt_percents ./ densities;
    total_volume = sum(volumes);
    density = 100 / total_volume;
    
    % Calculate atomic weight
    atomic_weight = sum(at_percents .* atomic_weights) / 100;
end

function wt_percents = at_to_wt_percent(at_percents, atomic_weights)
    relative_weights = at_percents .* atomic_weights;
    total_weight = sum(relative_weights);
    wt_percents = (relative_weights / total_weight) * 100;
end

function concentration_kg_m3 = calculate_concentration_kg_m3(wt_percent, alloy_density)
    concentration_kg_m3 = wt_percent * alloy_density * 10; % Convert g/cm^3 to kg/m^3
end

function wt_percents = calculate_wt_percent_from_atoms(target_atoms_cm3, densities, atomic_weights)
    % Input:
    % target_atoms_cm3: Number of atoms per cubic centimeter for the target element
    % densities: Array of densities for all elements in g/cm^3
    % atomic_weights: Array of atomic weights for all elements in g/mol
    %
    % Output:
    % wt_percents: Array of weight percents for all elements

    n = length(densities);
    
    % Calculate atoms per cm^3 for all elements
    atoms_cm3 = zeros(1, n);
    atoms_cm3(1) = target_atoms_cm3;
    
    % Calculate the total volume
    total_volume = target_atoms_cm3 / (densities(1) * 6.022e23 / atomic_weights(1));
    
    % Calculate atoms for other elements
    for i = 2:n
        atoms_cm3(i) = (total_volume * densities(i) * 6.022e23 / atomic_weights(i));
    end
    
    % Calculate weights
    weights = atoms_cm3 .* atomic_weights / 6.022e23;
    
    % Calculate weight percents
    wt_percents = (weights ./ sum(weights)) * 100;
end

function wt_percents = mass_to_wt_percent(masses)
    total_mass = sum(masses);
    wt_percents = (masses / total_mass) * 100;
end

function wt_percent = calculate_substitutional_solid_solution(target_atoms_cm3, densities, atomic_weights)
    % Input:
    % target_atoms_cm3: Number of atoms per cubic centimeter for the target element
    % densities: Array of densities [density_target, density_base] in g/cm^3
    % atomic_weights: Array of atomic weights [atomic_weight_target, atomic_weight_base] in g/mol
    %
    % Output:
    % wt_percent: Weight percent of the target element

    % Avogadro's number
    N_A = 6.022e23;

    % Calculate weight percent
    wt_percent = 100 / (1 + (N_A * densities(2) / (target_atoms_cm3 * atomic_weights(1))) - (densities(2) / densities(1)));
end

% Main script
while true
    fprintf('\nComposition Calculator\n');
    fprintf('1. Calculate composition from weight percentages\n');
    fprintf('2. Convert atom percent to weight percent\n');
    fprintf('3. Convert weight percent to atom percent\n');
    fprintf('4. Calculate concentration in kg/m^3\n');
    fprintf('5. Calculate weight percent from number of atoms (BUGGY??)\n');
    fprintf('6. Convert mass to weight percent\n');
    fprintf('7. Calculate weight percent for substitutional solid solution\n');
    fprintf('8. Exit\n');
    
    choice = input('Enter your choice (1-8): ');
    
    if choice == 1
        n = input('Enter the number of components: ');
        wt_percents = zeros(1, n);
        densities = zeros(1, n);
        atomic_weights = zeros(1, n);
        
        for i = 1:n
            wt_percents(i) = input(sprintf('Enter weight percent of component %d: ', i));
            densities(i) = input(sprintf('Enter density of component %d (g/cm^3): ', i));
            atomic_weights(i) = input(sprintf('Enter atomic weight of component %d (g/mol): ', i));
        end
        
        [at_percents, ~, density, atomic_weight] = calculate_composition(wt_percents, densities, atomic_weights);
        
        for i = 1:n
            fprintf('Atom percent of component %d: %.2f at%%\n', i, at_percents(i));
        end
        fprintf('Density of the alloy: %.2f g/cm^3\n', density);
        fprintf('Atomic weight of the alloy: %.2f amu\n', atomic_weight);
        
    elseif choice == 2
        n = input('Enter the number of components: ');
        at_percents = zeros(1, n);
        atomic_weights = zeros(1, n);
        
        for i = 1:n
            at_percents(i) = input(sprintf('Enter atom percent of component %d: ', i));
            atomic_weights(i) = input(sprintf('Enter atomic weight of component %d (g/mol): ', i));
        end
        
        wt_percents = at_to_wt_percent(at_percents, atomic_weights);
        
        for i = 1:n
            fprintf('Weight percent of component %d: %.2f wt%%\n', i, wt_percents(i));
        end
        
    elseif choice == 3
        n = input('Enter the number of components: ');
        wt_percents = zeros(1, n);
        atomic_weights = zeros(1, n);
        
        for i = 1:n
            wt_percents(i) = input(sprintf('Enter weight percent of component %d: ', i));
            atomic_weights(i) = input(sprintf('Enter atomic weight of component %d (g/mol): ', i));
        end
        
        [at_percents, ~, ~, ~] = calculate_composition(wt_percents, ones(1,n), atomic_weights);
        
        for i = 1:n
            fprintf('Atom percent of component %d: %.2f at%%\n', i, at_percents(i));
        end
        
    elseif choice == 4
        wt_percent = input('Enter weight percent of the component: ');
        alloy_density = input('Enter density of the alloy (g/cm^3): ');
        
        concentration = calculate_concentration_kg_m3(wt_percent, alloy_density);
        fprintf('Concentration: %.2f kg/m^3\n', concentration);
        
    elseif choice == 5
        n = input('Enter the number of elements: ');
        target_atoms_cm3 = input('Enter the number of atoms per cubic centimeter for the target element: ');
        densities = zeros(1, n);
        atomic_weights = zeros(1, n);
        
        for i = 1:n
            densities(i) = input(sprintf('Enter density of element %d (g/cm^3): ', i));
            atomic_weights(i) = input(sprintf('Enter atomic weight of element %d (g/mol): ', i));
        end
        
        wt_percents = calculate_wt_percent_from_atoms(target_atoms_cm3, densities, atomic_weights);
        
        for i = 1:n
            fprintf('Weight percent of element %d: %.2f wt%%\n', i, wt_percents(i));
        end        
    elseif choice == 6
        n = input('Enter the number of components: ');
        masses = zeros(1, n);
        
        for i = 1:n
            masses(i) = input(sprintf('Enter mass of component %d: ', i));
        end
        
        wt_percents = mass_to_wt_percent(masses);
        
        for i = 1:n
            fprintf('Weight percent of component %d: %.2f wt%%\n', i, wt_percents(i));
        end

    elseif choice == 7
        target_atoms_cm3 = input('Enter the number of atoms per cubic centimeter for the target element: ');
        density_target = input('Enter density of the target element (g/cm^3): ');
        density_base = input('Enter density of the base element (g/cm^3): ');
        atomic_weight_target = input('Enter atomic weight of the target element (g/mol): ');
        atomic_weight_base = input('Enter atomic weight of the base element (g/mol): ');
        
        wt_percent = calculate_substitutional_solid_solution(target_atoms_cm3, [density_target, density_base], [atomic_weight_target, atomic_weight_base]);
        fprintf('Weight percent of the target element: %.2f wt%%\n', wt_percent);
        
    elseif choice == 8
        break;
    else
        fprintf('Invalid choice. Please try again.\n');
    end
end

fprintf('Thank you for using the Composition Calculator!\n');