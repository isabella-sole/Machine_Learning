%% Task3_Point2
% Isabella-Sole Bisio

clear;

%% Upload data
%%
% Uploading training and data sets

[training_set, training_labels] = loadMNIST(0);
[test_set, test_labels] = loadMNIST(1);
training_tot = [training_set training_labels];
[n, d] = size(training_tot);
[m, c] = size(test_set);

%% Classifiation of the uploaded data
%%

k = [1:201];

distance = pdist2(test_set, training_tott(:, 1:(end-1)), 'euclidean');

error_rate = zeros(max(size(k)), 1);
classification = zeros(m, max(size(k)));

for i=1:max(size(k))
    
    k_sorted = zeros(m, k(i));
    index = zeros(m, k(i));
    
    for j=1:m
        [k_sorted(j, :), index(j, :)] = mink(distance(j,:), k(i));
    end
    
    class = zeros(m, k(i));
    
    for l=1:k(i)
        for j=1:m
            class(j, l) = training_tot(index(j, l), end);
        end
    end
    
    for l=1:m
        classification(l,i) = mode(class(l, :));
    end
    
    % Error rate evaluation
    error_rate(i) = (sum(classification(:,i) ~= test_labels))/m;
    
    
    
end

result = [k' error_rate];
name = 'result_several_k' + string(k(1)) + '.mat';
save(name, 'result'); % Saving the results

accuracy = 1 - error_rate;



