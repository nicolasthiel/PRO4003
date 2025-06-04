function concentration = calcium_concentration(current, X0, tau_X)
    
    t_end = length(current);

    tspan = 1:1:t_end;  % Start and end time

    dXdt = @(t, X) -current(int32(t)) - (X - X0)/(tau_X);

    opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [~, concentration] = ode45(dXdt, tspan, X0, opts);
end