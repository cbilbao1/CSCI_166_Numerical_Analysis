%1. Create a table with the specified values of n, p, and error
%Create range n, UNUSED
n = [0, 1, 2, 3, 4, 5, 6]
   

%3.
%c.
%Bisection method
%Input: function, endpoints
a = 4;
b = 6;
%eps = 0.001;    %REDACTED: Using the epsilon value as a stopping criteria
m = (a + b) ./ 2;    %Initialize the first midpoint
fprintf('\nBisection method starting midpoint is %f\n', m);
%while abs(b - a) > eps %REDACTED: If the interval reaches some epsilon, stop
for i = 1:12 %We will use an max iteration as stopping criteria
    if (f(a) * f(m)) < 0    %Sign f(m) != sign f(a)
        b=m;
    else    %Sign f(m) = sign f(a)
        a=m;
    end
    m = (a + b) ./ 2;
end
fprintf('\nThe value of midpoint after bisection method is %f\n', m);

%False position method
%Input: function, endpoints
a = 4;
b = 6;
m = b - ((f(b) .* (b - a)) ./ (f(b) - f(a)));    %Initialize the first midpoint using formula
fprintf('\nFalse position method starting midpoint is %f\n', m);
for i = 1:12 %We will use an max iteration as stopping criteria
    if (f(a) * f(m)) < 0    %Sign f(m) != sign f(a)
        b=m;
    else    %Sign f(m) = sign f(a)
        a=m;
    end
    m = (a + b) ./ 2;
end
fprintf('\nThe value of midpoint after false position is %f\n', m);

%e. Compute midpoint and error
%Create the first table for pn
sz = [12 3]; % 12 n's and 3 columns
varTypes = ["double","double","double"];
varNames = ["Iteration n","Bisection","False Position"];
t2 = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
t3 = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

    abis = 4;
    bbis = 6;
    mbis = (abis + bbis) ./ 2;
    aFP = 4;
    bFP = 6;
    mFP = bFP - ((f(bFP) .* (bFP - aFP)) ./ (f(bFP) - f(aFP)));
for i = 1:12
    %Bisection
    if (f(abis) * f(mbis)) < 0    %Sign f(m) != sign f(a)
        bbis=mbis;
    else    %Sign f(m) = sign f(a)
        abis=mbis;
    end
    if (f(abis) * f(mbis)) < 0    %Sign f(m) != sign f(a)
        bbis=mbis;
    else    %Sign f(m) = sign f(a)
        abis=mbis;
    end
    mbis = (abis + bbis) ./ 2

    %False position
    if (f(aFP) * f(mFP)) < 0    %Sign f(m) != sign f(a)
        bFP=mFP;
    else    %Sign f(m) = sign f(a)
        aFP=mFP;
    end
    if (f(aFP) * f(mFP)) < 0    %Sign f(m) != sign f(a)
        bFP=mFP;
    else    %Sign f(m) = sign f(a)
        aFP=mFP;
    end
    mFP = (aFP + bFP) ./ 2

    %Modify each row, row corresponds to n
    t2{i, 1} = i;  % Set row i, column 1 to n
    t2{i, 2} = mbis;
    t2{i, 3} = mFP;
    %t2(i,:) = {1,1,1};

    pReal = 4.9171859252871323  %Given p value
    t3{i, 1} = i;
    t3{i, 2} = abs(mbis - pReal);
    t3{i, 3} = abs(mFP - pReal);
end
t2
t3
%f. Plot the log of the error of both of the methods
%x = linspace(0, pi);
x1 = linspace(4, 6, 12)  %Interval, spaced 1000 units evenly

%Interval 1
figure(1)
subplot(3,1,1)
plot(x1, log(t3{:,"Bisection"}))    %Plot Bisection
grid
subplot(3,1,2)
plot(x1, log(t3{:,"False Position"}))    %Plot False Position
grid

%1.
%Create the table for the first p formula
sz = [7 6]; % 7 n's and 6 columns
varTypes = ["double","double","double"];
varNames = ["n","pn","en","en/en-1","en/en-1^2","en/en-1^3"];
t = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames)

%Start at p0 = 1
pn = 1
%Assume that e(-1) = 1
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

for i = 0:6
    %Modify each row, row corresponds to n
    if i ~= 0
        t(i,:) = {i,p(pn),e(pn),e(pn)};
    else
    end

    %Update pn
    pn = p(pn)
end



%FUNCTION DEFINITIONS
%1.
%Define a function p for calculating the next pn+1 using pn, input is pn, output is
%pnext
function pnext = p(pnow)
    pnext = 0.5 .* (pnow + (5 ./ pnow))
end
%Define a function e for calculating the absolute error at each step
function error = e(pnow)
    error = abs(pnow - sqrt(5))
end

%3.
%c.
function y = f(x)
    y = log(x) - sin(x);
end


