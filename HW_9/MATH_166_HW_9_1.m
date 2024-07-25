%1.
%c) Calculate the integral on interval [0, 1] for x*e^(-x^2) using
%Richardson extrapolation
h = 1
r2 = R2(h)

%Function for calculating R2
function result2 = R2(h)
    result2 = (81*R1(h/3) - R1(h)) / 640;
end

%Function for calculating R1
function result1 = R1(h)
    result1 = (9*T(h/3) - T(h)) / 8;
end

%Function for calculating the Trapezoidal Rule, which takes in an integer
%h, which is the spacing
function trap = T(h)
    trap = 0;
    w = 0;   % Variable for the weight, wi
    %h = (b - a) / n -> n = 1 / h
    n = 1 / h;
    
    %Evenly split the interval into n trapezoids, find sample points this
    %way
    samplePoints = linspace(0, 1, n);
    
    for i = 0:length(samplePoints) - 1
        %Calculate Trapezoidal Rule, done in a piecewise fashion
        %At the edges, our weight should be h/2
        %Summation from 0 to n: wi*f(xi), where xi is a sample point
        if i == 0 | i == n   % If we are at the bounds a or b, weight is h/2
            w = h/2;
        else    % Otherwise, weight is just h
            w = h;
        end
        %f(xi) = xi*exp^(-xi^2)
        trap = trap + w * ( samplePoints(i+1)*exp(-(samplePoints(i+1))^2) );
    end
end