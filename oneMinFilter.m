% Transfer to one dimension data of in one hour
%------------------------------------------------%
%mousedata = edfread("TBI_screws_F29.reduced.edf");
length = 60;           %Set to the number of seconds we will run, 1 hour = 3600
hour = 1;

increment = 1;
Raw_min=0;
temp1 = 0;

for j = 1:hour

    for i = 1:length
               
        temp = mousedata.RF8CONTROL{increment, 1};       %find the data in the relevant cell and load into a temp var.
        Raw_min = [temp1; temp];
        temp1 = Raw_min;
        increment = increment+1;

    end
    
  
end


%%
bandPassTemp1 = bandpass(Raw_min,[1 35], Fs);       %bandpass filter on the data from 1-35 HZ
filteredVal = filter(b,a, bandPassTemp1);
    


%%


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


