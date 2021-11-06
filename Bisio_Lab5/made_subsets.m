function [subset_1, subset_2] = made_subsets(my_dataset,val_1,val_2)


%% Generate the first subset

index_1 = find(my_dataset(:,end)==val_1);
subset_1 = my_dataset(index_1,:);
%target_1 = subset_1(:,end);
subset_1 = subset_1(:,1:(end-1));


%% Generate the second subset

index_2 = find(my_dataset(:,end)==val_2);
subset_2 = my_dataset(index_2,:);
%target_2 = subset_2(:,end);
subset_2 = subset_2(:,1:(end-1));


end