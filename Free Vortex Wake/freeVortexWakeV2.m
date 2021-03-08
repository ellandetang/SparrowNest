clear
close all

% New version of Free vortex wake to better handle multiple bodies and have
% less reliance on a priori quantities like number of panels

% Switched to struct array based system

% Useful Rotation Function
rotZ = @(theta) [cos(theta) -sin(theta) 0;
    sin(theta) cos(theta) 0;
    0 0 1];

rho = 1.225; % air density kg/m^3

% Define Environment
simulation.U = [-1,0,0]'; % Free stream velocity vector, m/s
simulation.Umag = norm(simulation.U); % Forward flight speed m/s
simulation.dt = .2; % Time step time (s)
simulation.nT = 100; % Number of time steps

simulation.startPoints = [];
simulation.endPoints = [];
simulation.Gamma = [];
simulation.Rc = [];

omega = [0 0 0]'*pi/30; % Rotaional speed, rad/s

defineWing1
defineWing2

% Propagate through time
for ind2 = 1:simulation.nT
    
    % Select filaments to use to reduce computation time
    simulation.selectedFilaments = find(abs(simulation.Gamma) > .01*max(abs(simulation.Gamma)));
    
    body = updateBody(body,simulation);

    % Compile Results for next step
    simulation.startPoints = [body(1).FixedStartPoints,body(1).FreeStartPoints,body(1).CrossStartPoints,...
        body(2).FixedStartPoints,body(2).FreeStartPoints,body(2).CrossStartPoints];
    simulation.endPoints = [body(1).FixedEndPoints,body(1).FreeEndPoints,body(1).CrossEndPoints,...
        body(2).FixedEndPoints,body(2).FreeEndPoints,body(2).CrossEndPoints];
    simulation.Gamma = [body(1).FixedGamma,body(1).FreeGamma,body(1).CrossGamma,...
        body(2).FixedGamma,body(2).FreeGamma,body(2).CrossGamma];
    simulation.Rc = [FixedRc,body(1).FreeRc,body(1).CrossRc,...
        FixedRc,body(2).FreeRc,body(2).CrossRc];
    
end

plotResults(body)