% Receives as input a traning set, eta, w, ouputs w and iter
function [w,i] = perceptron_learning(train_set, H, w)


target = train_set(:,end);


% My Parameters

n = size(train_set,1);
i = 0;
min_error = 1;
l = 1;


while((min_error >= 0.06) && (i ~= 10000)) 
    
    
    R = train_set(l,1:end -1)*w';
    a(l) = sign(R);
    output_error(l) = 0.5*(target(l) - a(l));
    delta_W = H * output_error(l).*train_set(l,1:end-1);
    w = w + delta_W;
    l = l + 1;
    i = i + 1;
    
    if(l > n)
        l = 1;
        error = abs(target - a');
        
        
        % Finds the Mean Error
        
        min_error = mean(error);
        
        
    end
    
end  

end