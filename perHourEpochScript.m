%mousedata = edfread("C:\Users\zhoujianf.UM-AD\Documents\Zihao\TBI_screws_F29.reduced.edf");
mousedata = edfread("E:\TBIf465W1.edf");
epochNum = readmatrix("epochNum.csv");

Fs = 512;        %Set standard frequency


%Notch Filter
wo=60/(Fs/2);
bw=wo/35;
[b,a]=iirnotch(wo,bw);

Raw_hour = [];
hourOneNormal = [];



titleNames = mousedata.Properties.VariableNames;

for u = 1:3
    choiceString = "RF";
    if (contains(titleNames(u), choiceString))
       columnChoice = u; 
       columnName = titleNames(u);
        
    end   
end

disp(columnChoice);
disp(columnName);


for j = 1:99
        time1 = epochNum(j,1);
        time2 = epochNum(j,2);
        
        w = time1;
        
        while (w <= time2)
            val = ['columnName'];
            temp = mousedata.{w, columnChoice};       %find the data in the relevant cell and load into a temp var.
            Raw_hour = [Raw_hour, temp];

            if (mod (w, 3600) == 0)
                
                bandPassTemp = bandpass(Raw_hour,[1 35], Fs);       %bandpass filter on the data from 1-35 HZ
                filteredVal = filter(b,a, bandPassTemp);

                finalDeltaPower = bandpower(filteredVal,Fs,[.5,4]);
                finalThetaPower= bandpower(filteredVal,Fs,[4,7]);
                finalAlphaPower= bandpower(filteredVal,Fs,[8,13]);
                finalBetaPower= bandpower(filteredVal,Fs,[13,30]);
                finalGammaPower= bandpower(filteredVal,Fs,[30,80]);
                normalizedDelta = finalDeltaPower/(finalDeltaPower+finalThetaPower + finalAlphaPower + finalBetaPower + finalGammaPower);


                hourOneNormal = [hourOneNormal, normalizedDelta];

                disp("hour passed \n\n\n");
                
                
            end
                
                        
            w = w+1;
            disp(w);
            
        end
        
        
        
        
        

        disp("Cycle completed");
        disp(j);
           
    
    
end
    

time = [1:23];
plot(time, hourOneNormal);

    
    

