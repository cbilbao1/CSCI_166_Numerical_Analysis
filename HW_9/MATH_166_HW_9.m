%2.
%a) 5 point Gaussian Quadrature, find sample points and weights -> 2(5) - 1 = 10, highest order of x^9
n = 5;

%y = x^{5} - 10/9 x^{3} + 5/21 x -> 5 Roots: +/- .906, +/- .538, 0
%Need to find 5 unknowns (5 weights), which means we use 5 equations!
p = [1 0 -10/9 0 5/21 0];
r = roots(p)

%Find the weights
weightArr = findWeights(r)  % r is a row vector with all the sample points

%b) Now that we found the sample points and weights, integrate on [-1, 1]
%theIntegral = 0
%for i = 1:5
%    %This is the integral using Gaussian Quadrature, where f is your chosen
%    %function
%    %summation from i = 1 to 5: wi * f(xi)
%    %Remember, r is a row vector of the sample points (roots)
%    theIntegral = theIntegral + weightArr(i)*f(r(i))
%end

%function y = f(x)
%    y = ....
%end

%c) Integrate on [-1, 1] for f(x) = x^8 + 42*x^7
theIntegral = 0;
for i = 1:5
    %This is the integral using Gaussian Quadrature, where f is your chosen
    %function
    %summation from i = 1 to 5: wi * f(xi)
    theIntegral = theIntegral + weightArr(i)*f(r(i));
end
theIntegral

%d) Integrate on [-1, 1] for f(x) = x^10 + 42*x^7
theIntegral = 0;
for i = 1:5
    %This is the integral using Gaussian Quadrature, where f is your chosen
    %function
    %summation from i = 1 to 5: wi * f(xi)
    theIntegral = theIntegral + weightArr(i)*f2(r(i));
end
theIntegral
%No, you don't get the exact answer because the polynomial is order 10 and
%is higher than order 2n - 1 -> 2*5 - 1 = 9

%e) Integrate on [0, 1] for f(x) = x*e^(-x^2), need to use u substitution
theIntegral = 0;
for i = 1:5
    %This is the integral using Gaussian Quadrature, where f is your chosen
    %function
    %summation from i = 1 to 5: wi * f(xi)
    theIntegral = theIntegral + weightArr(i)*f3(r(i));
end
theIntegral
%Compared to (1) the answer is much more accurate. I picked the wrong u,
%but checked with the class notes example and the algorithm works

function y = f3(x)
    u = -x^2;
    y = exp(u);
    y = 0.5 * y
end

function y = f2(x)
    y = x^10 + 42*x^7
end

function y = f(x)
    y = x^8 + 42*x^7
end

%Function for finding the weights given the sample points (roots) as a row
%vector
function weights = findWeights(samplePoints)
    weights = [0; 0; 0; 0; 0]

    %2(5) - 1 = 10, highest order of x^9
    %I will be using functions 1, x, x^2, x^3, x^4
    %1
    rowVec1 = [1, 1, 1, 1, 1]
    rowVecX = [0, 0, 0, 0, 0];
    rowVecX2 = [0, 0, 0, 0, 0];
    rowVecX3 = [0, 0, 0, 0, 0];
    rowVecX4 = [0, 0, 0, 0, 0];
    
    for i = 1:5
    %x
        rowVecX(i) = samplePoints(i);
    rowVecX;

    %x^2
        rowVecX2(i) = (samplePoints(i))^2;
    rowVecX2;

    %x^3
        rowVecX3(i) = (samplePoints(i))^3;
    rowVecX3;

    %x^4
        rowVecX4(i) = (samplePoints(i))^4;
    rowVecX4;
    end

    %Solve the system A(weights) = b
    A = [rowVec1; rowVecX; rowVecX2; rowVecX3; rowVecX4]

    %The constants vector is a collection of all of the integrals of each
    %function on interval [-1, 1] i.e. S 1 dx, S x dx, S x^2 dx, etc..
    b = [2; 0; 2/3; 0; 2/5]

    %Solve the system, unfortunately will take the inverse of A
    %Results in a column vector with all the weights
    weights = inv(A)*b
end