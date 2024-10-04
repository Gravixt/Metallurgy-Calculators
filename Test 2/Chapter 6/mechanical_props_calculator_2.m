clear
clc

% mechanical_props_calculator.m

function run_calculator()
    while true
        fprintf('\nAdvanced Mechanical Properties Calculator\n');
        fprintf('1. Calculate Elongation and Diameter Change\n');
        fprintf('2. Calculate Force for Given Diameter Reduction\n');
        fprintf('3. Calculate Original Length from Diameter Change\n');
        fprintf('4. Calculate Elastic Modulus from Diameter Reduction\n');
        fprintf('5. Calculate Elongation and Diameter Change from Stress-Strain Curve\n');
        fprintf('6. Exit\n');
        
        choice = input('Enter your choice (1-6): ');
        
        switch choice
            case 1
                calculate_elongation_and_diameter_change();
            case 2
                calculate_force_for_diameter_reduction();
            case 3
                calculate_original_length();
            case 4
                calculate_elastic_modulus();
            case 5
                calculate_from_stress_strain_curve();
            case 6
                fprintf('Thank you for using the Advanced Mechanical Properties Calculator!\n');
                return;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end
        
        fprintf('\nPress Enter to continue...\n');
        input('');
    end
end

function calculate_elongation_and_diameter_change()
    fprintf('\nCalculate Elongation and Diameter Change\n');
    diameter = input('Enter initial diameter (mm): ');
    length = input('Enter initial length (mm): ');
    force = input('Enter applied force (N): ');
    E = input('Enter elastic modulus (GPa): ');
    nu = input('Enter Poisson''s ratio: ');
    
    area = pi * (diameter/2)^2;
    stress = force / area;
    strain = stress / (E * 1e3);
    
    elongation = strain * length;
    diameter_change = -nu * strain * diameter;
    
    fprintf('Elongation: %.6f mm\n', elongation);
    fprintf('Change in diameter: %.6f mm\n', diameter_change);
end

function calculate_force_for_diameter_reduction()
    fprintf('\nCalculate Force for Given Diameter Reduction\n');
    diameter = input('Enter initial diameter (mm): ');
    diameter_reduction = input('Enter diameter reduction (mm): ');
    E = input('Enter elastic modulus (GPa): ');
    nu = input('Enter Poisson''s ratio: ');
    
    area = pi * (diameter/2)^2;
    strain = diameter_reduction / (nu * diameter);
    stress = strain * E * 1e3;
    force = stress * area;
    
    fprintf('Required force: %.2f N\n', force);
end

function calculate_original_length()
    fprintf('\nCalculate Original Length from Diameter Change\n');
    initial_diameter = input('Enter initial diameter (mm): ');
    final_diameter = input('Enter final diameter (mm): ');
    final_length = input('Enter final length (mm): ');
    E = input('Enter elastic modulus (GPa): ');
    G = input('Enter shear modulus (GPa): ');
    
    nu = (E / (2 * G)) - 1;
    radial_strain = (final_diameter - initial_diameter) / initial_diameter;
    axial_strain = -radial_strain / nu;
    original_length = final_length / (1 + axial_strain);
    
    fprintf('Original length: %.4f mm\n', original_length);
end

function calculate_elastic_modulus()
    fprintf('\nCalculate Elastic Modulus from Diameter Reduction\n');
    diameter = input('Enter initial diameter (mm): ');
    force = input('Enter applied force (N): ');
    diameter_reduction = input('Enter diameter reduction (mm): ');
    nu = input('Enter Poisson''s ratio: ');
    
    area = pi * (diameter/2)^2;
    stress = force / area;
    radial_strain = diameter_reduction / diameter;
    axial_strain = radial_strain / nu;
    E = stress / axial_strain / 1e3;
    
    fprintf('Elastic modulus: %.2f GPa\n', E);
end

function calculate_from_stress_strain_curve()
    fprintf('\nCalculate Elongation and Diameter Change from Stress-Strain Curve\n');
    diameter = input('Enter initial diameter (mm): ');
    length = input('Enter initial length (mm): ');
    force = input('Enter applied force (N): ');
    nu = input('Enter Poisson''s ratio: ');
    
    area = pi * (diameter/2)^2;
    stress = force / area; % N/mm^2 or MPa
    
    fprintf('Calculated stress: %.2f MPa\n', stress);
    strain = input('Please refer to the stress-strain curve and enter the corresponding strain value: ');
    
    elongation = strain * length;
    diameter_change = -nu * strain * diameter;
    
    fprintf('Elongation: %.4f mm\n', elongation);
    fprintf('Change in diameter: %.6f mm\n', diameter_change);
end

% Run the calculator
run_calculator()