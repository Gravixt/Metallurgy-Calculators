clear
clc

function rockwell_hardness_statistics_calculator()
    fprintf('Rockwell Hardness Statistics Calculator\n');
    
    % Input hardness values
    fprintf('Enter Rockwell hardness values (enter a non-numeric value to finish):\n');
    hardness_values = [];
    while true
        input_value = input('Enter value: ', 's');
        value = str2double(input_value);
        if isnan(value)
            break;
        end
        hardness_values = [hardness_values, value];
    end
    
    % Calculate statistics
    average_hardness = mean(hardness_values);
    std_dev_hardness = std(hardness_values);
    
    % Display results
    fprintf('\nResults:\n');
    fprintf('(a) Average hardness value: %.1f\n', average_hardness);
    fprintf('(b) Standard deviation of hardness values: %.2f\n', std_dev_hardness);
end

% Run the calculator
rockwell_hardness_statistics_calculator();