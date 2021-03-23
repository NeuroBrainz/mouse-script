%mousedata = edfread("D:\Research\DATA FILES\Week 1\THIP8.edf");
%{
NREM Delta Power Extraction Script

Authors: Zihao Zhou & Rohan Rao
Revision: 3/6
%}





%Please Edit These Values as Needed
%----------------------------------%
rawDataPath = 'D:\Research\DATA FILES\Week 1';
rawScorePath = 'D:\Research\DATA FILES\Excel';
%----------------------------------%






for i = 1:length(fileNameArr)
    

    %fileName = input('Please enter the name of the file\n', 's');

    fileName = fileNameArr{i};

    filePath = fullfile(rawDataPath,[fileName,'.edf']);
    epochPath = fullfile(c,[fileName,'.csv']);
    titleNames = mousedata.Properties.VariableNames;
    columnChoice = "";
    for u = 1:3
        choiceString = "RF";
        if (contains(titleNames(u), choiceString))
           columnChoice = u; 
        end   
    end

    disp(columnChoice);
    mousedata.Properties.VariableNames{columnChoice} = 'one';
    
    
    
    
    
end
