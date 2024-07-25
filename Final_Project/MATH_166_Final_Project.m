%2. Code QR algorithm with Wilkinson's shift
n = 3;   % Set the number of eigenvalues/vectors we will find, corresponds to dimension of matrix
sum = 0; % Initialize a sigma sum variable that calculates the accumulation of the shifts
last = n; % the stopping criteria, n - last is the number of eigenvalues that have been determined
i = 1;   % Variable for the number of iterations, will not be the stopping criteria
%The original matrix for our problem
A = [2, -1, 0;
     -1, 6, 1;
     0, 1, -3]
Ai = zeros(3,3); % Our iterative version of matrix A
Ai = A;
I = eye(n);    % Identity matrix
eigenvals = zeros(n,1);    % A resultant vector of the eigenvalues of A
index = 1;    % Index for eigenvalue
TOL = 5 * 10^(-14);    % Let our tolerance be 5 * 10^-14

%Repeat the QR algorithm until we don't have any eigenvalues left to
%calculate
%????????while last <= 1
while last ~= 1
    %The 2 x 2 vector for finding shift
    B = zeros(2,2);  % Initialize as a 2 x 2 matrix with zeros
    %Now set the values of the matrix
    B(1,1) = A(2,2);
    B(1,2) = A(2,3); % Should be identical
    B(2,1) = A(3,2); % Should be identical
    B(2,2) = A(3,3);
    shift = 0;   % Variable for shift
    shift = computeWilkinson(Ai, B); %Compute the Wilkinson shift

    %Apply the shift to sum
    sum = sum + shift;

    %Our iterative matrix with the shift
    Ai = Ai - shift*I;

    %Factor Ai into Qi*Ri
    [Ai, ci, si] = factorize(Ai)

    %Compute the Ri*Qi product to get the next iterative matrix A(i+1)
    Ai = rqProduct(Ai, ci, si)

    %Fix the parallel elements to match
    Ai(1,2) = Ai(2,1);
    Ai(2,3) = Ai(3,2);

    %If one of the b values reaches some tolerance (technically we want it
    %to converge to 0, but we will use TOL), then accept the current
    %diagonal element as an eigenvalue of A
    if (abs(Ai(last,last-1)) < TOL)   % Check b(last-1) converged to 0
        %Then that last-1th diagonal element plus the sum is an eigenvalue
        eigenvals(index) = Ai(last,last) + sum;
        index = index + 1;

        last = last - 1;    % Decrement last, reduce number of eigenvalues left
    end
end

%a1 + sum is another eigenvalue
eigenvals(index) = Ai(1,1) + sum;

%Final Result
eigenvals

%Function for computing the RQ product, takes in iterative matrix Ai and
%the cosine and sine values
function RQ = rqProduct(A_matrix, c, s)
    RQ = A_matrix; % RQ product, should be a matrix
    n = length(A_matrix);
    
    %We are changing the current diagonal element aj, the element under it
    %bj, and the next diagonal element a(j+1)
    for j = 1:n-1
        %Overwrite aj with aj * cj + bj * sj
        RQ(j,j) = RQ(j,j) * c(j,1) + RQ(j+1,j) * s(j,1);

        %Overwrite bj with a(j+1) * sj
        RQ(j+1,j) = RQ(j+1,j+1) * s(j,1);

        %Overwrite a(j+1) with a(j+1) * cj
        RQ(j+1,j+1) = RQ(j+1,j+1) * c(j,1);
    end
end

%Function for factorizing a matrix A by finding the constants associated
%with the RQ product
function [A_factorized, c, s] = factorize(A_matrix)
    A_factorized = A_matrix; % Factored matrix
    n = length(A_matrix);    % Number of diagonal elements
    c = zeros(n-1,1); % Array of cosine elements
    s = zeros(n-1,1); % Array of sine elements
    t = A_matrix(1,2);   % Save b1 in a temporary variable t
   
    %Run for n - 1 because you want to clear the entries above/below each
    % diagonal element, where the nth diagonal element has nothing under it
    for j = 1:n-1
        %aj is the jth diagonal element
        r = sqrt(A_factorized(j,j)^2 + t^2);   % calculate r, the denominator
        
        %Compute cj, the cosine element in the rotational matrix R
        c(j,1) = A_factorized(j,j) / r;
        %Compute sj, the sine element in the rotational matrix R
        s(j,1) = t / r;

        %Overwite our current jth diagonal element aj with r
        A_factorized(j,j) = r;
        
        %Save the current b in t temporarily for the next iteration
        t = A_factorized(j+1,j); % bj should be the element under our jth diagonal element
        
        %Overwrite bj with t * cj + a(j+1) * sj
        A_factorized(j+1,j) = t * c(j,1) + A_factorized(j+1,j+1) * s(j,1);

        %Overwrite a(j+1) with -t * sj + a(j+1) * cj
        A_factorized(j+1,j+1) = -t * s(j,1) + A_factorized(j+1,j+1) * c(j,1);

        %We are going to check the b element, make sure we are not at the
        %n-1th diagonal element so that there is another b to check ahead
        if(j ~= n-1)
            %Save the next b element b(j+1) in our temporary variable t
            t = A_factorized(j+2,j+1);

            %Overwrite b(j+1) with t * cj
            A_factorized(j+2,j+1) = t * c(j,1);
        end
    end
end

%Function for finding the Wilkinson shift, takes in original matrix and the
%2 x 2 matrix
function s = computeWilkinson(A_matrix, B_matrix)
    s = 0;   % Variable for shift
    
    v = eig(B_matrix); %DO THIS YOURSELF?: -------------------------------------Returns a vector of eigenvalues
    
    % Set the shift to be the eigenvalue of B closest to an
    s = findClosestEigenval(A_matrix, v);
end

%Function for finding the closest eigenvalue to an, takes in original
%matrix and the vector of eigenvalues
function closest = findClosestEigenval(A_matrix, eigenvalues)
    closest = eigenvalues(1,1); % Default value
    difference = abs(A_matrix(3,3) - eigenvalues(1,1)); % Variable for difference, closest value should have smallest difference from an
    for i = 2:length(eigenvalues);
        if (abs(A_matrix(3,3) - eigenvalues(i,1)) < difference)   % If our current eigenvalue is closer to an, choose it
            closest = eigenvalues(i,1);
        end
    end
end

