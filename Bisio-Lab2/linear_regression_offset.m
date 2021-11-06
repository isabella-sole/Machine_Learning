%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

function [w1, w0] = linear_regression_offset(dataset, my_plot)
% Compute the model 
numerator = 0;
denominator = 0;
xbar = 0;
tbar = 0;
[dimension,~] = size(dataset(:,1));


for i= 1:dimension
    xbar = xbar + dataset(i,4);  % Colum 4: observed feature is weight
    tbar = tbar + dataset(i,1);  % Column 1: target is mpg
end

% Divide by N dimension of dataset 
xbar = xbar/dimension;
tbar = tbar/dimension;


for i = 1:dimension
    numerator = numerator +  (dataset(i,4) - xbar) * (dataset(i,1) - tbar);
    denominator = denominator + (dataset(i,4) - xbar)^2;
end

w1 = numerator / denominator ;  % Slope
w0 = tbar - w1 * xbar ;   % Intercept / offset 
y = w1 * dataset(:,4) + w0;


if(my_plot)
    figure;
    plot (dataset(:,4), dataset(:,1), 'rx');  % Plot the dataset's points
    hold on;
    plot (dataset(:,4), y , 'b-' , 'Linewidth', 2);  % Plot a line with this shape: y = slope * x 
    title('One-dimensional problem with intercept on the Motor Trends car data');
end

end