% MATLAB Code for Enhanced 3D Nuclear Decay Simulation, run in https://www.mycompiler.io/new/octave
clear all;
close all;

% Parameters
n_particles = 50;     % Number of decay particles
n_trajectories = 8;   % Number of decay trajectories
sigma = 2;           % Spread of particles

% Create and configure the figure
figure('Name', 'Enhanced Nuclear Decay Simulation');
clf;

% Configure the axes
hold on;
grid on;
axis equal;

% Set axis labels
xlabel('X-axis (arbitrary units)');
ylabel('Y-axis (arbitrary units)');
zlabel('Z-axis (arbitrary units)');
title('Enhanced 3D Nuclear Decay Simulation');

% Generate decay points with Gaussian distribution
x = sigma * randn(1, n_particles);
y = sigma * randn(1, n_particles);
z = sigma * randn(1, n_particles);

% Calculate distances for size variation
distances = sqrt(x.^2 + y.^2 + z.^2);
sizes = 100 * (1 ./ (1 + distances)); % Larger points for closer particles

% Create particle plot
scatter3(x, y, z, sizes, 'r', 'filled');

% Generate multiple decay trajectories with varying patterns
colors = jet(n_trajectories);
t = linspace(0, 4*pi, 100);

for i = 1:n_trajectories
    % Create more complex paths combining helical and spiral motion
    phase = 2*pi*rand();
    amplitude = 2 + rand();
    frequency = 1 + 0.5*rand();
    decay_factor = 0.1 + 0.2*rand();
    
    % Different trajectory patterns
    if mod(i, 3) == 0
        % Helical trajectory
        trajectory_x = amplitude * cos(frequency*t + phase) .* exp(-decay_factor*t);
        trajectory_y = amplitude * sin(frequency*t + phase) .* exp(-decay_factor*t);
        trajectory_z = t;
    elseif mod(i, 3) == 1
        % Spiral trajectory
        trajectory_x = amplitude * t .* cos(frequency*t + phase) .* exp(-decay_factor*t);
        trajectory_y = amplitude * t .* sin(frequency*t + phase) .* exp(-decay_factor*t);
        trajectory_z = 5 * (1 - exp(-decay_factor*t));
    else
        % Curved trajectory
        trajectory_x = amplitude * sin(frequency*t + phase);
        trajectory_y = amplitude * cos(2*frequency*t + phase);
        trajectory_z = amplitude * sin(frequency*t/2);
    end
    
    % Plot trajectories
    plot3(trajectory_x, trajectory_y, trajectory_z, ...
        'LineWidth', 1.5, ...
        'Color', colors(i,:));
end

% Add energy contours on xy-plane
[X, Y] = meshgrid(linspace(-5, 5, 20));
Z = -5 * ones(size(X));
C = sqrt(X.^2 + Y.^2);
contour3(X, Y, Z, C, 10);

% Add central source point
scatter3(0, 0, 0, 200, 'y', 'filled');

% Add reference frame arrows
arrow_length = 2;
quiver3(0, 0, 0, arrow_length, 0, 0, 'r', 'LineWidth', 2);
quiver3(0, 0, 0, 0, arrow_length, 0, 'g', 'LineWidth', 2);
quiver3(0, 0, 0, 0, 0, arrow_length, 'b', 'LineWidth', 2);

% Configure view and axis limits
view(45, 30);
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);

% Add legend
legend('Decay Particles', 'Trajectories');

% Final touches
box on;
hold off;

% Rotate the view for better visualization
for angle = 1:6:360
    view(angle, 20);
    drawnow;
end
