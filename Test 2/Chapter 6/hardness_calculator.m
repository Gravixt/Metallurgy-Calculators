clear
clc

function brinell_hardness_calculator()
    while true
        fprintf('\nBrinell Hardness Calculator\n');
        fprintf('1. Calculate Brinell Hardness Number (HB)\n');
        fprintf('2. Calculate Indentation Diameter for given HB\n');
        fprintf('3. Exit\n');
        
        choice = input('Enter your choice (1-3): ');
        
        switch choice
            case 1
                calculate_hb();
            case 2
                calculate_indentation_diameter();
            case 3
                fprintf('Thank you for using the Brinell Hardness Calculator!\n');
                return;
            otherwise
                fprintf('Invalid choice. Please try again.\n');
        end
        
        fprintf('\nPress Enter to continue...\n');
        input('');
    end
end

function calculate_hb()
    fprintf('\nCalculate Brinell Hardness Number (HB)\n');
    D = input('Enter indenter diameter (mm): ');
    d = input('Enter indentation diameter (mm): ');
    P = input('Enter applied load (kg): ');
    
    HB = (2*P) / (pi*D*(D - sqrt(D^2 - d^2)));
    
    fprintf('Brinell Hardness Number (HB): %.0f\n', HB);
end

function calculate_indentation_diameter()
    fprintf('\nCalculate Indentation Diameter for given HB\n');
    D = input('Enter indenter diameter (mm): ');
    HB = input('Enter desired Brinell Hardness Number (HB): ');
    P = input('Enter applied load (kg): ');
    
    d = sqrt(D^2 - (D - (2*P)/(pi*D*HB))^2);
    
    fprintf('Indentation diameter: %.2f mm\n', d);
end

% Run the calculator
brinell_hardness_calculator();