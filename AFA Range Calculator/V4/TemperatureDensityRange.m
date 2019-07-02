clear
close all

globalVariableDefinition_forV4


g = 9.80665; % Gravity acceleration
R_d = 287.058; % Specific Gas Constant for dry air
R_v = 461.495; % Specific Gas Constant for water vapor

h0 = 0; % Reference Altitude (sea level)
h = 1000*12*.0254; % Present Altitude
p0 = 101325; % Sea Level Pressure

TList = (linspace(60,120,10)-32)*5/9 + 273.15;
phiList = linspace(0,1,10);

% T = 15 + 273.15; % temperature in Kelvin
% phi = 1; % Relative humidity
[T,phi] = meshgrid(TList,phiList);



p = p0*exp(-g*(h-h0)./(R_d*T));

p_sat = 6.102*10.^(7.5*(T - 273.15)./(T - 273.15 + 237.8))*100;

p_v = phi.*p_sat;

p_d = p - p_v;

rhoList = p_d./(R_d*T) + p_v./(R_v*T);

for SuperInd1 = 1:length(phiList)
    for SuperInd2 = 1:length(TList)
        
        disp([num2str(SuperInd1/length(phiList)), ' ', num2str(SuperInd2/length(TList))])
        
        rho = rhoList(SuperInd1,SuperInd2);
        
        EnergyCalculationV4_forGrid
        
        CalculatedRangeList(SuperInd1,SuperInd2) = CalculatedRange;
        
    end 
end

%%
load('DensityVsRange.mat')

[T,phi] = meshgrid(TList,phiList);

surf(T-273.15,phi,CalculatedRangeList/1000)
xlabel('Temperature (degrees C)')
ylabel('Relative Humidity')
zlabel('Estimated Range (km)')
view(50.978453038674019,43.463551401869161)
colorbar

