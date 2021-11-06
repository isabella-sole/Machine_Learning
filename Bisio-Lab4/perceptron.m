% Receives as input a dataset, eta and H, outputs trainset, testset, C, iteraction 
% Uses perceptron algorithm
function [out1, out2, out3, out4] = perceptron(DATASET, H,K)
n = size(DATASET,1);

if ((K <2) || (K > n))
    
    error("ERROR") % I already pass k=2, just an ulterior check in case of reuse
    
end

w = rand(1,2);


%% CROSS VALIDATION

if (K == 2)
    
    train_set = DATASET(1:(size(DATASET)/2),:);
    test_set = DATASET((size(DATASET)/2)+1:end,:);


    [w,iteraction] = perceptron_learning(train_set, H, w);
    target_test = test_set(:,end);
    e = 1;

    while( e ~= size(test_set,1)+1)
        
        r = test_set(e,1:end-1)*w';
        a(e) = sign(r);
        e = e +1;
        
    end

% Setting the Confusion Matrix


a = a';
C = confusionmat(target_test,a);

out1 = train_set;
out2 = test_set;
out3 = C;
out4 = iteraction;

end


%% K-FOLD CROSS VALIDATION

if (K > 2 )

    
    [train_set,test_set] = kfold_cross_validation(DATASET, K);
    
    
    for j = 1:K
        
        [w,iteraction] = perceptron_learning(train_set{j},H,w);
        W{j} = w;
        Iteraction{j} = iteraction;
        target_test{j} = test_set{j}(:,end);
        e = 1;
        
        
        while( e ~= size(test_set{j},1)+1)
            
            r = test_set{j}(e,1:end-1)*W{j}';
            a{j}(e) = sign(r);
            e = e +1;
            
        end
        
      
        a{j} = a{j}';
        C{j} = confusionmat(target_test{j},a{j});
        
    end
    
   
    % Outputs
    
    out1 = train_set;
    out2 = test_set;
    out3 = C;
    out4 = Iteraction;
    
    
end

    
end
