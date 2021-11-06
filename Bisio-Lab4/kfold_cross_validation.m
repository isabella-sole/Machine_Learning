function [train_set,test_set] = kfold_cross_validation(DATASET, K)


       n = size(DATASET,1);
       
       
       for i = 1:K
           
           
            a = 0;
            e = (i+(n-round(n/K)));
            train_set{i} = DATASET;
            
            
            for j = (i+(n-round(n/K))):n
                
                test_set{i}(1+a,:) = train_set{i}(e,:);
                train_set{i}(e,:) = [];
                a = a + 1;
                
            end
            
            e = 1;
            
            for j = 1:(round(n/K)-a)
                
                test_set{i}(1+a,:) = train_set{i}(e,:);
                train_set{i}(e,:) = [];
                a = a +1;
                
            end
            
       end
        
end