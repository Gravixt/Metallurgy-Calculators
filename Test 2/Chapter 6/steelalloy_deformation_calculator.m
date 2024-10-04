clear
clc

function steel_alloy_deformation_calculator()
    fprintf('\nSteel Alloy Deformation Calculator\n');
    
    % Input dimensions, force, and elastic modulus
    width = input('Enter specimen width (mm): ');
    thickness = input('Enter specimen thickness (mm): ');
    force = input('Enter applied force (N): ');
    E = input('Enter elastic modulus (GPa): ');
    
    % Calculate stress
    area = width * thickness;
    stress = force / area;
    fprintf('\nCalculated stress: %.2f MPa\n', stress);
    
    % Estimate total strain from the curve
    total_strain = input('Estimated total strain from the curve at the calculated stress: ');
    
    % Calculate strains
    elastic_strain = stress / (E * 1000);
    plastic_strain = total_strain - elastic_strain;
    
    % Output results
    fprintf('\nResults:\n');
    fprintf('(a) Elastic strain: %.4f\n', elastic_strain);
    fprintf('(b) Plastic strain: %.4f\n', plastic_strain);
    
    % Calculate final length
    original_length = input('\nEnter original length (mm) for final length calculation: ');
    final_length = original_length * (1 + plastic_strain);
    
    fprintf('(c) Final length after force release: %.1f mm\n', final_length);
end

% Run the calculator
steel_alloy_deformation_calculator();