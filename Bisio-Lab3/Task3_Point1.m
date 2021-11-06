%% Task3_Point1
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
dist = pdist2(test_set, training_tot(:, 1:(end-1)), 'Euclidean');
p = zeros(n, 10);



for i=1:10
    p(:,i) = [training_tot(:, end) == i];
end
classification = zeros(m, max(size(k)));

for y=1:10
    
    for i=1:max(size(k))
        
        
        k_sorted = zeros(m, k(i));
        index = zeros(m, k(i));
        
        
        for j=1:m
            [k_sorted(j, :), index(j, :)] = mink(dist(j,:), k(i));
        end
        
        class = zeros(m, k(i));
        for l=1:k(i)
            for j=1:m
                class(j, l) = p(index(j, l), y);
            end
        end
        
        for l=1:m
            classification(l,i) = mode(class(l, :));
        end
        
        
        % Error rate evaluation
        error_rate(i) = (sum(classification(:,i) ~= (test_labels==y)))/m;
    end
    result = [k' error_rate'];
    name = 'result_k' + string(k(1)) + '-' + string(k(end)) + '_digit' + string(y) + '.mat';
    save(name, 'result'); % Saving results
end


