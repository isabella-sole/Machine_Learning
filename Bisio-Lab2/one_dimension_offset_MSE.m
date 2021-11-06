%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

function J_MSE = one_dimension_offset_MSE(dataset, w1, w0, my_plot)
% Compute the MSE on the given dataset for a given model
[dimension,~] = size(dataset(:,1));
y = w1 * dataset(:,4) + w0;
J_MSE = 0 ;


for i = 1: dimension
    J_MSE = J_MSE + (dataset(i, 1) - y(i) ) ^2 ;  % Column 1: target
end

J_MSE = J_MSE / dimension;


if (my_plot)
    disp(['The one dimensional mse with a dataset of #', num2str(dimension),' samples is:',num2str(J_MSE)]);
end

end