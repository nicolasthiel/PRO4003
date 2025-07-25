clearvars; clc;

fprintf('---------------------------------------------------------\n');
fprintf('----------------------- PRO4003 -------------------------\n\n');

runExperiment1 = false;
runExperiment2 = true;
runExperiment3 = true;
runExperiment4 = true;
runExperiment5 = true;


% Experiment 1 - gratio
if runExperiment1
    fprintf('Running experiment 1\n');
    axon = PRO4003B2();
    param_values = 0.45:0.05:0.85;
    experiment1 = cell(length(param_values),1);
    temp_mV = cell(length(param_values),1);
    for i=1:length(param_values)
        axon = UpdateInternodeGRatio(axon, param_values(i));
        [MEMBRANE_POTENTIAL, INTERNODE_LENGTH, TIME_VECTOR, CALCIUM_CURRENT, CALCIUM_CONCENTRATION] = Model(axon);
        experiment.name = 'GRatio';
        experiment.value = param_values(i);
        experiment.TIME_VECTOR = TIME_VECTOR;
        experiment.CALCIUM_CURRENT = CALCIUM_CURRENT(:,end);
        experiment.CALCIUM_CONCENTRATION = CALCIUM_CONCENTRATION;
        experiment1{i,1} = experiment;
        tspan = 1:axon.geo.nnodeseg*10:size(MEMBRANE_POTENTIAL,2);
        temp = MEMBRANE_POTENTIAL(:,tspan);
        temp_mV{i} = temp(:,end);
        fig = figure;
        plot(TIME_VECTOR', temp);
        ylim([-100, 100]);
        xlabel('Time, ms')
        ylabel('Membrane potential, mV')
        title([experiment.name ' = ' num2str(experiment.value)])
        saveas(fig, sprintf("plots/experiment1-%d.png", i))
    end
    fig = figure;
    for i=1:length(temp_mV)
        plot(TIME_VECTOR', temp_mV{i}, DisplayName=num2str(param_values(i)));
        hold on;
    end
    hold off;
    ylim([-100, 100]);
    xlabel('Time, ms')
    ylabel('Membrane potential, mV')
    legend('Location','northeastoutside', 'Orientation','vertical')
    title('AP at Last Node for GRatios')
    saveas(fig, 'plots/experiment1-final.png')

    save('data/experiment1.mat', "experiment1");
end


% Experiment 2 - periaxonal space width
if runExperiment2
    fprintf('Running experiment 2\n');
    axon = PRO4003B2();
    param_values = 0:0.5:2; %20
    experiment2 = cell(length(param_values),1);
    temp_mV = cell(length(param_values),1);
    for i=1:length(param_values)
        axon = UpdateInternodePeriaxonalSpaceWidth(axon, param_values(i));
        [MEMBRANE_POTENTIAL, INTERNODE_LENGTH, TIME_VECTOR, CALCIUM_CURRENT, CALCIUM_CONCENTRATION] = Model(axon);
        experiment.name = 'Periaxonal Space Width';
        experiment.value = param_values(i);
        experiment.TIME_VECTOR = TIME_VECTOR;
        experiment.CALCIUM_CURRENT = CALCIUM_CURRENT(:,end);
        experiment.CALCIUM_CONCENTRATION = CALCIUM_CONCENTRATION;
        experiment2{i,1} = experiment;
        tspan = 1:axon.geo.nnodeseg*10:size(MEMBRANE_POTENTIAL,2);
        temp = MEMBRANE_POTENTIAL(:,tspan);
        temp_mV{i} = temp(:,end);
        fig = figure;
        plot(TIME_VECTOR', temp);
        ylim([-100, 100]);
        xlabel('Time, ms')
        ylabel('Membrane potential, mV')
        title([experiment.name ' = ' num2str(experiment.value) 'nm'])
        saveas(fig, sprintf("plots/experiment2-%d.png", i))
    end
    fig = figure;
    for i=1:length(temp_mV)
        plot(TIME_VECTOR', temp_mV{i}, DisplayName=[num2str(param_values(i)) 'nm']);
        hold on;
    end
    hold off;
    ylim([-100, 100]);
    xlabel('Time, ms')
    ylabel('Membrane potential, mV')
    legend('Location','northeastoutside', 'Orientation','vertical')
    title('AP at Last Node for Periaxonal Space Widths')
    saveas(fig, 'plots/experiment2-final.png')

    save('data/experiment2.mat', "experiment2");
end


% Experiment 3 - myelin periodicity
if runExperiment3
    fprintf('Running experiment 3\n');
    axon = PRO4003B2();
    param_values = 15:0.5:17; %17
    experiment3 = cell(length(param_values),1);
    temp_mV = cell(length(param_values),1);
    for i=1:length(param_values)
        axon = UpdateMyelinLamellaPeriodicity(axon, param_values(i));
        [MEMBRANE_POTENTIAL, INTERNODE_LENGTH, TIME_VECTOR, CALCIUM_CURRENT, CALCIUM_CONCENTRATION] = Model(axon);
        experiment.name = 'Myelin Lamella Periodicity';
        experiment.value = param_values(i);
        experiment.TIME_VECTOR = TIME_VECTOR;
        experiment.CALCIUM_CURRENT = CALCIUM_CURRENT(:,end);
        experiment.CALCIUM_CONCENTRATION = CALCIUM_CONCENTRATION;
        experiment3{i,1} = experiment;
        tspan = 1:axon.geo.nnodeseg*10:size(MEMBRANE_POTENTIAL,2);
        temp = MEMBRANE_POTENTIAL(:,tspan);
        temp_mV{i} = temp(:,end);
        fig = figure;
        plot(TIME_VECTOR', temp);
        ylim([-100, 100]);
        xlabel('Time, ms')
        ylabel('Membrane potential, mV')
        title([experiment.name ' = ' num2str(experiment.value) 'nm'])
        saveas(fig, sprintf("plots/experiment3-%d.png", i))
    end
    fig = figure;
    for i=1:length(temp_mV)
        plot(TIME_VECTOR', temp_mV{i}, DisplayName=[num2str(param_values(i)) 'nm']);
        hold on;
    end
    hold off;
    ylim([-100, 100]);
    xlabel('Time, ms')
    ylabel('Membrane potential, mV')
    legend('Location','northeastoutside', 'Orientation','vertical')
    title('AP at Last Node for Myelin Lamella Periodicities')
    saveas(fig, 'plots/experiment3-final.png')

    save('data/experiment3.mat', "experiment3");
end

% Experiment 4 - internode segment diameter
if runExperiment4
    fprintf('Running experiment 4\n');
    axon = PRO4003B2();
    param_values = 2:0.5:4.5;
    experiment4 = cell(length(param_values),1);
    temp_mV = cell(length(param_values),1);
    for i=1:length(param_values)
        axon = UpdateInternodeSegmentDiameter(axon, param_values(i));
        [MEMBRANE_POTENTIAL, INTERNODE_LENGTH, TIME_VECTOR, CALCIUM_CURRENT, CALCIUM_CONCENTRATION] = Model(axon);
        experiment.name = 'Internode Diameter';
        experiment.value = param_values(i);
        experiment.TIME_VECTOR = TIME_VECTOR;
        experiment.CALCIUM_CURRENT = CALCIUM_CURRENT(:,end);
        experiment.CALCIUM_CONCENTRATION = CALCIUM_CONCENTRATION;
        experiment4{i,1} = experiment;
        tspan = 1:axon.geo.nnodeseg*10:size(MEMBRANE_POTENTIAL,2);
        temp = MEMBRANE_POTENTIAL(:,tspan);
        temp_mV{i} = temp(:,end);
        fig = figure;
        plot(TIME_VECTOR', temp);
        ylim([-100, 100]);
        xlabel('Time, ms')
        ylabel('Membrane potential, mV')
        title([experiment.name ' = ' num2str(experiment.value) 'um'])
        saveas(fig, sprintf("plots/experiment4-%d.png", i))
    end
    fig = figure;
    for i=1:length(temp_mV)
        plot(TIME_VECTOR', temp_mV{i}, DisplayName=[num2str(param_values(i)) 'um']);
        hold on;
    end
    hold off;
    ylim([-100, 100]);
    xlabel('Time, ms')
    ylabel('Membrane potential, mV')
    legend('Location','northeastoutside', 'Orientation','vertical')
    title('AP at Last Node for Internode Diameter')
    saveas(fig, 'plots/experiment4-final.png')

    save('data/experiment4.mat', "experiment4");
end

% Experiment 5 - Node length
if runExperiment5
    fprintf('Running experiment 5\n');
    axon = PRO4003B2();
    param_values = 0.5:0.5:2.5;
    experiment5 = cell(length(param_values),1);
    temp_mV = cell(length(param_values),1);
    for i=1:length(param_values)
        axon = UpdateNodeLength(axon, param_values(i));
        [MEMBRANE_POTENTIAL, INTERNODE_LENGTH, TIME_VECTOR, CALCIUM_CURRENT, CALCIUM_CONCENTRATION] = Model(axon);
        experiment.name = 'Node Length';
        experiment.value = param_values(i);
        experiment.TIME_VECTOR = TIME_VECTOR;
        experiment.CALCIUM_CURRENT = CALCIUM_CURRENT(:,end);
        experiment.CALCIUM_CONCENTRATION = CALCIUM_CONCENTRATION;
        experiment5{i,1} = experiment;
        tspan = 1:axon.geo.nnodeseg*10:size(MEMBRANE_POTENTIAL,2);
        temp = MEMBRANE_POTENTIAL(:,tspan);
        temp_mV{i} = temp(:,end);
        fig = figure;
        plot(TIME_VECTOR', temp);
        ylim([-100, 100]);
        xlabel('Time, ms')
        ylabel('Membrane potential, mV')
        title([experiment.name ' = ' num2str(experiment.value) 'um'])
        saveas(fig, sprintf("plots/experiment5-%d.png", i))
    end
    fig = figure;
    for i=1:length(temp_mV)
        plot(TIME_VECTOR', temp_mV{i}, DisplayName=[num2str(param_values(i)) 'um']);
        hold on;
    end
    hold off;
    ylim([-100, 100]);
    xlabel('Time, ms')
    ylabel('Membrane potential, mV')
    legend('Location','northeastoutside', 'Orientation','vertical')
    title('AP at Last Node for Node Length')
    saveas(fig, 'plots/experiment5-final.png')

    save('data/experiment5.mat', "experiment5");
end