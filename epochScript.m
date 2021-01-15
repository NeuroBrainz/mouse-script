epochNum = readtable('epochNum.csv');

epochTime = epochNum(:,1);
epochState = epochNum(:,2);
epochLength = epochNum(:,3);




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


keepRunning = false;

for i = 1:length(epochState)
    
    
    
    
end




for i = 1:3600

    epochTest = epochState(increment, 1);
    if keepRunning == true
        temp = mousedata.RF8CONTROL{increment, 1};       %find the data in the relevant cell and load into a temp var.
        Raw_hour = [Raw_hour, temp];

        
    end
    
    
        
    increment = increment+1;


    disp(increment);
    progress = ((increment/86389)*100 );
    disp(progress);
    
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