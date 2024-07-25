%4. Create the Hilbert matrix, n x n
%a.
n = 4    % The size of the Hilbert matrix, order 4
H = zeros(n);   % Initialize the Hilbert matrix to be full of zeros
for col = 1:n
    for row = 1:n
        H(row, col) = 1 / (row + col - 1);
    end
end
fprintf('Hilbert Matrix:\n');
H

%Create the b vector, should have row size n, add up row sum and put for
%that row in b
%b = zeros(n)
b = [0;0;0;0];
rowsum = 0;
for r = 1:n
    for c = 1:n
        rowsum = rowsum + H(r, c);
    end
    %Update the entry in b for this row
    b(r, 1) = rowsum;
    rowsum = 0;  % Reset the rowsum once you get to a new row
end
fprintf('b Vector:\n');
b

%b.
%Create array containers for the table
tn = [5; 10; 15; 20]
txn = ["Separate Screenshot"; "Separate Screenshot"; "Separate Screenshot"; "Separate Screenshot"]
te = [0; 0; 0; 0]
tr = [0; 0; 0; 0]
tk = [0; 0; 0; 0]

% Create the Hilbert matrix, n x n
for n_index = 5:5:20   % Run for n = 5, 10, 15, 20
    Hn = zeros(n_index);   % Initialize the Hilbert matrix to be full of zeros
    for col = 1:n_index
        for row = 1:n_index
            Hn(row, col) = 1 / (row + col - 1);
        end
    end
    fprintf('Hilbert Matrix for n = %d\n', n_index);
    Hn

    %Create the b vector, should have row size n, add up row sum and put for
    %that row in b
    %b = zeros(n)
    bn = [0];
    x = [1];    % The vector for the actual answer
    for i = 1:n_index - 1
        bn = [bn;0];
        x = [x;1];
    end
    rowsum = 0;  % Initialize rowsum
    for r = 1:n_index
        for c = 1:n_index
         rowsum = rowsum + Hn(r, c);
        end
        %Update the entry in b for this row
        bn(r, 1) = rowsum;
        rowsum = 0;  % Reset the rowsum once you get to a new row
    end
    fprintf('b Vector for n = %d\n', n_index);
    bn
    
    %Solve the linear system
    [Ln,Un] = lu(Hn); %% This finds the LU decomp of Hn, L for lower triangular, U for upper
    xn = Un\(Ln\bn) %% This solves for the solution xn using the decomp

    c = zeros(n_index, 1);   % n x 1 vector

    if n_index == 5
        %txn(2, 2) = mat2cell(xn, 5, 1)
        
        c = x - xn
        te(1, 1) = norm(c)
        
        c = bn - (Hn * xn)
        tr(1, 1) = norm(c)
        
        tk(1, 1) = cond(Hn, Inf) % Return the condition number of Hn for the infinity norm
    elseif n_index == 10
        %txn(3, 2) = mat2cell(xn, 5, 1)
        
        c = x - xn
        te(2, 1) = norm(c)
        
        c = bn - (Hn * xn)
        tr(2, 1) = norm(c)
        
        tk(2, 1) = cond(Hn, Inf)
    elseif n_index == 15
        %txn(4, 2) = mat2cell(xn, 5, 1)
        
        c = x - xn
        te(3, 1) = norm(c)
        
        c = bn - (Hn * xn)
        tr(3, 1) = norm(c)
        
        tk(3, 1) = cond(Hn, Inf)
    elseif n_index == 20
        %txn(5, 2) = mat2cell(xn, 5, 1)
        
        c = x - xn
        te(4, 1) = norm(c)
        
        c = bn - (Hn * xn)
        tr(4, 1) = norm(c)
        
        tk(4, 1) = cond(Hn, Inf)
    end
end

% Create the table to display everything
t = table(tn, txn, te, tr, tk)


%Function for subtracting two vectors
%function c = subtract(a, b)
 %   c = [];
  %  for i = 1:length(a)
   %     c[] = a(1, 0) - b(1, 0)
   % end
%end

%Function for taking the infinity norm of vector
function max = norm(v)
    max = -Inf;
    for i = 1:length(v) % Traverse through all of the rows and find max element
        if abs(v(i, 1)) >= max
            max = abs(v(i, 1));
        end
    end
end