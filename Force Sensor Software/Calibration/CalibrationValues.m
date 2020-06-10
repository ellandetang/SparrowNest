% Script that grabs averages of load cell values for the purposes of calibration
% Exports "CallibrationData" for use with "SensitivityMatrixConstruct"

clear
clf
clc

SL = seriallist;
s = serial(SL,'Baudrate',57600);

fopen(s);

nSensors = 3;

if ~exist('CalibrationMean','var')
    CalibrationMean = [];
    CalibrationSTD = [];
end

%%

flushinput(s)

disp('Grabbing Calibration Data')

dataStore = cell(1,nSensors);

for ind1 = 1:80
    
    outf = fscanf(s);
    
    % Parse Data
    
    parseIndices = find(outf == ':' | outf == newline);
    
    % parse data
    sensorIndex = str2double(outf(1:parseIndices(1)-1)); % Which sensor has been updated
    timeStamp = str2double(outf(parseIndices(1)+1:parseIndices(2)-1))/1000; % Read time
    sensorValue = str2double(outf(parseIndices(2)+1:parseIndices(3)-1)); % value
    
    % Write Data
    dataStore{sensorIndex}(end+1,1) = sensorValue;
       
end

clf

for ind4 = 1:nSensors
   dataMean(ind4,1) = mean(dataStore{ind4});
   dataStd(ind4,1) = std(dataStore{ind4});
   plot(dataStore{ind4})
   hold on
end

% plot(1:20,dataStore)

CalibrationMean = [CalibrationMean;dataMean'];
CalibrationSTD = [CalibrationSTD;dataStd'];

disp('Done')

%%

save('CalibrationData','CalibrationMean','CalibrationSTD')

%%
fclose(s)

%% Reset Connections

% fclose(instrfind)