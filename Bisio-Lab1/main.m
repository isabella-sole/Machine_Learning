%% Machine Learning: Assignment 1
% Isabella-Sole Bisio

clear all 
close all
clc

%% Task 1: Data preprocessing 
load('weather.mat'); % Load the dataset
dataset = table2array(weather); 
[n, d] = size(dataset);

% Create training set and data set
index = randperm(n); % Build a vector of indexes with random number between 1 and n=14 
m = 10; % Desired dimension of the training set
trainingset = dataset(index(1:m), :); % Build the dataset with 10 random dataset's rows and all the coloumns
testset = dataset(index(m+1:end), 1:(d-1)); % Build the testset with the 4 remainig dataset's rows and d-1 coloumns
target = dataset(index(m+1:end), d); 



%% Task 2: Build a naive Bayes classifier
[classification, errorrate] = nbc(trainingset, testset, target);

% Display results
for i=1:(n-m)
   fprintf('The prediction is %d, the corresponding target is %d\n', classification(i), target(i));
end
fprintf('The overall error rate is: %f\n', errorrate);

%% Task 3: Improve the classifier with Laplace (additive) smoothing
% Pass the information about the number of levels to both training and test set 
value_max = zeros(d,1); % Number of maximum value for each feature
for i=1:d
    value_max(i) = max(dataset(:,i));
end
trainingset_improved = [value_max'; trainingset];
testset_improved = [value_max(1:d-1)'; testset];

% Naive Bayes classifier with Laplace smoothing
[classification_smoothed, errorrate_smoothed] = nbcSmoothed(trainingset_improved, testset_improved, target);

% Display results
for i=1:(n-m)
   fprintf('The prediction with the Laplace smoothing is is %d and the corresponding target is %d\n', classification_smoothed(i), target(i));
end
fprintf('The overall error rate with the Laplace smoothing is: %f\n', errorrate_smoothed);