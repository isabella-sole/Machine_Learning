%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

function [w, w0] = linear_regression(dataset, my_plot)
% Compute the model
numerator = 0;
denominator = 0;
[dimension,~] = size(dataset(:,1));

for i= 1:dimension
    numerator = numerator +  dataset(i,1) * dataset(i,2);
    denominator = denominator + (dataset(i,1))^2;
end

w0 = 0;
w = numerator / denominator ;
 
if my_plot
    figure;
    plot (dataset(:,1), dataset(:,2), 'rx'); % Plot the dataset's points
    hold on;
    plot (dataset(:,1), w * dataset(:,1), 'b-' , 'Linewidth', 2); % Plot a line with this shape: y = slope * x 
    title('One-dimensional problem without intercept on the Turkish stock exchange data');
end

end