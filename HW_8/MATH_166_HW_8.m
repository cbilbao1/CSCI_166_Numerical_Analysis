%Initialize linear system, as a column vector
func = @(x) [2*x(1) - 3*x(2) + x(3) - 4; 2*x(1) + x(2) - x(3) + 4; x(1)^2 + x(2)^2 + x(3)^2]

%Initialize Jacobian
Jacobian = @(x) [2, -3, 1; 2, 1, -1; 2*x(1), 2*x(2), 2*x(3)]

%This is our initial guess, column vector
init_guess = [15; 15; 15]

%Variable for stopping criteria, checked that at this point, seems to match
%value
tolerance = 0.0894

newton(@(x) [2*x(1) - 3*x(2) + x(3) - 4; 2*x(1) + x(2) - x(3) + 4; x(1)^2 + x(2)^2 + x(3)^2], ...
    @(x) [2, -3, 1; 2, 1, -1; 2*x(1), 2*x(2), 2*x(3)], [15; 15; 15], 0.0894)

function p = newton(f, J, x0, tol)
i = 0;  %Counter for iteration
%This is the answer, will analyze the second answer
answer = [-2/3; -4/3; 4/3]

error = [0; 0; 0];  % Error variable
residual = [0; 0; 0];   % Residual
b = [0; 0; 0]    % b vector

% f is the system of equations as a column vector
%   this an anonymous function with a vector input and vector output
% J is the Jacobian of the system
%   this is an anonymous function with a vector input and matrix output
% x0 is a set of initial guesses (in a column vector)
% tol is a tolerance
xold = x0;
xnew = x0 - J(x0) \ f(x0)    % Calculate the approximated answer using initial guess
while norm(xnew - xold) > tol   % Take the two norm and compare with tolerance
    xold = xnew;    % Store the current answer
    xnew = xold - J(x0) \ f(xold)  % Calculate new approximated answer
    normal = norm(xnew - xold)  %Take the normal for our stop criteria

    error = answer - xnew;  % Take error
    residual = b - J(x0) \ xnew;    % Take residual

    %Print error and residual
    fprintf("n\t|Error   \t|Residual \t\n")
    fprintf("%d\t|%f\t|%f\t\n", i, inf_norm(error), inf_norm(residual))
    i = i + 1;
end
p = xnew;
end

%Function for taking the infinity norm of vector
function max = inf_norm(v)
    max = -Inf;
    for i = 1:length(v) % Traverse through all of the rows and find max element
        if abs(v(i, 1)) >= max
            max = abs(v(i, 1));
        end
    end
end