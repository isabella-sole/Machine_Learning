%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

close all
clear all
clc

%% Task 1: Get data
%% Import datasets
dataset1 = readtable("mtcarsdata-4features.csv");
carList = dataset1 {:,1};
dataset1 = dataset1 {:,2:end};
dataset2 = load("turkish-se-SP500vsMSCI.csv");

%% Task 2: Fit a linear regression model
%% 1.One-dimensional problem without intercept on the Turkish stock exchange data
linear_regression(dataset2,1);


%% 2.Compare graphically the solution obtained on different random subsets (10%) of the whole data set
graphs_result_analisys(dataset2);


%% 3.One-dimensional problem with intercept on the Motor Trends car data, using columns mpg and weight
linear_regression_offset(dataset1, 1);


%% 4.Multi-dimensional problem on the complete MTcars data, using all four columns (predict mpg with the other three columns)
linear_regression_multi_dimensional(dataset1,1);


%% Task 3: Test regression model
%  Re-run 1,3 and 4 from task 2 using only 5% of the data.
%  Compute the objective (mean square error) on the training data
%  Compute the objective of the same models on the remaining 95% of the data.
%  Repeat for different training-test random splits
iterations = 100000;
%percentage1 = 0.05; percentage2 = 0.95; % required percentage
percentage1 = 0.125; percentage2 = 0.875; % try also this percentage, around 10%, in order to not obtain a NaN

%% Evaluate mean square error in one-dimensional problem without intercept Turkish data
[MSE_five, MSE_ninetyfive] = mean_square_error(iterations, dataset2, @one_dimension_MSE,@linear_regression, percentage1, percentage2);
disp('Mean square error in one-dimensional problem without intercept Turkish data using only 5% of the samples');
disp(['Using an avarage of ',num2str(iterations),'iterations']);
disp(['One dimensional MSE computed on the train set is:',num2str(MSE_five)]);
disp(['One dimensional MSE computed on the test set made up of the remaining data is:',num2str(MSE_ninetyfive)]);
title('One-dimensional problem without intercept');
%% Evaluate mean square error in one-dimensional problem with intercept on the Motor Trends car data, using columns mpg and weight
[MSE_five, MSE_ninetyfive] = mean_square_error(iterations, dataset1, @one_dimension_offset_MSE,@linear_regression_offset, percentage1, percentage2);
disp('Mean square error in one-dimensional problem with intercept on the Motor Trends car data with a train set of 5% of the samples');
disp(['Using an avarage of ',num2str(iterations),'iterations']);
disp(['One dimensional MSE computed on the train set is:',num2str(MSE_five)]);
disp(['One dimensional MSE computed on the test set made up of the remaining data is:',num2str(MSE_ninetyfive)]);
title('One-dimensional problem with intercept');

%% Evaluate mean square error in multi-dimensional problem on the full Motor Trends car data
[MSE_five, MSE_ninetyfive] = mean_square_error(iterations, dataset1, @multi_dimension_MSE,@linear_regression_multi_dimensional, percentage1, percentage2);
disp('Mean square error in multi-dimensional problem on the complete Motor Trends car data with a train set of 5% of the samples');
disp(['Using an avarage of ',num2str(iterations),'iterations']);
disp(['Multi dimensional MSE computed on the train set is:',num2str(MSE_five)]);
disp(['Multi dimensional MSE computed on the test set made up of the remaining data is:',num2str(MSE_ninetyfive)]);
title('Multi-dimensional problem');
