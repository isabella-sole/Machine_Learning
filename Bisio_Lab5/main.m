%% Machine Learning - Lab5: Autoencoders
%  Isabella-Sole Bisio

close all
clear 
clc


%% Task 1: Autoencoder
%% 1. Split the data into subsets of different classes

% Generate a path 

addpath('DATASET');
addpath('MNIST');


% Load The Data

[X, T]= loadMNIST(0); 


% Creation of my dataset

my_dataset = [ X, T ] ;
my_dataset = my_dataset(1:600,:);


% Split the subset

val_1 = 1; % digit 1
val_2 = 7; % digit 8
[subset_1, subset_2] = made_subsets(my_dataset,val_1,val_2);


%% 2. Create a training set with only 2 classes

% Create the training set using the two subsets just provided

my_trainingset = [subset_1 ; subset_2];


%% 3. Train an autoencoder on the new, reduced training set 

% Use the function suggested to train my autoencoder

my_autoencoder = trainAutoencoder(my_trainingset, 2);


%% 4. Encode the different classes using the encoder obtained

% Use the function suggested to encode my data

my_encoded_data = encode (my_autoencoder, my_trainingset);


%% 5. Plot the data using the "plotcl" function 

X = my_encoded_data;
Xlbl = [val_1 val_2]';


% Use the function suggested to plot the results

plotcl(X, Xlbl);

