%% Naive Bayes Classifier with Laplace smoothing

function [classification, error_rate] = nbcSmoothed(trainingset_improved, testset_improved, target)
    
    % Check that the number of input is correct
    if nargin <2
        disp('WARNING: not enough input.\n');
        return 
    end
    
    [n, d] = size(trainingset_improved);
    [m, c] = size(testset_improved);
    
    % Check coloumns' number
    if (d ~= c+1) 
        disp('WARNING Set size is incorrect.\n');
        return 
    end
    
    % Check the training set entries 
    for i=1:n
        for j=1:d
            if (trainingset_improved(i,j) < 1)
                disp('WARNING incorrect trainig set values.\n');
                return
            end
        end
    end
    
    % Check the test set entries
    for i=1:m
        for j=1:c
            if (testset_improved(i,j) < 1)
                disp('WARNING incorrect test set values.\n');
                return
            end
        end
    end
    
    % Use the training set to train my Naive Bayes Classifier
   
    % First step: compute marginal probabilty of X and a priori probability of H
    % Initialise zero matrices for the following requests
    value_max = zeros(d,1);
    number_occurrences_x = zeros(n-1,d);
    marginal_prob_x = zeros(n-1,d);
    for i=1:d
       value_max(i) = trainingset_improved(1,i); % Maximum value of each feature, the first row of the training set
       for j=1:value_max(i)
          number_occurrences_x(j,i) = sum((trainingset_improved(2:n,i) == j));
          marginal_prob_x(j,i) = number_occurrences_x(j,i)/(n-1); % In the last column of this matrix there is the a priori probability of H
       end    
    end
    
    n_classes = value_max(d); % Number of classes

    % Second step
    % Computing the likelihood
    likelihood = zeros(max(value_max),d-1,n_classes);
    a = 0.5; 
    for i=1:d-1 % For each feature
       for j=2:n % For each observation
           for k=1:value_max(i) % For each value
               for l=1:n_classes % For each class
                   if (trainingset_improved(j,i) == k && trainingset_improved(j,d) == l)
                       likelihood(k,i,l) = likelihood(k,i,l) + 1;
                   end
               end
           end
       end
    end
    for i=1:d-1
        for j=1:max(value_max)
            for k=1:n_classes
                likelihood(j,i,k) = (likelihood(j,i,k) + a)/(number_occurrences_x(k,d) + a*value_max(i));
            end
        end
    end

    % Third step: now that the training is ended I can classify my test set using the inferred rule
    % Compute a posteriori probability of H    
    posteriori_prob = ones(m-1,n_classes); 
    prob_feature = zeros(max(value_max),c,n_classes);
    partition = zeros(m-1,n_classes);
    classification = zeros(m-1,1);
    for k=1:n_classes % For each class
        for j=2:m % For each observation of the test set
            for i=1:c % For each feature
                value_testset = testset_improved(j,i);
                if (isnan(value_testset))
                else
                    prob_feature(j-1,i,k) = likelihood(value_testset,i,k);
                    posteriori_prob(j-1,k) = posteriori_prob(j-1,k) * prob_feature(j-1,i,k);
                end

            end
        end
        posteriori_prob(:,k) = posteriori_prob(:,k) * marginal_prob_x(k,d);
    end
    % Divide for the partition function
    for i=1:m-1
        for k=1:n_classes
            partition(i) = partition(i) + posteriori_prob(i,k);
        end
        posteriori_prob(i,:) = posteriori_prob(i,:)/partition(i);
    end
    
    % Find the maximum value of the a posteriori probability for each row of the test set
    for i=1:m-1
        for k=1:n_classes
            [t, classification(i,1)] = max(posteriori_prob(i,:));
        end
    end
    
    % Compute the error rate
    if nargin>2
        error_rate = (sum(classification ~= target))/(m-1);
    end

end