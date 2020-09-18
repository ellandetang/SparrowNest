% Read the force data from the measurement plate and the prop stand
% Updated 20200116 take user mouse inputs to select start data and time
% spacing

clear
% close all
clc


% Propeller Positions
motorD = 41.8/25.4; % in
position0_Offset = norm([19 285])/norm([423 13])*motorD;
positionX = [0 .506 1.0875 2.06 3.028 3.947 4.943 6.0885] + position0_Offset;



% Get list of folders in working directory
FolderNames = ls;
isData = false(size(FolderNames,1),1);
DataIndex = zeros(size(FolderNames,1),1);

% Check each folder name for valid format
for ind1 = 1:size(FolderNames,1)
    if any(regexp(FolderNames(ind1,:),'Position'))
        isData(ind1) = true;
        DataIndex(ind1) = str2num(FolderNames(ind1,regexp(FolderNames(ind1,:),'[0-9]')));
    end
end

% Create list of valid folder names
FolderNamesValid = FolderNames(isData,:);
DataIndexValid = DataIndex(isData,:);

% sort folder names based upon position numbers
[DataIndexSorted,sortIndex] = sort(DataIndexValid);
FolderNamesSorted = FolderNamesValid(sortIndex,:);

positionNum = size(FolderNamesSorted,1);

% Access Data
truncate = @(in) in(in ~= ' ');

DataNames = {'Thrust','rpm_optical','rpm_electrical','current','voltage','torque','Vibration'};

for ind2 = 1:positionNum
    contents = ls(FolderNamesSorted(ind2,:));
    subFolderPlateDataIndex = 0;
    subFolderPropDataIndex = 0;
    for ind3 = 1:size(contents,1)
        if any(regexp(contents(ind3,:),'TestData'))
            subFolderPlateDataIndex = ind3;
        end
        if any(regexp(contents(ind3,:),'StepsTest')) 
            subFolderPropDataIndex = ind3;
        end
    end
    
    % Loads Plate Force Data
    load([truncate(FolderNamesSorted(ind2,:)) '\' truncate(contents(subFolderPlateDataIndex,:))])
    DataArray{ind2} = ForceStore;
    
    fileToRead = [truncate(FolderNamesSorted(ind2,:)) '\' truncate(contents(subFolderPropDataIndex,:))];
    
    T = readtable(fileToRead);
    
    Data{1,ind2} = T.Thrust_gf_;
    
    Data{2,ind2} = T.MotorOpticalSpeed_RPM_;
    
    Data{3,ind2} = T.MotorElectricalSpeed_RPM_;
    
    Data{4,ind2} = T.Current_A_;
    
    Data{5,ind2} = T.Voltage_V_;
    
    Data{6,ind2} = T.Torque_N_m_;
    
    Data{7,ind2} = T.Vibration_g_;
end

%%
% Identify Sample Points

for ind7 = 1:positionNum

   clf
    grid on
    % hold on
    
    % time
    DataX = DataArray{ind7}(:,1);
    % Force
    DataY = DataArray{ind7}(:,2);
    
    % tare times
    DataX = DataX - DataX(1);
    endTime = max(DataX);
    
    % Plotting was used for sampling data
    line(DataX,DataY,'marker','.','linestyle','none','color',[0 0 0])
    
    % Manually Select Points with a mouse
    [xi,yi] = getpts;
    startTime(ind7) = xi(1)-.5; 
  
end
    
%%

startTime = [2.441374663072776,2.441374663072778,2.267137096774192,...
    3.045026881720430,2.608198924731182,2.574596774193550,...
    2.540994623655914,3.078629032258064];

% spacingList = [2.02 2.02 2.02 2.02 2.02 ...
%     2.02 2.02 2.02 2.02 2.02 ...
%     2.02 2.02 2.02];
spacingList = 2.00*ones(1,positionNum);

% dataQuantity = [19*ones(2,1) ; 22*ones(positionNum-2,1)];

forceMeasured = zeros(23,positionNum);

for ind4 = 1:positionNum
    
% for ind4 = 10
    clf
    grid on
    % hold on
    
    % time
    DataX = DataArray{ind4}(:,1);
    % Force
    DataY = DataArray{ind4}(:,2);
    
    % tare times
    DataX = DataX - DataX(1);
    endTime = max(DataX);
    
    % Plotting was used for sampling data
    line(DataX,DataY,'marker','.','linestyle','none','color',[0 0 0])
    
    
    % Plot Sample Points
    spacing = spacingList(ind4);
    
    sampleTimeStart = startTime(ind4):spacing:endTime;
    sampleTimeEnd = startTime(ind4)+.5:spacing:endTime;
    
    sampleStartIndices = zeros(size(sampleTimeEnd));
    sampleEndIndices = zeros(size(sampleTimeEnd));
    
    for ind5 = 1: length(sampleTimeEnd)
        
        [~,sampleStartIndices(ind5)] = min(abs(DataX - sampleTimeStart(ind5)));
        [~,sampleEndIndices(ind5)] = min(abs(DataX - sampleTimeEnd(ind5)));
        
    end
    
    % Plotting to check data tagging
    line(DataX(sampleStartIndices),DataY(sampleStartIndices),'marker','o','linestyle','none','color',[0 1 0])
    line(DataX(sampleEndIndices),DataY(sampleEndIndices),'marker','o','linestyle','none','color',[1 0 0])
    keyboard
    
    % Calculate Value
    for ind6 = 1:length(sampleEndIndices)
        forceMeasured(ind6,ind4) = mean(DataY(sampleStartIndices(ind6):sampleEndIndices(ind6)));
    end
    
end

% plot(1:size(forceMeasured,1),forceMeasured,'-o')
grid on

save('MeasuredForces','forceMeasured','positionX','Data','DataNames')