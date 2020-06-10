% Last Edited: 20200107 Ellande Tang
% Designed for compatibility with MultiCellReaderV2

% Plots estimated Z Force for 40 seconds

clear
% close all
clf
clc

load('CalibrationMatrixZTable5')

SL = seriallist;
s = serial(SL(1),'Baudrate',57600);

fopen(s);

nSensors = 4;

dataTare = cell(1,nSensors);
dataStore = cell(1,nSensors);

% Define Drawing Lines
lineList = line(0,0,'marker','.');

tMax = 45;
grid on;
xlabel('Time (s)')
ylabel('Force (gf)')

xlim([0,tMax*1.1]);
ylim([-100,1100]);

%% Tare Data

flushinput(s)

for ind3 = 1:80
  
    outf = fscanf(s);
    
    % Parse Data
    
    parseIndices = find(outf == ':' | outf == newline);
    
    sensorIndex = str2double(outf(1:parseIndices(1)-1));
    timeStamp = str2double(outf(parseIndices(1)+1:parseIndices(2)-1));
    sensorValue = str2double(outf(parseIndices(2)+1:parseIndices(3)-1));

    % Write Data
    dataTare{sensorIndex}(end+1,:) = sensorValue;
    
end


for ind4 = 1:nSensors
   tare(ind4,1) = mean(dataTare{ind4});
end

%% Read Data for test

keyboard
% ForceStore = zeros(tMax*nSensors*9,2);

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
       xlim([timeStamp-.1,(timeStamp+tMax*1.1)]); 
    end
    
    % Write Data
    dataStore{sensorIndex}(end+1,:) = [timeStamp sensorValue];
    
    latestRead(sensorIndex) = sensorValue; 
    
    % Standard Linear Fit
    Force = (C*(latestRead - tare))'/9.81*1000;
    
    % Quadratic Model
    % Force = (C*[(latestRead - tare);(latestRead - tare).^2])'/9.81*1000;
    
    ForceStore(ind1,:) = [timeStamp,Force]; 
    
    lineList.XData = ForceStore(:,1);
    lineList.YData = ForceStore(:,2);
    
    drawnow
    
    ind1 = ind1 + 1;
    end
end

timeString = char(datetime);
timeString(timeString == ' ') = '_';
timeString(timeString == ':') = '';

save(['TestData_' timeString],'dataStore','ForceStore')


%%
fclose(s)

%% Reset Connections

% fclose(instrfind)