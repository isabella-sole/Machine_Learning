% Receives as input T_m and an entry, checks on T_m, outputs T_m
function [T_m] = binary(T_m, entry)


    for j = 1 : length(T_m)
        
        % If not binary
        
        if T_m(j) ~= entry
            T_m(j) = -1;
        
            
        % If binary
        
        else 
            T_m(j) = 1;
    
        end
             
        
end

