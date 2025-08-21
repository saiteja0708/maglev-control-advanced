% Defining the fuzzy inference system (FIS)
fis = mamfis('Name', 'fuzzy_controller');

% input variable for 'displacement'
fis = addInput(fis, [-2 4], 'Name', 'displacement');
fis = addMF(fis, 'displacement', 'trimf', [-2 -2 -1.5], 'Name', 'Negative Large (NL)');
fis = addMF(fis, 'displacement', 'trimf', [-1.5 -0.5 0], 'Name', 'Negative Medium (NM)');
fis = addMF(fis, 'displacement', 'trimf', [-0.5 0 0.5], 'Name', 'Zero (Z)');
fis = addMF(fis, 'displacement', 'trimf', [0 0.5 1.5], 'Name', 'Positive Medium (PM)');
fis = addMF(fis, 'displacement', 'trimf', [1.5 2 4], 'Name', 'Positive Large (PL)');

% Adding input variable for 'velocity'
fis = addInput(fis, [-2 4], 'Name', 'velocity');
fis = addMF(fis, 'velocity', 'trimf', [-2 -1.5 0], 'Name', 'Negative (N)');
fis = addMF(fis, 'velocity', 'trimf', [-1.5 0 1.5], 'Name', 'Zero (Z)');
fis = addMF(fis, 'velocity', 'trimf', [0 1.5 4], 'Name', 'Positive (P)');

% Add output variable for'control_signal'
fis = addOutput(fis, [0 10], 'Name', 'control_signal');
fis = addMF(fis, 'control_signal', 'trimf', [0 2.5 5], 'Name', 'Low (L)');
fis = addMF(fis, 'control_signal', 'trimf', [2.5 5 7.5], 'Name', 'Medium (M)');
fis = addMF(fis, 'control_signal', 'trimf', [5 7.5 10], 'Name', 'High (H)');

% list of rules (7)
ruleList = [
    1 1 1 1 1; % If displacement is NL and velocity is N, then control_signal is L
    1 3 2 1 1; % If displacement is NL and velocity is P, then control_signal is M
    2 1 1 1 1; % If displacement is NM and velocity is N, then control_signal is L
    2 3 3 1 1; % If displacement is NM and velocity is P, then control_signal is H
    3 1 1 1 1; % If displacement is Z and velocity is N, then control_signal is L
    3 3 3 1 1; % If displacement is Z and velocity is P, then control_signal is H
    5 1 1 1 1; % If displacement is PL and velocity is N, then control_signal is L
];

% Add rules to the FIS
fis = addRule(fis, ruleList);

% Simulation parameters
dt = 0.01;  
t = 0:dt:60;  

% Test values for displacement, velocity and equilibrium displacement
initial_displacement = 2.5;  
desired_displacement = 1.1;  
velocity = 3.5;  

% Simulated system response 
displacement_over_time = initial_displacement * exp(-0.2 * t) + ...
    (desired_displacement - initial_displacement) * (1 - exp(-0.2 * t));

% Evaluate control signal for each time step
input_data = [displacement_over_time' velocity * ones(size(t'))];  
control_signal = evalfis(input_data, fis);

% Plotting the displacement over time
figure;
plot(t, displacement_over_time, 'LineWidth', 2);
hold on;
plot(t, ones(size(t)) * desired_displacement, 'r--', 'LineWidth', 1.5);  % Equilibrium point line
hold off;
title('System Response');
xlabel('Time');
ylabel('Displacement');
legend('Actual Displacement', 'Equilibrium Point');
grid on;

% Plotting the control signal over time
figure;
plot(t, control_signal, 'LineWidth', 2);
title('Control Signal Over Time');
xlabel('Time');
ylabel('Control Signal (A)');
grid on;