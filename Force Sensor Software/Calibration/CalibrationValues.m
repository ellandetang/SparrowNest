% Script that grabs averages of load cell values for the purposes of calibration
% Exports "CalibrationData" for use with "SensitivityMatrixConstruct"

clear
clf
clc

SL = seriallist;
s = serial(SL,'Baudrate',57600);

fopen(s);

nSensors = 6;

if ~exist('CalibrationMean','var')
    CalibrationMean = [];
    CalibrationSTD = [];
end

%%

flushinput(s)

disp('Grabbing Calibration Data')

dataStore = cell(1,nSensors);

for ind1 = 1:(20*nSensors)
    
    outf = fscanf(s);
    
    % Parse Data
    
    parseIndices = find(outf == ':' | outf == newline);
    if length(parseIndices) == 3
        % parse data
        sensorIndex = str2double(outf(1:parseIndices(1)-1)); % Which sensor has been updated
        timeStamp = str2double(outf(parseIndices(1)+1:parseIndices(2)-1))/1000; % Read time
        sensorValue = str2double(outf(parseIndices(2)+1:parseIndices(3)-1)); % value
        
        % Write Data
        if sensorIndex <= nSensors
            dataStore{sensorIndex}(end+1,1) = sensorValue;
        end
    end
end

clf

for ind2 = 1:nSensors
    dataMean(ind2,1) = mean(dataStore{ind2});
    dataStd(ind2,1) = std(dataStore{ind2});
    plot(dataStore{ind2})
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