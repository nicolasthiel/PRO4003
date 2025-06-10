clearvars; clc;

fprintf('---------------------------------------------------------\n');
fprintf('----------------------- PRO4003 -------------------------\n\n');

axon = PRO4003B2();
% adjust axon here
fprintf('Running model');
[MEMBRANE_POTENTIAL, INTERNODE_LENGTH, TIME_VECTOR, CALCIUM_CURRENT, CALCIUM_CONCENTRATION] = Model(axon);
writematrix([TIME_VECTOR(2:end)', CALCIUM_CONCENTRATION], 'data/concentration.csv');