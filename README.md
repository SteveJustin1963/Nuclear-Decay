# Nuclear-Decay
3D Simulation of Nuclear Decay Particles

![image](https://github.com/user-attachments/assets/8024d3ae-ebf0-4539-a9c7-3d600fbee7ec)



Nuclear decay is a natural process in which an unstable atomic nucleus loses energy by emitting particles or radiation to reach a more stable state. This emission occurs because certain combinations of protons and neutrons within a nucleus result in instability. To achieve stability, the nucleus may undergo various forms of decay, such as alpha, beta, or gamma decay, each releasing different particles. **Alpha decay** emits a helium nucleus, or alpha particle, consisting of two protons and two neutrons. **Beta decay** converts a neutron to a proton or vice versa, emitting an electron or positron. **Gamma decay** involves the release of high-energy photons without altering the number of protons or neutrons, simply allowing the nucleus to shed excess energy. These processes are governed by the principles of quantum mechanics, and the emission patterns often follow predictable statistical probabilities. Nuclear decay plays a significant role in fields such as radiometric dating, medical imaging, and nuclear energy, where understanding particle emissions allows for the harnessing and application of this natural process in technology and research.

### code
 
This simulation helps visualize how particles might spread out from a nuclear decay event, showing both the final positions of particles and possible paths they might have taken to get there. While it's a simplified visualization rather than a physically accurate simulation, it helps in understanding the 3D nature of particle decay processes.

1. **Setup and Parameters**:
```matlab
clear all;
close all;

% Parameters
n_particles = 50;     % Number of decay particles
n_trajectories = 8;   % Number of decay trajectories
sigma = 2;           % Spread of particles
```
This initializes the simulation by clearing previous data and setting key parameters:
- `n_particles`: How many decay particles to show
- `n_trajectories`: Number of particle paths to display
- `sigma`: Controls how spread out the particles are (larger = more spread)

2. **Creating the 3D Plot Space**:
```matlab
figure('Name', 'Enhanced Nuclear Decay Simulation');
clf;
hold on;
grid on;
axis equal;

xlabel('X-axis (arbitrary units)');
ylabel('Y-axis (arbitrary units)');
zlabel('Z-axis (arbitrary units)');
title('Enhanced 3D Nuclear Decay Simulation');
```
This sets up the 3D visualization environment with:
- A new figure window
- Grid lines for better depth perception
- Equal axis scaling
- Labeled axes and title

3. **Generating Particles**:
```matlab
x = sigma * randn(1, n_particles);
y = sigma * randn(1, n_particles);
z = sigma * randn(1, n_particles);

distances = sqrt(x.^2 + y.^2 + z.^2);
sizes = 100 * (1 ./ (1 + distances));
scatter3(x, y, z, sizes, 'r', 'filled');
```
This creates the nuclear decay particles:
- Uses Gaussian distribution (`randn`) to position particles realistically
- Calculates distance from origin for each particle
- Makes closer particles appear larger (inverse relationship with distance)
- Plots them as red filled circles

4. **Creating Decay Trajectories**:
```matlab
colors = jet(n_trajectories);
t = linspace(0, 4*pi, 100);

for i = 1:n_trajectories
    phase = 2*pi*rand();
    amplitude = 2 + rand();
    frequency = 1 + 0.5*rand();
    decay_factor = 0.1 + 0.2*rand();
    
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
    
    plot3(trajectory_x, trajectory_y, trajectory_z, 'LineWidth', 1.5, 'Color', colors(i,:));
end
```
This creates different types of particle paths:
- Uses three different patterns (helical, spiral, and curved)
- Each trajectory has random variations in:
  - Phase (starting point)
  - Amplitude (size of the path)
  - Frequency (how tightly wound)
  - Decay factor (how quickly the path dies out)
- Each path gets a different color from the jet colormap

5. **Adding Visual Elements**:
```matlab
% Energy contours
[X, Y] = meshgrid(linspace(-5, 5, 20));
Z = -5 * ones(size(X));
C = sqrt(X.^2 + Y.^2);
contour3(X, Y, Z, C, 10);

% Central source
scatter3(0, 0, 0, 200, 'y', 'filled');

% Reference arrows
arrow_length = 2;
quiver3(0, 0, 0, arrow_length, 0, 0, 'r', 'LineWidth', 2);
quiver3(0, 0, 0, 0, arrow_length, 0, 'g', 'LineWidth', 2);
quiver3(0, 0, 0, 0, 0, arrow_length, 'b', 'LineWidth', 2);
```
This adds additional visualization elements:
- Energy contours showing the strength field in the XY plane
- A yellow dot at the origin representing the source
- RGB arrows showing the X, Y, and Z directions

6. **Final Setup and Animation**:
```matlab
view(45, 30);
xlim([-5 5]); ylim([-5 5]); zlim([-5 5]);
legend('Decay Particles', 'Trajectories');
box on;
hold off;

% Rotation animation
for angle = 1:6:360
    view(angle, 20);
    drawnow;
end
```
This finalizes the visualization:
- Sets the viewing angle and plot boundaries
- Adds a legend
- Creates an animation that rotates the view 360 degrees

7. **Saving Output**:
```matlab
print('nuclear_decay_simulation.png', '-dpng');
```
This saves the final visualization as an image file.
