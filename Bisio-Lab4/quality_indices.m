function [accuracy, error_rate ,sensivity, specifity] = quality_indices(C_XOR_p, C_XOR_a)

    
    for j = 1 : size(C_XOR_p,2)
        
        a{j} = [ sum(C_XOR_p{j}, 'all') sum(C_XOR_a{j}, 'all') ];
        
        Accuracy{j} = [ trace(C_XOR_p{j})/a{j}(1) trace(C_XOR_a{j})/a{j}(2) ];
        
        Error_Rate{j} = [ (a{j}(1)-trace(C_XOR_p{j}))/a{j}(1) (a{j}(2)-trace(C_XOR_a{j}))/a{j}(2) ];
        
        Sensivity{j} = [ C_XOR_p{j}(2,2)/sum(C_XOR_p{j}(2,:)) C_XOR_a{j}(2,2)/sum(C_XOR_a{j}(2,:)) ];
        
        Specifity{j} = [ C_XOR_p{j}(1,1)/sum(C_XOR_p{j}(1,:)) C_XOR_a{j}(1,1)/sum(C_XOR_a{j}(1,:)) ];
    end 

    
    % Outputs
    
    accuracy = Accuracy;
    error_rate = Error_Rate;
    sensivity = Sensivity;
    specifity = Specifity; 

end 
