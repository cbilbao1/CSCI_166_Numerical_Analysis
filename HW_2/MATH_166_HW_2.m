%5. Plot the function x - sin(x) and its reformulated Taylor Series function, from these three intervals
%x = linspace(0, pi);
x1 = linspace(-5 * 10.^(-5) , 5 * 10.^(-5) , 1000)  %Interval, spaced 1000 units evenly
x2 = linspace(-5 .* 10.^(-8) , 5 .* 10.^(-8) , 1000)
x3 = linspace(-4 , 4 , 1000)

y1 = x1 - sin(x1); %f(x), the original function
y2 = (x1.^3 ./ factorial(3)) - (x1.^5 ./ factorial(5));  %g(x), the reformulated function

y3 = x2 - sin(x2); %f(x), the original function
y4 = (x2.^3 ./ factorial(3)) - (x2.^5 ./ factorial(5));  %g(x), the reformulated function

y5 = x3 - sin(x3); %f(x), the original function
y6 = (x3.^3 ./ factorial(3)) - (x3.^5 ./ factorial(5));  %g(x), the reformulated function

%Interval 1
figure(1)
subplot(3,1,1)
plot(x1, y1)    %Plot f(x)
grid
subplot(3,1,2)
plot(x1, y2)    %Plot g(x)
grid

%Interval 2
figure(2)
subplot(3,1,1)
plot(x2, y3)    %Plot f(x)
grid
subplot(3,1,2)
plot(x2, y4)    %Plot g(x)
grid

%Interval 3
figure(3)
subplot(3,1,1)
plot(x3, y5)    %Plot f(x)
grid
subplot(3,1,2)
plot(x3, y6)    %Plot g(x)
grid




%--
%figure(1)
%plot (x1, y1)
%title('Figure 1');
%ylabel('y');
%xlabel('x');
%hold on
%plot (x1, x1)
%hold off
%--
%figure(2)
%subplot(3,1,1)
%plot(x, y1)
%grid
%subplot(3,1,2)
%plot(x, y2)
%grid
%subplot(3,1,3)
%plot(x, y3)
%grid