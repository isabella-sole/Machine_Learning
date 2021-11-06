%% Machine Learning Lab 3: kNN classifier
% Isabella-Sole Bisio

close all
clear all
clc

%% Task 1: Obtain a data set
%%

% Traing set uploading
[data, label]  = loadMNIST(0);
traing_set = [data, label];

% Test set uploading
[test_set, test_label]  = loadMNIST(1);


n = 1;
test_set = test_set(1:end/n,1:end);
traing_set = traing_set(1:end/n,1:end);
test_label = test_label(1:end/n,1:end);


%% Task 2: Build a kNN classifier
%% 

k = 1;

[prediction ,error_rate] = kNN_classifier(traing_set, test_set, k, test_label);
[observations,~] = size(test_label);

% When the error_rate is evaluated display it

if (~isnan(error_rate)) 
    disp(['Evaluating the error_rate with ',num2str(observations),' observations and setting k = ',num2str(k),' the result is: ',num2str(error_rate),'%']);
    disp(['With an accuracy of: ',string(1-error_rate/100)]);
end

%% Task 3: Test the kNN classifier
%% Print error rate trend for Task3_Point1
%%
% k = 1:201;
% for y = 1:10
%     figure;
%     name = 'result_files/result_k1-201_digit' + string(y) + '.mat';
%     load(name);
% %     bar(result(1:2:end,2),0.8);
%     plot(k,result(1:2:end,2)*100);
%     title(["Error rate trend (%) with digit ", string(y) ," vs the remaining nine"]);
%     xlabel("k values ");
%     ylabel("Error %");
%     xlim([0 201]);
%     ylim([0.2 2.2]);
%
% end
%

%% Print accuracy trend for Task3_Point1 - it needs the files made from Task3_Point1.m
digits = [ 1 2 3 4 5 6 7 8 9 0];
k = 1:2:201;
for y = 1:10
    figure;
    name = 'result_files/result_k1-201_digit' + string(y) + '.mat';
    load(name);
    bar(k,(1-result(1:2:end,2))*100, 0.7);
    title(["Accuracy trend with digit ", string(digits(y)) ," vs the remaining nine"]);
    xlabel("k values ");
    ylabel("Accuracy %");
    %     xlim([0 201]);
    ylim([97.8 99.75]);
    saveas(gcf,'MultiDigit_'+string(y)+'.jpeg');
end

%% Print accuracy trend for Task3_Point2 - it needs the files made from Task3_Point2.m
figure;
load('result_files/result_several_k1.mat');
bar(k,(1-result(1:2:end,2))*100);
title(["Accuracy trend (%) for several values of k"]);
xlabel("k values ");
ylabel("Accuracy %");
xlim([0 201]);
ylim([92.5 97.5]);
saveas(gcf,'SeveralK.jpeg');

