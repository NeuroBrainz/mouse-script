mousedata = edfread("C:\Users\zhoujianf.UM-AD\Documents\Zihao\TBI_screws_F29.reduced.edf");
length = 3600;                          %Set to the number of seconds we will run, 1 hour = 3600
hour = 1;

Fs = 512;        %Set standard frequency
%hourOneDelta = [];
%hourOneNormal = [];
unfiltTotal = [];

%Notch Filter
wo=60/(Fs/2);
bw=wo/35;
[b,a]=iirnotch(wo,bw);

finalNormalized = zeros(1,hour);
increment = 1;
normalAvg = 0;
totalAmount = hour*length;




for j = 1:hour
    hourOneNormal = zeros(1, length);
    if j == 24
        for i = 1:length
            %Method one: take bandpass filter on each second and then average%   

            temp = mousedata.RF8CONTROL{increment, 1};       %find the data in the relevant cell and load into a temp var.


            bandPassTemp = bandpass(temp,[1 35], Fs);       %bandpass filter on the data from 1-35 HZ
            filteredVal = filter(b,a, bandPassTemp);


            %hourOneDelta = [hourOneDelta, finalDeltaPower];

            normalizedDelta = finalDeltaPower/(finalDeltaPower+finalThetaPower + finalAlphaPower + finalBetaPower + finalGammaPower);


            hourOneNormal = [hourOneNormal, normalizedDelta];


            normalAvg = mean(hourOneNormal);

            %Progress Counter

            %disp('percentage complete');
            disp(increment);
            progress = ((increment/totalAmount)*100 );
            disp(progress);
            increment = increment+1;

            %UNFILTERED DATA
            %unfiltered = bandpower(bandPassTemp,Fs,[.5,4]);
            %unfiltTotal = [unfiltTotal, unfiltered];      
            
        end
    else
        for i = 1:3588
            %Method one: take bandpass filter on each second and then average%   

            temp = mousedata.RF8CONTROL{increment, 1};       %find the data in the relevant cell and load into a temp var.


            bandPassTemp = bandpass(temp,[1 35], Fs);       %bandpass filter on the data from 1-35 HZ
            filteredVal = filter(b,a, bandPassTemp);


            %hourOneDelta = [hourOneDelta, finalDeltaPower];

            normalizedDelta = finalDeltaPower/(finalDeltaPower+finalThetaPower + finalAlphaPower + finalBetaPower + finalGammaPower);


            hourOneNormal = [hourOneNormal, normalizedDelta];


            normalAvg = mean(hourOneNormal);

            %Progress Counter

            %disp('percentage complete');
            disp(increment);
            progress = ((increment/totalAmount)*100 );
            disp(progress);
            increment = increment+1;

            %UNFILTERED DATA
            %unfiltered = bandpower(bandPassTemp,Fs,[.5,4]);
            %unfiltTotal = [unfiltTotal, unfiltered];  
        
        
        
        
        end
        
            
    end
    
    finalNormalized = [finalNormalized, normalAvg];
    
end

% hourOneAvg = mean(hourOne);
time = [1:hour];
%Blue plot is processed through notch filter
%figure(1);
title('Line plot of Normalized Delta Power over time');
xlabel('time(hours)');
ylabel('normalized delta power');
plot(time, finalNormalized);

%grid;
writematrix(finalNormalized, "deltaResult.csv");
%Orange plot is unfiltered
%figure(2);

%plot(time, hourOneDelta);
%grid;
%plot(time,unfiltTotal); 
