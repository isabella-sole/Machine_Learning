%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

function [w, w0] = linear_regression_multi_dimensional(dataset, my_plot)
% Build observation vector
obs_vector = [ dataset(:,2), dataset(:,3), dataset(:,4) ];
% Build target vector -> mpg column 1
target_vector = dataset(:,1);
% Compute slope
w0 = 0;
w = pinv(obs_vector' * obs_vector) * obs_vector' * target_vector;
% Estimatiom of the target's table
prediction = obs_vector*w ;

if my_plot
    f = figure;
    data = [obs_vector target_vector prediction];
    colNames = {'disp', 'hp', 'weight', 'dataset mpg', 'Predicted mpg' };
    uitable(f, 'Data', data, 'ColumnName', colNames, 'Position', [0 0 440 420]);
end

end