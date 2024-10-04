clear
clc

function mechanical_properties_calculator()
    while true
        fprintf('\nMechanical Properties Calculator\n');
        fprintf('1. Calculate Strain (given force, dimensions, and elastic modulus)\n');
        fprintf('2. Calculate Maximum Length (given force, diameter, elastic modulus, and max elongation)\n');
        fprintf('3. Calculate Elongation (given force, diameter, length, and elastic modulus)\n');
        fprintf('4. Calculate Maximum Load and Length (given stress, elastic modulus, area, and original length)\n');
        fprintf('5. Calculate Elongation from Stress-Strain Curve\n');
        fprintf('6. Exit\n');
        
        choice = input('Enter your choice (1-6): ');
        
        switch choice
            case 1
                calculate_strain();
            case 2
                calculate_max_length();
            case 3
                calculate_elongation();
            case 4
                calculate_max_load_and_length();
            case 5
                calculate_elongation_from_curve();
            case 6
                fprintf('Thank you for using the Mechanical Properties Calculator!\n');
                return;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end
        
        fprintf('\nPress Enter to continue...\n');
        input('');
    end
end

function calculate_strain()
    fprintf('\nCalculate Strain\n');
    force = input('Enter force (N): ');
    width = input('Enter width (mm): ');
    height = input('Enter height (mm): ');
    elastic_modulus = input('Enter elastic modulus (GPa): ');
    
    area = width * height * 1e-6;  % Convert mm^2 to m^2
    stress = force / area;
    strain = stress / (elastic_modulus * 1e9);
    
    fprintf('Resulting strain: %.6f\n', strain);
end

function calculate_max_length()
    fprintf('\nCalculate Maximum Length\n');
    force = input('Enter force (N): ');
    diameter = input('Enter diameter (mm): ');
    elastic_modulus = input('Enter elastic modulus (GPa): ');
    max_elongation = input('Enter maximum allowable elongation (mm): ');
    
    area = pi * (diameter/2)^2 * 1e-6;  % Convert mm^2 to m^2
    stress = force / area;
    strain = stress / (elastic_modulus * 1e9);
    original_length = max_elongation / strain;  % Convert m to mm
    
    fprintf('Maximum length before deformation: %.2f mm\n', original_length);
end

function calculate_elongation()
    fprintf('\nCalculate Elongation\n');
    force = input('Enter force (N): ');
    diameter = input('Enter diameter (mm): ');
    length = input('Enter length (mm): ');
    elastic_modulus = input('Enter elastic modulus (GPa): ');
    
    area = pi * (diameter/2)^2 * 1e-6;  % Convert mm^2 to m^2
    stress = force / area;
    strain = stress / (elastic_modulus * 1e9);
    elongation = strain * length;
    
    fprintf('Elongation: %.4f mm\n', elongation);
end

function calculate_max_load_and_length()
    fprintf('\nCalculate Maximum Load and Length\n');
    yield_stress = input('Enter yield stress (MPa): ');
    elastic_modulus = input('Enter elastic modulus (GPa): ');
    area = input('Enter cross-sectional area (mm^2): ');
    original_length = input('Enter original length (mm): ');
    
    max_load = yield_stress * area;  % Convert MPa to N/mm^2
    max_strain = yield_stress / (elastic_modulus * 1e3);  % Convert GPa to MPa
    max_elongation = max_strain * original_length;
    max_length = original_length + max_elongation;
    
    fprintf('Maximum load without plastic deformation: %.2f N\n', max_load);
    fprintf('Maximum length without plastic deformation: %.2f mm\n', max_length);
end

function calculate_elongation_from_curve()
    fprintf('\nCalculate Elongation from Stress-Strain Curve\n');
    force = input('Enter force (N): ');
    diameter = input('Enter diameter (mm): ');
    length = input('Enter length (mm): ');
    
    % This function would typically use a lookup table or function to determine the strain
    % from the stress-strain curve. For this example, we'll use a simplified linear relationship.
    area = pi * (diameter/2)^2;
    stress = force / area;
    
    % Simplified stress-strain relationship (replace with actual curve data)
    if stress < 250  % MPa
        strain = stress / 200000;  % Assuming E = 200 GPa in the elastic region
    else
        strain = 0.00125 + (stress - 250) / 10000;  % Simplified plastic region
    end
    
    elongation = strain * length;
    
    fprintf('Elongation: %.4f mm\n', elongation);
end

mechanical_properties_calculator()