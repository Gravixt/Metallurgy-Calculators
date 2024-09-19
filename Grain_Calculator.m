clear
clc

function grains_per_inch2 = calculate_grains_from_ASTM(ASTM_number, magnification)
    % Calculate number of grains per square inch at 1x magnification
    N_1x = 2^(ASTM_number - 1) * 100^2;
    
    % Adjust for the given magnification
    grains_per_inch2 = N_1x / magnification^2;
end

function ASTM_number = calculate_ASTM_from_grains(grains_per_inch2, magnification)
    % Adjust grains per square inch to 1x magnification
    N_1x = grains_per_inch2 * magnification^2;
    
    % Calculate ASTM grain size number
    ASTM_number = log2(N_1x / 100^2) + 1;
end

% Main script
while true
    fprintf('\nGrain Size Calculator\n');
    fprintf('1. Calculate grains per square inch from ASTM number\n');
    fprintf('2. Calculate ASTM number from grains per square inch\n');
    fprintf('3. Exit\n');
    
    choice = input('Enter your choice (1-3): ');
    
    if choice == 1
        ASTM_number = input('Enter the ASTM grain size number: ');
        magnification = input('Enter the magnification (enter 1 for no magnification): ');
        
        grains_per_inch2 = calculate_grains_from_ASTM(ASTM_number, magnification);
        
        fprintf('Number of grains per square inch at %dx magnification: %.2f\n', magnification, grains_per_inch2);
        
        if magnification ~= 1
            grains_unmagnified = calculate_grains_from_ASTM(ASTM_number, 1);
            fprintf('Number of grains per square inch without magnification: %.2f\n', grains_unmagnified);
        end
        
    elseif choice == 2
        grains_per_inch2 = input('Enter the number of grains per square inch: ');
        magnification = input('Enter the magnification: ');
        
        ASTM_number = calculate_ASTM_from_grains(grains_per_inch2, magnification);
        
        fprintf('ASTM grain size number: %.2f\n', ASTM_number);
        
    elseif choice == 3
        break;
    else
        fprintf('Invalid choice. Please try again.\n');
    end
end

fprintf('Thank you for using the Grain Size Calculator!\n');