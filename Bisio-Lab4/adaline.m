% Receives as input a dataset, eta and H, outputs trainset, testset, C, iteraction 
% Uses LMS algorithm
function [out1, out2, out3, out4] = adaline(DATASET, H, K)
n = size(DATASET,1);

if ((K <2) || (K > n))
    
    error("ERROR")  % I already pass k=2, just an ulterior check in case of reuse
    
end 

WA = zeros(1,2);


%% CROSS VALIDATION


if (K == 2)
    
    train_set = DATASET(1:(size(DATASET)/2),:);
    test_set = DATASET((size(DATASET)/2)+1:end,:);


    [WA,iteraction] = adaline_learning(train_set,H,WA);
    target_test = test_set(:,end);
    e = 1;

    while( e ~= size(test_set,1)+1)
        
    r = test_set(e,1:end-1)*WA';
    a(e) = sign(r);   
    e = e +1;
    
    end
    
% Setting the Confusion Matrix


a = a';
Conf_mat = confusionmat(target_test,a);

out1 = train_set;
out2 = test_set;
out3 = Conf_mat;
out4 = iteraction;


end


%% K-FOLD CROSS VALIDATION

if (K > 2)
    
    
    [train_set,test_set] = kfold_cross_validation(DATASET,K);
    
    
    for i = 1:K
        
        [w,iteraction] = adaline_learning(train_set{i},H,WA);
        W{i} = w;
        Iteraction{i} = iteraction;
        target_test{i} = test_set{i}(:,end);
        e = 1;
        
        
        while( e ~= size(test_set{i},1)+1)
            
            r = test_set{i}(e,1:end-1)*W{i}';
            a{i}(e) = sign(r);
            e = e +1;
            
        end
        
        
        a{i} = a{i}';
        Conf_mat{i} = confusionmat(target_test{i},a{i});
        
    end
    
    
    % Outputs
    
    out1 = train_set;
    out2 = test_set;
    out3 = Conf_mat;
    out4 = Iteraction;
    
    
end
