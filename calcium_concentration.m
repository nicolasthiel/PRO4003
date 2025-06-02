function concentration = calcium_concentration(V_m, r)

% constants
E_rev = 0.043; % V
gamma = 2.76; % pS
F = 96485.33; % C/mol
D = 220; % μm^2/s


concentration = (E_rev - V_m).*gamma./(4.*pi.*F.*D.*r);

end

