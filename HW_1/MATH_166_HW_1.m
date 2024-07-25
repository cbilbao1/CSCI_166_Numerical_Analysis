%1. Plot the function sin(x), from 0 to pi
x = linspace(0, pi);
y = sin(x);
figure
plot (x, y)
title('Figure 1');
ylabel('y');
xlabel('x');

%2. Create matrices and do operations on them
%a.
A = [1, 2; 3, -1]
B = [1, 2, 0; 3, -1, -1]
X = [4; -2]
%b.
ans1 = A * B
ans2 = A * X
ans3 = transpose(B) * X

%3. Work with loops
%a. Create 10 x 12 matrix
A = []
for i = 1:10
    for j = 1:12
        if rem(i + j, 2) == 0
            A = [A, i + j];
        else % Odd case
            A = [A, i - 2j];
        end
        A = [A;];
    end
end
A
%b. Create vector x of length 100, first entry is 1
X = [1]
xn = 1;
for k = 2:100
    X = [X, (3 * xn) / (xn^2 + 1)];
    xn = (3 * xn) / (xn^2 + 1);
end
X

%4. Output functions in a table with given x inputs
x = [1, 0.1, 0.01, 0.001, 0.0001]
%y1 = sin(x)/x
%y2 = abs(y1 - 1)
fprintf('====================================================\n')
fprintf('\tx\t\t\t\tf(x)\t\t\te(x)\n')
for i = 1:5
    fprintf('%12.6f\t%12.6f\t%12.6f\n', x(i), sin(x(i))/x(i), abs((sin(x(i))/x(i)) - 1))
    fprintf('====================================================\n')
end