clear
clc

function avg_weight = calculate_average_atomic_weight(isotopes)
    avg_weight = sum(isotopes(:, 1) .* isotopes(:, 2));
end

function result = analyze_electron_configuration(config)
    subshells = regexp(config, '(\d*[spdf]\d*)', 'match');
    result = struct('subshell', {}, 'electrons', {});
    for i = 1:numel(subshells)
        subshell = subshells{i};
        tokens = regexp(subshell, '(\d*)([spdf])(\d+)', 'tokens');
        if ~isempty(tokens)
            principal_quantum_number = tokens{1}{1};
            shell_type = tokens{1}{2};
            electrons = str2double(tokens{1}{3});
            result(i).subshell = [principal_quantum_number shell_type];
            result(i).electrons = electrons;
        end
    end
end

function force = calculate_ionic_force(q1, q2, r)
    k = 8.9875e9; % Coulomb's constant in N⋅m²/C²
    e = 1.60218e-19; % Elementary charge in Coulombs
    force = k * abs(q1 * q2) * (e^2) / (r^2);
end

function [force_attraction, force_repulsion] = calculate_interionic_forces(q1, q2, r1, r2)
    r_total = r1 + r2; % Equilibrium interionic separation
    force_attraction = calculate_ionic_force(q1, q2, r_total);
    force_repulsion = -force_attraction; % At equilibrium, attraction and repulsion forces are equal
end

function anion_radius = calculate_anion_radius(force, q1, q2, cation_radius)
    k = 8.9875e9; % Coulomb's constant in N⋅m²/C²
    e = 1.60218e-19; % Elementary charge in Coulombs
    r_total = sqrt(k * abs(q1 * q2) * (e^2) / force);
    anion_radius = r_total - cation_radius;
end

% Main script
while true
    fprintf('\nChemistry Calculator\n');
    fprintf('1. Calculate average atomic weight\n');
    fprintf('2. Analyze electron configuration\n');
    fprintf('3. Calculate ionic force\n');
    fprintf('4. Calculate interionic forces\n');
    fprintf('5. Calculate anion radius\n');
    fprintf('6. Exit\n');
    
    choice = input('Enter your choice (1-6): ');
    
    if choice == 1
        disp('Calculate Average Atomic Weight');
        n = input('Enter the number of isotopes: ');
        isotopes = zeros(n, 2);
        for i = 1:n
            isotopes(i, 1) = input(sprintf('Enter abundance of isotope %d (in %%): ', i)) / 100;
            isotopes(i, 2) = input(sprintf('Enter atomic weight of isotope %d (in amu): ', i));
        end
        avg_weight = calculate_average_atomic_weight(isotopes);
        fprintf('The average atomic weight is %.4f amu\n', avg_weight);
    elseif choice == 2
        disp('Analyze Electron Configuration');
        config = input('Enter electron configuration (e.g., 1s2 2s2 2p6 3s2 3p6 3d2 4s2): ', 's');
        result = analyze_electron_configuration(config);
        disp('Electron distribution:');
        for i = 1:numel(result)
            fprintf('%s subshell: %d electrons\n', result(i).subshell, result(i).electrons);
        end
    elseif choice == 3
        disp('Calculate Ionic Force');
        q1 = input('Enter valence of first ion: ');
        q2 = input('Enter valence of second ion: ');
        r = input('Enter distance between ion centers (in nm): ') * 1e-9; % Convert nm to m
        force = calculate_ionic_force(q1, q2, r);
        fprintf('The force of attraction is %.4e N\n', force);
    elseif choice == 4
        disp('Calculate Interionic Forces');
        q1 = input('Enter valence of cation: ');
        q2 = -input('Enter valence of anion (positive number): ');
        r1 = input('Enter cation radius (in nm): ') * 1e-9; % Convert nm to m
        r2 = input('Enter anion radius (in nm): ') * 1e-9; % Convert nm to m
        [force_attraction, force_repulsion] = calculate_interionic_forces(q1, q2, r1, r2);
        fprintf('Force of attraction: %.4e N\n', force_attraction);
        fprintf('Force of repulsion: %.4e N\n', force_repulsion);
    elseif choice == 5
        disp('Calculate Anion Radius');
        force = input('Enter force of attraction (in N): ');
        q1 = input('Enter valence of cation: ');
        q2 = -input('Enter valence of anion (positive number): ');
        r_cation = input('Enter cation radius (in nm): ') * 1e-9; % Convert nm to m
        r_anion = calculate_anion_radius(force, q1, q2, r_cation);
        fprintf('Anion radius: %.4f nm\n', r_anion * 1e9); % Convert m to nm for display
    elseif choice == 6
        break;
    else
        fprintf('Invalid choice. Please try again.\n');
    end
    
    fprintf('\nPress Enter to continue...\n');
    input('');
end

fprintf('Thank you for using the Chemistry Calculator!\n');