titleNames = epochNum.Properties.VariableNames;
columnChoice = "";
for u = 1:7
    choiceString = "RF";
    if (contains(titleNames(u), choiceString))
       columnChoice = u; 
        
    end   
end

disp(columnChoice);