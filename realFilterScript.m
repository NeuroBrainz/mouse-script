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




for i = 1:86388
    temp = mousedata.RF8CONTROL{i, 1};       %find the data in the relevant cell and load into a temp var.


    bandPassTemp = bandpass(temp,[1 35], Fs);       %bandpass filter on the data from 1-35 HZ
    filteredVal = filter(b,a, bandPassTemp);
    
    unfiltTotal = [unfiltTotal, temp];
    finalFiltered = [finalFiltered, filteredVal];

    %Progress Counter

    %disp('percentage complete');
    disp(i);
    progress = ((i/totalAmount)*100 );
    disp(progress);
    
end





% hourOneAvg = mean(hourOne);
time = [1:totalAmount];
%Blue plot is processed through notch filter
%figure(1);
%title('Line plot of Normalized Delta Power over time');
%xlabel('time(hours)');
%ylabel('normalized delta power');
plot(time, finalNormalized);
hold on
plot(time, unfiltTotal);

%grid;
%writematrix(finalNormalized, "deltaResult.csv");
%Orange plot is unfiltered
%figure(2);

%plot(time, hourOneDelta);
%grid;
%plot(time,unfiltTotal); 
