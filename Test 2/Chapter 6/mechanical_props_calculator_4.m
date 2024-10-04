clear
clc

function advanced_stress_strain_calculator()
    while true
        fprintf('\nAdvanced Stress-Strain and Toughness Calculator\n');
        fprintf('1. Calculate True Stress for Given True Plastic Strain\n');
        fprintf('2. Calculate Engineering Stress for Given Engineering Plastic Strain\n');
        fprintf('3. Calculate Toughness (Energy to Cause Fracture)\n');
        fprintf('4. Exit\n');
        
        choice = input('Enter your choice (1-4): ');
        
        switch choice
            case 1
                calculate_true_stress();
            case 2
                calculate_engineering_stress();
            case 3
                calculate_toughness();
            case 4
                fprintf('Thank you for using the Advanced Stress-Strain and Toughness Calculator!\n');
                return;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end
        
        fprintf('\nPress Enter to continue...\n');
        input('');
    end
end

function calculate_true_stress()
    fprintf('\nCalculate True Stress for Given True Plastic Strain\n');
    stress1 = input('Enter first true stress value: ');
    strain1 = input('Enter corresponding first true plastic strain: ');
    stress2 = input('Enter second true stress value: ');
    strain2 = input('Enter corresponding second true plastic strain: ');
    target_strain = input('Enter target true plastic strain: ');
    
    % Calculate K and n for σ = Kε^n
    n = log(stress2/stress1) / log(strain2/strain1);
    K = stress1 / (strain1^n);
    
    target_stress = K * (target_strain^n);
    
    fprintf('True stress for strain %.4f: %.2f\n', target_strain, target_stress);
end

function calculate_engineering_stress()
    fprintf('\nCalculate Engineering Stress for Given Engineering Plastic Strain\n');
    stress1 = input('Enter first engineering stress value (MPa): ');
    strain1 = input('Enter corresponding first engineering plastic strain: ');
    stress2 = input('Enter second engineering stress value (MPa): ');
    strain2 = input('Enter corresponding second engineering plastic strain: ');
    target_strain = input('Enter target engineering plastic strain: ');
    
    % Linear interpolation
    m = (stress2 - stress1) / (strain2 - strain1);
    target_stress = stress1 + m * (target_strain - strain1);
    
    fprintf('Engineering stress for strain %.4f: %.2f MPa\n', target_strain, target_stress);
end

function calculate_toughness()
    fprintf('\nCalculate Toughness (Energy to Cause Fracture)\n');
    E = input('Enter elastic modulus (GPa): ');
    elastic_strain_limit = input('Enter strain at which elastic deformation terminates: ');
    K = input('Enter K value for plastic deformation (MPa): ');
    n = input('Enter n value for plastic deformation: ');
    final_strain = input('Enter strain at which fracture occurs: ');
    
    % Calculate elastic energy
    elastic_energy = 0.5 * E * 1e9 * elastic_strain_limit^2;
    
    % Calculate plastic energy
    plastic_energy = (K * 1e6 / (n + 1)) * (final_strain^(n + 1) - elastic_strain_limit^(n + 1));
    
    total_energy = elastic_energy + plastic_energy;
    
    fprintf('Elastic contribution: %.2e J/m^3\n', elastic_energy);
    fprintf('Plastic contribution: %.2e J/m^3\n', plastic_energy);
    fprintf('Total Toughness: %.2e J/m^3\n', total_energy);
end

% Run the calculator
advanced_stress_strain_calculator();