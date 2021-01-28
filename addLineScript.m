epochNum = readmatrix("epochNum.csv");

newRow = zeros(1,size(epochNum,2));                       % row of 0s
epochNum = [epochNum(1:11, :); newRow; epochNum(12:end, :)];    % your updated matrix

for o = 1:86
    
    
    
    
    
    
    
    newRow = zeros(1,size(epochNum,2));                       % row of 0s
    epochNum = [epochNum(1:11, :); newRow; epochNum(12:end, :)];    % your updated matrix
    
    
    
    
end


for j = 1:86
        time1 = epochNum(j,1);
        time2 = epochNum(j,2);
        
        w = time1;
        
        while (w <= time2)
            
            temp = mousedata.RF8CONTROL{w, 1};       %find the data in the relevant cell and load into a temp var.
            Raw_hour = [Raw_hour, temp];

            if (mod (w, 3600) == 0)
                
                
                
                
            end
                
                        
            w = w+1;
            disp(w);
            
        end
        
    
           
    
    
end