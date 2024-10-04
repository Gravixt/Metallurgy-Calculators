clear
clc

function advanced_material_properties_calculator()
    while true
        fprintf('\nAdvanced Material Properties Calculator\n');
        fprintf('1. Calculate Elongation from Load (using stress-strain curve)\n');
        fprintf('2. Calculate Load for Given Elongation (using stress-strain curve)\n');
        fprintf('3. Calculate Modulus of Resilience\n');
        fprintf('4. Calculate Minimum Yield Strength for Given Modulus of Resilience\n');
        fprintf('5. Exit\n');
        
        choice = input('Enter your choice (1-5): ');
        
        switch choice
            case 1
                calculate_elongation_from_load();
            case 2
                calculate_load_for_elongation();
            case 3
                calculate_modulus_of_resilience();
            case 4
                calculate_min_yield_strength();
            case 5
                fprintf('Thank you for using the Advanced Material Properties Calculator!\n');
                return;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end
        
        fprintf('\nPress Enter to continue...\n');
        input('');
    end
end

function calculate_elongation_from_load()
    fprintf('\nCalculate Elongation from Load\n');
    load = input('Enter applied load (N): ');
    diameter = input('Enter specimen diameter (mm): ');
    length = input('Enter original specimen length (mm): ');
    
    area = pi * (diameter/2)^2;
    stress = load / area;
    
    fprintf('Calculated stress: %.2f MPa\n', stress);
    strain = input('Please refer to the stress-strain curve and enter the corresponding strain value: ');
    
    elongation = strain * length;
    
    fprintf('Elongation: %.4f mm\n', elongation);
end

function calculate_load_for_elongation()
    fprintf('\nCalculate Load for Given Elongation\n');
    length = input('Enter original specimen length (mm): ');
    width = input('Enter specimen width (mm): ');
    height = input('Enter specimen height (mm): ');
    elongation = input('Enter desired elongation (mm): ');
    
    strain = elongation / length;
    fprintf('Calculated strain: %.6f\n', strain);
    fprintf('Please refer to the stress-strain curve and determine if this strain is in the elastic region.\n');
    is_elastic = input('Is the strain in the elastic region? (1 for Yes, 0 for No): ');
    
    if is_elastic
        stress = input('Enter the corresponding stress from the curve (MPa): ');
        area = width * height;
        load = stress * area;
        
        fprintf('Required load: %.0f N\n', load);
        fprintf('Deformation after load release: 0 mm (elastic deformation)\n');
    else
        fprintf('The strain is in the plastic region. Consult the stress-strain curve for precise stress value.\n');
        stress = input('Enter the corresponding stress from the curve (MPa): ');
        area = width * height;
        load = stress * area;
        
        fprintf('Required load: %.0f N\n', load);
        fprintf('Deformation after load release: Plastic deformation occurred.\n');
        fprintf('Consult the stress-strain curve for precise plastic deformation value.\n');
    end
end

function calculate_modulus_of_resilience()
    fprintf('\nCalculate Modulus of Resilience\n');
    yield_strength = input('Enter yield strength (MPa): ');
    elastic_modulus = input('Enter elastic modulus (GPa): ');
    
    modulus_of_resilience = (yield_strength^2 * 1000) / (2 * elastic_modulus);
    
    fprintf('Modulus of Resilience: %.2e J/m^3\n', modulus_of_resilience);
end

function calculate_min_yield_strength()
    fprintf('\nCalculate Minimum Yield Strength for Given Modulus of Resilience\n');
    modulus_of_resilience = input('Enter required modulus of resilience (J/m^3): ');
    elastic_modulus = input('Enter elastic modulus (GPa): ');
    
    yield_strength = sqrt(2 * modulus_of_resilience * elastic_modulus * 1000) ./ 1000;
    
    fprintf('Minimum Yield Strength: %.2f MPa\n', yield_strength);
end

% Run the calculator
advanced_material_properties_calculator();