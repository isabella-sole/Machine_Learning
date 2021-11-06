%% Machine Learning - Lab4: Neural networks
%  Isabella-Sole Bisio


close all
clear all
clc


%% Load The Data

% Generate a path 

addpath('DATASET');
addpath('MNIST');


% My Datasets

XOR_dataset = importdata('XOR.txt');
IRIS_dataset = importdata('iris-2class.txt');


[X_m,T_m] = loadMNIST(0);
[T_m] = binary(T_m,1);


MNIST_dataset = [X_m T_m];
MNIST_dataset = MNIST_dataset(1:150, :);


%% MNIST dataset
% Setting up the Datasets /w k=5

index = randperm(size(IRIS_dataset,1));

IRIS_dataset = IRIS_dataset(index(1:size(IRIS_dataset,1)),:);


% My Values 

hP = 0.8;
hA = 0.001;
k = 5;

[training_set, test_set, C1, iter] = perceptron(IRIS_dataset, hP, k);

[training_set2, test_set2, C2, iter2] = adaline(IRIS_dataset, hA, k);


% For MNIST dataset
% [training_set_MNIST, test_set_MNIST, C1_MNIST, iter_MNIST]= perceptron(MNIST_dataset, hP, k);

% [training_set2_MNIST, test_set2_MNIST, C2_MNIST, iter2_MNIST] = adaline(MNIST_dataset, hA, k);

% Now I change my k to 2
k = 2;


for i=1:5
    
    
    hP = 0.9;
    hA = 0.009;
    
    
    [training_set_XOR, test_set_XOR, C_XOR, iter_XOR] = perceptron(XOR_dataset, hP, k);
    [training_set_XOR2, test_set_XOR2, C_XOR2 , iter_XOR2 ] = adaline(XOR_dataset, hA, k);
    
    
    C_XOR_p{i} = C_XOR;
    C_XOR_a{i} = C_XOR2;
    
    
    hP = hP - 0.1;
    hA = hA - 0.001;
    
    
end


% Finding the quality parameters 

[accuracy, error_rate ,sensivity, specifity] = quality_indices(C_XOR_p, C_XOR_a);






