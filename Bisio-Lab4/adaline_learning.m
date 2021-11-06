% Receives as input a traning set, eta, wa, ouputs wa and iter
function [wa,i] = adaline_learning(train_set, H, wa)
    

target = train_set(:,end);


% My Parameters

n = size(train_set,1);
i = 0;
min_error = 1;
l = 1;
delta_W = zeros(size(train_set,1),2);


% Using a large enough number

while((min_error >= 0.1) && (i ~= 10000)) 
    
    
    r(l) = train_set(l,1:end -1)*wa';
    D_error = (target(l) - r(l));
    delta_W = H * D_error.*train_set(l,1:end-1);
    wa = wa + delta_W;
    l = l + 1;
    i = i + 1;
    
        if(l > n)
            
        l = 1;
        
        
        % Finds the Mean Square Error
        
        min_error = immse(target, r');

    
        end
        
end
end