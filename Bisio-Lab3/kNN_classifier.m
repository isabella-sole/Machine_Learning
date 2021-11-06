function [prediction ,error_rate] = kNN_classifier(traing_set, test_set, k, ground_truth)

% Check that there are enough input arguments

if nargin < 3
    
    error('Error on the number of input arguments')   
end


%% Preprocessing
%%

% Get dataset and check its dimensions

[row_test_set, col_test_set] = size(test_set);
[row_training_set, col_training_set] = size(traing_set);
if( (col_training_set -1) ~= col_test_set)
    
    disp("Error on the dimensions of the training and test sets");
end

% k cardinality

cardinality = row_training_set;
if ( k <= 0 || k > cardinality )
    
    disp("Error on the dimensions of k");
end

%% Test classification
%%

labels = zeros(k, row_test_set);

[~, labelIndex] = pdist2(traing_set(:,1:col_test_set), test_set, 'euclidean', 'Smallest', k);

% Assign relative label
for column = 1:row_test_set
    for label = 1:k
        labels(label,column) = traing_set(labelIndex(label,column),end);
    end
end
prediction = zeros(1,row_test_set);

% Evaluate prediction

for column = 1:row_test_set
    prediction(column) = mode(labels(:,column));
end

error_rate = 0 ;
if ( nargin == 4)
    
    % Evaluate error rate
    
    gerror_rate = (sum(prediction' ~= ground_truth)) / row_test_set;
    error_rate = error_rate * 100 ;
end


end