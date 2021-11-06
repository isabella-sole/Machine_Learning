%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio


function [MSE_five, MSE_ninetyfive] = mean_square_error(iterations, dataset, mean_square_error_case,regression_case, percentage1, percentage2)

dimension = size(dataset, 1);
MSE_five = 0 ; 
MSE_ninetyfive = 0;
% Set percentages
five = floor(dimension * percentage1);
ninetyfive = floor(dimension * percentage2);

% Evaluate the mean square error
for i = 1:iterations
    random_dataset = dataset(randperm(dimension), :);
    % Compute model on 5% of dataset
    [w1, w0] = regression_case(random_dataset(1:five,:), 0);      
    % Compute MSE on
    MSE_five = MSE_five + mean_square_error_case(random_dataset(1:five,:), w1, w0, 0); % 5% of dataset
    MSE_ninetyfive = MSE_ninetyfive + mean_square_error_case(random_dataset(five+1:end,:), w1, w0, 0); % 95% of dataset
end


MSE_five = MSE_five / iterations;
MSE_ninetyfive = MSE_ninetyfive / iterations;
% Table
col0 = {'Traing set' ; 'Test set' };
col1 = { (five/dimension)*100 ; (ninetyfive/dimension)*100};
col2 = { MSE_five ; MSE_ninetyfive};
fig = figure;
data = [ col0 col1 col2 ];
title_columns = {'Dataset' , 'Percentage' , 'MSE'};
uitable(fig, 'Data', data, 'ColumnName', title_columns, 'Position', [5 340 260 60]);


end