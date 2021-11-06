%% Machine Learning Lab 2: Linear regression
% Isabella-Sole Bisio

function graphs_result_analisys(dataset)

dimension = size(dataset, 1);
random_dataset = dataset(randperm(dimension), :);
number_subset = 9;
dimension_subset = floor(dimension / number_subset);  % Use floor operator to obtain correct indexes


figure;
sgtitle(['Comparison of ', int2str(number_subset ) ,' subset of the dataset']);
for i = 1:number_subset
    dataset = random_dataset((dimension_subset*i+1-dimension_subset) : dimension_subset*i,:);
    slope = linear_regression(dataset,0);
    subplot(3,3,i);
    plot (dataset(:,1), dataset(:,2), 'rx'); % Plot dataset's points
    hold on;
    plot (dataset(:,1), slope * dataset(:,1), 'b-' , 'Linewidth', 2); % Plot a line with this shape: y = slope * x
    hold on;
    title(['Subset number',num2str(i),' - Slope =', num2str(slope) ]);
    
end

end