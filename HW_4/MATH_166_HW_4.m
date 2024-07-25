%1. Perform Newton's Method
%a.
x = 0;  %Starting value, po
nmax = 1000;    %Max number of iterations, stopping criteria
%eps = 1;  %Error bound eps, stopping criteria
xvals = x;    %Initialize array of iterations
evals = x;    %Initialize array of errors
n = 1;    %n, index variable for the current iteration

fprintf('\nn        |pn        |en        |en/en−1   |en/en−1^2 |en/en−1^3\n');
%while eps >= 1e-5 & n <= nmax %Set the stopping criteria
while n <= nmax %Set the stopping criteria
    %xnext = xcurr - f(xcurr) / f'(xcurr)
    y = x - (27*x.^4 + 162*x.^3 - 180*x.^2 + 62*x - 7) / (108*x.^3 + 486*x.^2 - 360*x + 62);  %Compute next iteration
    xvals = [xvals; y];    %Write next iteration in array
    epsPrev = eps;
    eps = abs(y - x);  %Compute error
    evals = [evals; abs(y - x)];   %Store error
    
    fprintf('\n%f | %f | %f | %f | %f | %f\n', n, x, eps, (eps/(epsPrev)), (eps/power(epsPrev, 2)), (eps/power(epsPrev, 3)) );
    
    x = y;  %Update x
    n = n + 1;  %Update n, the iteration
end %end of while-loop

xvals;
evals;

%b. Modified version of Newton's Method
x = 0;  %Starting value, po
nmax = 1000;    %Max number of iterations, stopping criteria
%eps = 1;  %Error bound eps, stopping criteria
xvals = x;    %Initialize array of iterations
evals = x;    %Initialize array of errors
n = 1;    %n, index variable for the current iteration

fprintf('\nn        |pn        |en        |en/en−1   |en/en−1^2 |en/en−1^3\n');
%while eps >= 1e-5 & n <= nmax %Set the stopping criteria
while n <= nmax %Set the stopping criteria
    %xnext = xcurr - 3*(f(xcurr) / f'(xcurr))
    y = x - 3*(27*x.^4 + 162*x.^3 - 180*x.^2 + 62*x - 7) / (108*x.^3 + 486*x.^2 - 360*x + 62);  %Compute next iteration
    xvals = [xvals; y];    %Write next iteration in array
    epsPrev = eps;
    eps = abs(y - x);  %Compute error
    evals = [evals; abs(y - x)];   %Store error
    
    fprintf('\n%f | %f | %f | %f | %f | %f\n', n, x, eps, (eps/(epsPrev)), (eps/power(epsPrev, 2)), (eps/power(epsPrev, 3)) );
    
    x = y;  %Update x
    n = n + 1;  %Update n, the iteration
end %end of while-loop

xvals;
evals;