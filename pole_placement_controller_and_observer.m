%  state-space matrices
A = [0, 1, 0; 
     1.9962, 0, -1.3471; 
     0, 1.4818, -1.1];

B = [0; 
     0; 
     1];

% Test values for desired poles - controller
desired_poles_controller = [-5.091, -5.2955+5.0865i, -5.2955-5.0865i]; 

% Test values for desired poles - observer (5*controller)
desired_poles_observer = [-25.455, -26.4775+25.4325i, -26.4775-25.4325i];  % Example poles, placed faster than controller poles

% Checking controllability
ctrb_matrix = ctrb(A, B);
if rank(ctrb_matrix) ~= size(A, 1)
    error('The system is not controllable.');
end

% Calculating conytroller gain matrix
K = place(A, B, desired_poles_controller);

% defining C & D matrices 
C = [1 0 0];
D = zeros(size(C, 1), size(B, 2));

% Checking observability
obsv_matrix = obsv(A, C);
if rank(obsv_matrix) ~= size(A, 1)
    error('The system is not observable.');
end

% Calculating observer gain matrix
L = place(A', C', desired_poles_observer)';

% Display the gain matrices
disp('State Feedback Gain Matrix K:');
disp(K);

disp('Observer Gain Matrix L:');
disp(L);

% Define the augmented system for the observer
A_aug = [A - B*K, B*K;
         zeros(size(A)), A - L*C];
B_aug = [B;
         zeros(size(B))];
C_aug = [C, zeros(size(C))];
D_aug = D;

% Ensure all initial conditions are real numbers
x0 = real([0.1; 0.1; 0.1]);  
x_hat0 = real([0; 0; 0]);    

% Simulation time
t = 0:0.01:10;

% Define the system with observer
sys_aug = ss(A_aug, B_aug, C_aug, D_aug);

% Simulate the system response
[y, t, x] = lsim(sys_aug, zeros(size(t)), t, [x0; x_hat0]);

% Plotting controller results
figure;
plot(t, x(:, 1), 'b', 'LineWidth', 2);
hold on;
plot(t, x(:, 4), 'r', 'LineStyle', ':', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('State');
legend('True State', 'Estimated State');
title('State and Estimated State Response');
grid on;

% Plotting observer results
figure;
plot(t, x(:, 1), 'b', 'LineWidth', 2);
hold on;
plot(t, x(:, 2), 'r--', 'LineWidth', 2);
plot(t, x(:, 3), 'Color', [1 0.7 0.7], 'LineStyle', '-.', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('State Variables');
legend('Displacement (x1)', 'Velocity (x2)', 'Current (x3)');
title('Observer States x1, x2, x3');
grid on;
 