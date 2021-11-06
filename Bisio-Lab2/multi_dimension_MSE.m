%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

function J_MSE = multi_dimension_MSE(dataset, w1, w0, my_plot)
% Compute the MSE on the given dataset for a given model
[dimension,~] = size(dataset(:,1));
% Build observation vector
observation_vector = [ dataset(:,2), dataset(:,3), dataset(:,4) ];
y = observation_vector* w1;
% The computation of MSE can also be done with "immse" formula, not only with evaluaations of the others functions
t = dataset(:, 1);
J_MSE = immse(t, y); 

if (my_plot)
    disp(['The one dimensional mse with a dataset of #', num2str(dimension),' samples is:',num2str(J_MSE)]);
end

end