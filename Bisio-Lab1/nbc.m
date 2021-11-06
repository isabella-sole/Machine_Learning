%% Naive Bayes Classifier

function [classification, errorrate] = nbc(trainingset , testset, target)
  
      % Check that the number of input is correct
      if nargin <2
          disp('WARNING: not enough input.\n');
          return 
      end
    
    [n, d] = size(trainingset); %get the dimension of training set
    [m, c] = size(testset); %get the dimension of test set
    
    % Check coloumns' number
    %if (c < d)
    if (d ~= c+1) 
        disp('WARNING Set size is incorrect.\n');
        return 
    end
    
    % Check the training set entries 
    for i=1:n
        for j=1:d
            if (trainingset (i,j) < 1)
                disp('WARNING incorrect trainig set values.\n');
                return
            end
        end
    end
    
    % Check the test set entries
    for i=1:m
        for j=1:c
            if (testset(i,j) < 1)
                disp('WARNING incorrect test set values.\n');
                return
            end
        end
    end
    
    % Use the training set to train my Naive Bayes Classifier
   
    % First step: compute marginal probabilty of X and a priori probability of H
    % Initialise zero matrices for the following requests
    maximum_value = zeros(d,1); 
    times_event_x = zeros(n,d);
    marginal_prob_x = zeros(n,d);
    for i=1:d  % Fill the zero matrix
       maximum_value(i) = max(trainingset (:,i)); % Maximum value of each feature
       for j=1:maximum_value(i)
          times_event_x(j,i) = sum((trainingset (:,i) == j));
          marginal_prob_x(j,i) = times_event_x(j,i)/n; % Last column of this matrix contains the priori probability of H
       end    
    end
    
    n_classes = maximum_value(d); % Number of classes
    
    % Second step
    % Computing the likelihood
    likelihood = zeros(max(maximum_value),d-1,n_classes); % Initialise a zero matrix
    % Fill the zero matrix
    for i=1:d-1 % For each feature
       for j=1:n % For each observation
           for k=1:maximum_value(i) % For each value
               for l=1:n_classes % For each class
                   if (trainingset (j,i) == k && trainingset (j,d) == l)
                       likelihood(k,i,l) = likelihood(k,i,l) + 1;
                   end
               end
           end
       end
    end
    for i=1:d-1
        for j=1:max(maximum_value)
            for k=1:n_classes
                likelihood(j,i,k) = likelihood(j,i,k)/times_event_x(k,d);
            end
        end
    end
    
    % Third step: now that the training is ended I can classify my test set using the inferred rule
    % Compute a posteriori probability of H
    posteriori_prob = ones(m,n_classes); 
    prob_feature = zeros(max(maximum_value),c ,n_classes);
    partition = zeros(m,n_classes);
    classification = zeros(m,1);
    for k=1:n_classes % For each class
        for j=1:m % For each observation of the test set
            for i=1:c % For each feature
                value_testset = testset(j,i);
                if (value_testset > maximum_value(i))
                    fprintf('WARNING: it is not possible to classify the %d test due to some missing values in the training set.\n', j);
                    return
                else
                    if (isnan(value_testset))
                    else
                        prob_feature(j,i,k) = likelihood(value_testset,i,k);
                        posteriori_prob(j,k) = posteriori_prob(j,k) * prob_feature(j,i,k);
                    end
                end
            end
        end
        posteriori_prob(:,k) = posteriori_prob(:,k) * marginal_prob_x(k,d);
    end
    % Divide for the partition function
    for i=1:m
        for k=1:n_classes
            partition(i) = partition(i) + posteriori_prob(i,k);
        end
        posteriori_prob(i,:) = posteriori_prob(i,:)/partition(i);
    end
    
    % Find the maximum value of the a posteriori probability for each row of the test set
    for i=1:m
        for k=1:n_classes
            [t, classification(i,1)] = max(posteriori_prob(i,:));
        end
    end
    
    % Compute the error rate
    if nargin>2
        errorrate = (sum(classification ~= target))/m;
    end

end