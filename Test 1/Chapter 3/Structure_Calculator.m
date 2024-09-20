clear
clc

% Constants
NA = 6.022e23; % Avogadro's number

function volume = calculate_unit_cell_volume(structure, a, c)
    switch structure
        case 'SC'
            volume = a^3;
        case 'BCC'
            volume = a^3;
        case 'FCC'
            volume = a^3;
        case 'HCP'
            volume = sqrt(3)/2 * a^2 * c;
    end
end

function [symbolic_LD, numeric_LD] = calculate_linear_density(structure, direction, R)
    switch structure
        case 'SC'
            if isequal(direction, [1 0 0])
                symbolic_LD = '1/(2R)';
                numeric_LD = 1 / (2*R);
            else
                error('Unsupported direction for SC');
            end
        case 'BCC'
            if isequal(direction, [1 0 0])
                symbolic_LD = '2/(4R/sqrt(3))';
                numeric_LD = 2 / (4*R/sqrt(3));
            else
                error('Unsupported direction for BCC');
            end
        case 'FCC'
            if isequal(direction, [1 0 0])
                symbolic_LD = '1/(2R*sqrt(2))';
                numeric_LD = 1 / (2*R*sqrt(2));
            elseif isequal(direction, [1 1 0])
                symbolic_LD = '1/(R*sqrt(2))';
                numeric_LD = 1 / (R*sqrt(2));
            else
                error('Unsupported direction for FCC');
            end
        otherwise
            error('Unsupported crystal structure');
    end
end

function a = calculate_lattice_parameter(structure, radius)
    switch structure
        case 'SC'
            a = 2 * radius;
        case 'BCC'
            a = 4 * radius / sqrt(3);
        case 'FCC'
            a = 4 * radius / sqrt(2);
        otherwise
            error('Unsupported crystal structure');
    end
end

function d = calculate_interplanar_spacing(structure, a, h, k, l)
    switch structure
        case {'SC', 'BCC', 'FCC'}
            d = a / sqrt(h^2 + k^2 + l^2);
        otherwise
            error('Unsupported crystal structure');
    end
end

function [theta, two_theta] = calculate_diffraction_angle(d, wavelength)
    theta = asin(wavelength / (2 * d));
    two_theta = 2 * theta * 180 / pi; % Convert to degrees
end

% Main script
while true
    fprintf('\nCrystallography Calculator\n');
    fprintf('1. Calculate unit cell volume\n');
    fprintf('2. Calculate linear density\n');
    fprintf('3. Calculate interplanar spacing\n');
    fprintf('4. Calculate diffraction angle\n');
    fprintf('5. Exit\n');
    
    choice = input('Enter your choice (1-5): ');
    
    if choice == 1
        structure = input('Enter crystal structure (SC, BCC, FCC, or HCP): ', 's');
        input_type = input('Enter "L" for lattice parameter or "R" for atomic radius: ', 's');
        
        if strcmpi(input_type, 'L')
            a = input('Enter lattice parameter a (in nm): ');
            if strcmp(structure, 'HCP')
                c = input('Enter lattice parameter c (in nm): ');
            else
                c = a;
            end
        elseif strcmpi(input_type, 'R')
            radius = input('Enter atomic radius (in nm): ');
            switch structure
                case 'SC'
                    a = 2 * radius;
                    c = a;
                case 'BCC'
                    a = 4 * radius / sqrt(3);
                    c = a;
                case 'FCC'
                    a = 4 * radius / sqrt(2);
                    c = a;
                case 'HCP'
                    a = 2 * radius;
                    c_a_ratio = input('Enter c/a ratio: ');
                    c = c_a_ratio * a;
                otherwise
                    error('Invalid structure for atomic radius input');
            end
        else
            error('Invalid input type');
        end
        
        volume = calculate_unit_cell_volume(structure, a, c);
        fprintf('Unit cell volume: %.6e m^3\n', volume * 1e-27);
    elseif choice == 2
        fprintf('Calculate linear density\n');
        structure = input('Enter crystal structure (SC, BCC, or FCC): ', 's');
        direction = input('Enter direction (e.g., [1 0 0] or [1 1 0]): ');
        R = input('Enter atomic radius R (in nm): ');
        
        [symbolic_LD, numeric_LD] = calculate_linear_density(structure, direction, R);
        
        fprintf('Linear density expression: LD = %s\n', symbolic_LD);
        fprintf('Numeric linear density: %.4f nm^-1\n', numeric_LD);
        
        % Calculate for gold if FCC [100]
        if strcmpi(structure, 'FCC') && isequal(direction, [1 0 0])
            R_gold = 0.144; % nm (atomic radius of gold)
            [~, LD_gold] = calculate_linear_density('FCC', [1 0 0], R_gold);
            fprintf('\nFor gold (R = %.4f nm):\n', R_gold);
            fprintf('Linear density: %.4f nm^-1\n', LD_gold);
        end
    elseif choice == 3
        fprintf('Calculate interplanar spacing\n');
        structure = input('Enter crystal structure (SC, BCC, or FCC): ', 's');
        radius = input('Enter atomic radius (in nm): ');
        h = input('Enter h index: ');
        k = input('Enter k index: ');
        l = input('Enter l index: ');
        
        a = calculate_lattice_parameter(structure, radius);
        d = calculate_interplanar_spacing(structure, a, h, k, l);
        
        fprintf('Interplanar spacing d(%d%d%d) = %.4f nm\n', h, k, l, d);
    elseif choice == 4
        fprintf('Calculate diffraction angle\n');
        structure = input('Enter crystal structure (SC, BCC, or FCC): ', 's');
        radius = input('Enter atomic radius (in nm): ');
        h = input('Enter h index: ');
        k = input('Enter k index: ');
        l = input('Enter l index: ');
        wavelength = input('Enter wavelength of radiation (in nm): ');
        
        a = calculate_lattice_parameter(structure, radius);
        d = calculate_interplanar_spacing(structure, a, h, k, l);
        [theta, two_theta] = calculate_diffraction_angle(d, wavelength);
        
        fprintf('Lattice parameter a = %.4f nm\n', a);
        fprintf('Interplanar spacing d(%d%d%d) = %.4f nm\n', h, k, l, d);
        fprintf('Diffraction angle θ for (%d%d%d) planes: %.2f degrees\n', h, k, l, theta * 180 / pi);
        fprintf('Diffraction angle 2θ (typically reported) for (%d%d%d) planes: %.2f degrees\n', h, k, l, two_theta);
    elseif choice == 5
        break;
    else
        fprintf('Invalid choice. Please try again.\n');
    end
    
    fprintf('\nPress Enter to continue...\n');
    input('');
end

fprintf('Thank you for using the Crystallography Calculator!\n');