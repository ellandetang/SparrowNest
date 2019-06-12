% Attemps to find drag function for the propeller based on rpm, angle  of
% attack, and forward velocity

clear
close all
clc


% Fan array wind speeed function, throttle from 0 to 1
V = @(x) 13.06369*x- 4.932903*x.^2 + 7.154543*x.^3;


% Cell array aoa in rows, wind speeds in columns
load('rawData.mat')

% AoA and Wind speed map of data
[aoaList,VList] = meshgrid([0,5,10,45,90],V([0,.25,.5,.75]));
aoaList = aoaList';
VList = VList';


% Load cell readings to force functions
loadCellRating = 1; %mV/V;
excitementVoltage = 5; %V
maxLoadTorque = 2; % kg
maxLoadThrust = 5; % kg

conversionConstantTo = loadCellRating*excitementVoltage/maxLoadTorque; %mV/kg
conversionConstantTh = loadCellRating*excitementVoltage/maxLoadThrust; %mV/kg

mV2NTo = @(mV) mV/conversionConstantTo*9.81;
mV2NTh = @(mV) mV/conversionConstantTh*9.81;

% Colors for visually distinctive data
colorList = [0,0,0;
    1,0,0;
    0,1,0;
    0,0,1;
    1,1,0];

for ind1 = 1:5
    
    for ind2 = 1:4
        
        leftDataF{ind1,ind2} = mV2NTo(leftDataV{ind1,ind2});
        rightDataF{ind1,ind2} = mV2NTo(rightDataV{ind1,ind2});
        thrustDataF{ind1,ind2} = mV2NTh(thrustDataV{ind1,ind2});
        
        Thrust{ind1,ind2} = thrustDataF{ind1,ind2};
        Drag{ind1,ind2} = leftDataF{ind1,ind2} + rightDataF{ind1,ind2};
        
    end
    
end


for ind1 = 1:5
    % Transform data by applying retroactive calibration. Plot Raw data first
    
    lineColor = colorList(ind1,:);
    
    subplot(1,2,1)
    
    for ind2 = 1:4
        
        % Format data in
        dataX = rpm{ind1,ind2};
        dataY = Drag{ind1,ind2};
        
        line(dataX,dataY,'marker','.','linestyle','none','color',lineColor)
        
        xSample = linspace(0,20000,1000);
        
        fitModel = @(a,x) a(1)*x.^2 + a(2);
        
        p = [dataX.^2 , ones(size(dataX))]\dataY;
        
        fitPlot = fitModel(p,xSample);
        
        line(xSample,fitPlot,'linestyle','-','color',lineColor)
        
        grid on
        
        % Record Data Out
        
        % 2 Sources of calibration error:
        % A baseline error for 0 rpm calibration
        % A secondary error that is a function of rpm
        % We seek to subtract both these out to transform
        
        DragBaseError(ind1,ind2) = p(2);
        
        if ind2 == 1
            rpmFunctionError(ind1) = p(1);
        end
        
    end
    
    % Transform Data
    
    subplot(1,2,2)
    
    for ind2 = 1:4
        
        % Format data in
        dataX = rpm{ind1,ind2};
        dataYOld = Drag{ind1,ind2};
        
        correctionFunction = @(rpm,dataIn) dataIn - rpmFunctionError(ind1)*rpm.^2 - DragBaseError(ind1,ind2);
        
        dataY = correctionFunction(dataX,dataYOld);
        
        DragCalibrated{ind1,ind2} = dataY;
        
        % Replot for visual check
        
        line(dataX,dataY,'marker','.','linestyle','none','color',lineColor)
        
        xSample = linspace(0,20000,1000);
        
        fitModel = @(a,x) a(1)*x.^2 + a(2);
        
        p = [dataX.^2 , ones(size(dataX))]\dataY;
        
        fitPlot = fitModel(p,xSample);
        
        line(xSample,fitPlot,'linestyle','-','color',lineColor)
        
        grid on
        
        RPMDragCoefficient(ind1,ind2) = p(1);
        
    end
    
end

figure(2)

for ind1 = 1:5
    
    lineColor = colorList(ind1,:);
    
    dataX = VList(ind1,:)';
    dataY = RPMDragCoefficient(ind1,:)';
    
    line(dataX,dataY,'marker','.','linestyle','none','color',lineColor)
    grid on
    
    % Apply linear fit to drag coefficients
    
    fitModel = @(a,x) a(1)*x;
    
    p = (dataX)\dataY;
    
    xSample = linspace(0,15,1000);
    
    fitPlot = fitModel(p,xSample);
    
    line(xSample,fitPlot,'linestyle','-','color',lineColor)
    
    aoaDragCoefficient(ind1) = p;
    
end

figure(3)


line(aoaList(:,1),aoaDragCoefficient,'marker','.','linestyle','none','color',[0,0,0])
grid on

dataX = aoaList([1,3,4,5],1);
dataY = aoaDragCoefficient([1,3,4,5])';

fitModel = @(a,x) a(1)*(x - 90);
p = [(dataX - 90) ]\dataY;

% fitModel = @(a,x) a(1)*cosd(x).^3;
% p = [cosd(dataX).^3 ]\dataY;

xSample = linspace(0,90);

fitPlot = fitModel(p,xSample);

line(xSample,fitPlot,'linestyle','-','color',[0,0,0])

%% Alternative simultaneous fit

aoaIndices = [1,3,4];
vIndices = 2:4;

valuesX = [];
valuesY = [];

for ind1 = 1:3
    for ind2 = 1:3
        
        aoaIndex = aoaIndices(ind1);
        vIndex = vIndices(ind2);
        
        valuesX = [valuesX;(aoaList(aoaIndex,vIndex) - 90)*VList(aoaIndex,vIndex)*rpm{aoaIndex,vIndex}.^2];
        valuesY = [valuesY;DragCalibrated{aoaIndex,vIndex}];
    end
end

CD = valuesX\valuesY;

%% Drag functions hardcoded from results

% angle of attack in degrees
D1 = @(rpm,V,aoa)  (-4.3728e-12*(aoa - 90)).*V.*rpm.^2;

D2 = @(rpm,V,aoa)  (CD*(aoa - 90)).*V.*rpm.^2;

%% Manually test the function by comparing to graphs
figure(3)

xSample = linspace(0,90,1000);
f = @(rpm,V,aoa) CD*(aoa - 90);
l1 = line(xSample,f(0,10,xSample) ,'color',[1,0,0]);

%%
figure(2)

xSample = linspace(0,15,1000);
f = @(rpm,V,aoa) CD*(aoa - 90).*V;
l1 = line(xSample,f(0,xSample,45) ,'color',[1,0,0]);


%%
figure(1)
subplot(1,2,2)

f = @(rpm,V,aoa) CD*(aoa - 90).*V.*rpm.^2;
xSample = linspace(0,20000,1000);
l1 = line(xSample,D2(xSample,10,45),'color',[1,0,0]);






