% Last Edited: 20200616 Ellande Tang
% Designed for compatibility with MultiCellReader_2020_09_17

% Plots outputs for a fixed amount of time

clear
clf
clc

load('CalibrationMatrix')

SL = seriallist;
s = serial(SL(1),'Baudrate',57600);

fopen(s);

% nSensors = 6;
% nOutputs = 3;
nSensors = size(C,2);
nOutputs = size(C,1);

dataTare = cell(1,nSensors);
dataStore = cell(1,nSensors);

tMax = 120;


plotLabels = {'Force (gf)','Moment X','Moment Y'};


%% Tare Data

flushinput(s)

for ind3 = 1:80
    
    outf = fscanf(s);
    
    % Parse Data
    
    parseIndices = find(outf == ':' | outf == newline);
    
    if length(parseIndices) == 3
        
        sensorIndex = str2double(outf(1:parseIndices(1)-1));
        timeStamp = str2double(outf(parseIndices(1)+1:parseIndices(2)-1));
        sensorValue = str2double(outf(parseIndices(2)+1:parseIndices(3)-1));
        
        if any(1:nSensors == sensorIndex)
            % Write Data
            dataTare{sensorIndex}(end+1,:) = sensorValue;
        end
        
    end
end


for ind4 = 1:nSensors
    tare(ind4,1) = mean(dataTare{ind4});
end

%% Read Data for test

keyboard

flushinput(s)

tic
ind1 = 1;

latestRead = tare;

while toc < tMax
    
    outf = fscanf(s);
    
    % Parse Data
    
    parseIndices = find(outf == ':' | outf == newline);
    
    if length(parseIndices) == 3
        
        % parse data
        sensorIndex = str2double(outf(1:parseIndices(1)-1)); % Which sensor has been updated
        timeStamp = str2double(outf(parseIndices(1)+1:parseIndices(2)-1))/1000; % Read time
        sensorValue = str2double(outf(parseIndices(2)+1:parseIndices(3)-1)); % value
        
        % tare the graph
        if ind1 == 1
            for ind2 = 1:nOutputs
                % Define Drawing Lines
                subplot(nOutputs,1,ind2)
                
                lineList(ind2) = line(0,0,'marker','.');
                
                grid on;
                xlabel('Time (s)')
                ylabel(plotLabels{ind2})
                
                xlim([timeStamp-.1,(timeStamp+tMax*1.1)]);
                
            end
        end
        
        if any(1:nSensors == sensorIndex)
            % Write Data
            dataStore{sensorIndex}(end+1,:) = [timeStamp sensorValue];
                       
            latestRead(sensorIndex) = sensorValue;
            
            % Standard Linear Fit
            Data = (C*(latestRead - tare))';
            Data(1) = Data(1)/9.81*1000;
            Output = Data;
            
            
            
            OutputStore(ind1,:) = [timeStamp,Output];
            

            for ind5 = 1:nOutputs
                
            lineList(ind5).XData = OutputStore(:,1);
            lineList(ind5).YData = OutputStore(:,ind5+1);
            
            end
            
            drawnow limitrate
            
            ind1 = ind1 + 1;
        end
    end
end

timeString = char(datetime);
timeString(timeString == ' ') = '_';
timeString(timeString == ':') = '';

save(['TestData_' timeString],'dataStore','OutputStore')
% ,'MomentXStore','MomentYStore'

% Realtime display sanity check
% ForceStore(end,1) - ForceStore(1,1)

%%
fclose(s)

%% Reset Connections

% fclose(instrfind)