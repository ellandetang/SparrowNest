clear
close all

% New version of Free vortex wake to better handle multiple bodies and have
% less reliance on a priori quantities like number of panels

% Switched to struct array based system

% V3 incorporated moving surface functionality

% Useful Rotation Functions
rotX = @(th) [1 0 0;
    0 cos(th), -sin(th);
    0 sin(th), cos(th)];

rotY = @(th) [cos(th),0, sin(th);
    0,1,0;
    -sin(th),0, cos(th)];

rotZ = @(th) [cos(th) -sin(th) 0;
    sin(th) cos(th) 0;
    0 0 1];

rho = 1.225; % air density kg/m^3

% Define Environment
simulation.U = [-1,0,0]'; % Free stream velocity vector, m/s
simulation.Umag = norm(simulation.U); % Forward flight speed m/s
simulation.dt = .05; % Time step time (s)
simulation.nT = 100; % Number of time steps
simulation.TF = simulation.dt*simulation.nT;

simulation.startPoints = [];
simulation.endPoints = [];
simulation.Gamma = [];
simulation.Rc = [];

omega = [0 0 0]'*pi/30; % Rotaional speed, rad/s

bodyIndex = 0;
% defineWing1
% defineWing2
definePropBlade1
% defineHeavingWing1

% Propagate through time
for ind2 = 1:simulation.nT
    % Define current simulation time
    simulation.time = (ind2-1)*simulation.dt;
    
    % Select filaments to use to reduce computation time
    simulation.selectedFilaments = find(abs(simulation.Gamma) > .01*max(abs(simulation.Gamma)));
    
    body = updateBody(body,simulation);
    
    % Compile Results for next step
    simulation.startPoints = [];
    simulation.endPoints = [];
    simulation.Gamma = [];
    simulation.Rc = [];
    
    for ind3 = 1:length(body)
        simulation.startPoints = [simulation.startPoints, body(ind3).FixedStartPoints,body(ind3).FreeStartPoints,body(ind3).CrossStartPoints];
        simulation.endPoints = [simulation.endPoints, body(ind3).FixedEndPoints,body(ind3).FreeEndPoints,body(ind3).CrossEndPoints];
        simulation.Gamma = [simulation.Gamma, body(ind3).FixedGamma,body(ind3).FreeGamma,body(ind3).CrossGamma];
        simulation.Rc = [simulation.Rc, body(ind3).FixedRc, body(ind3).FreeRc, body(ind3).CrossRc];
    end
    
    clf
    plotResults(body)
    %keyboard
    fprintf('Step %i of %i \n',ind2,simulation.nT)
end

plotResults(body)