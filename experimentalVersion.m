mousedata = edfread("C:\Users\zhoujianf.UM-AD\Documents\Zihao\TBI_screws_F29.reduced.edf");


Fs = 512;        %Set standard frequency
%hourOneDelta = [];
%hourOneNormal = [];
unfiltTotal = [];

%Notch Filter
wo=60/(Fs/2);
bw=wo/35;
[b,a]=iirnotch(wo,bw);

finalFiltered = [];
totalAmount = 86388;


epochNum.epoch(1);


Raw_hour = [];

for j = 1:24
    if j == 24
        for i = 1:3589

            temp = mousedata.RF8CONTROL{increment, 1};       %find the data in the relevant cell and load into a temp var.
            Raw_hour = [Raw_hour, temp];

            increment = increment+1;


            disp(increment);
            progress = ((increment/86389)*100 );
            disp(progress);
        end
    else
        for i = 1:3600

            temp = mousedata.RF8CONTROL{increment, 1};       %find the data in the relevant cell and load into a temp var.
            Raw_hour = [Raw_hour, temp];

            increment = increment+1;


            %unfiltTotal = [unfiltTotal, temp];
            %finalFiltered = [finalFiltered, filteredVal];   

            %Progress Counter

            %disp('percentage complete');
            disp(increment);
            progress = ((increment/86389)*100 );
            disp(progress);
        end

    end

        bandPassTemp = bandpass(Raw_hour,[1 35], Fs);       %bandpass filter on the data from 1-35 HZ
        filteredVal = filter(b,a, bandPassTemp);
        
        finalDeltaPower = bandpower(filteredVal,Fs,[.5,4]);
        finalThetaPower= bandpower(filteredVal,Fs,[4,7]);
        finalAlphaPower= bandpower(filteredVal,Fs,[8,13]);
        finalBetaPower= bandpower(filteredVal,Fs,[13,30]);
        finalGammaPower= bandpower(filteredVal,Fs,[30,80]);
        
        
        normalizedDelta = finalDeltaPower/(finalDeltaPower+finalThetaPower + finalAlphaPower + finalBetaPower + finalGammaPower);


        hourOneNormal = [hourOneNormal, normalizedDelta];

        

end

% hourOneAvg = mean(hourOne);
%time = [1:totalAmount];
%Blue plot is processed through notch filter
%figure(1);
%title('Line plot of Normalized Delta Power over time');
%xlabel('time(hours)');
%ylabel('normalized delta power');
%plot(time, finalNormalized);                     
%hold on
%plot(time, unfiltTotal);

%grid;
%writematrix(finalNormalized, "deltaResult.csv");
%Orange plot is unfiltered
%figure(2);

%plot(time, hourOneDelta);
%grid;
%plot(time,unfiltTotal); 
