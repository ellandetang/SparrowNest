function V = sampleVelocity(simulation,samplePoints)
    
    V = batchBiotSavart_mex(simulation.startPoints,simulation.endPoints,simulation.Gamma,simulation.Rc,samplePoints);

end