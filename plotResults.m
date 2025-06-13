% Number of experiments
num_experiments = 5;

% for i=1:num_experiments
%     temp = load(sprintf("data/experiment%dVes.mat", i));
%     field_names = fieldnames(temp);
%     experiment_data = temp.(field_names{1});
% 
%     % num_experiment_iterations = length(experiment_data);
%     % for j=1:num_experiment_iterations
%     %     experiment_iteration = experiment_data{j,1};
%     %     plotVesicleRelease(experiment_iteration, j, i)
%     % end
% 
%     plotCalciumConcentrations(experiment_data, i);
%     plotCalciumDifference(experiment_data{1}, experiment_data{num_experiment_iterations}, i)
% end

temp = load("data/experiment5Ves.mat");
field_names = fieldnames(temp);
experiment_data = temp.(field_names{1});
plotCalciumDifference(experiment_data{1}, experiment_data{3}, 5)

function plotVesicleRelease(data, iteration, experiment)
    if data.vesicle.startIdx ~= -1
        time = data.TIME_VECTOR';
        calcium_concentration = data.CALCIUM_CONCENTRATION;
        vesicle_release_times = data.vesicle.results.releaseTimes;

        start_time = time(data.vesicle.startIdx);
        vesicle_release_times_scaled = vesicle_release_times + start_time;
        sorted_vesicle_release_times_scaled = sort(vesicle_release_times_scaled);
        if isempty(sorted_vesicle_release_times_scaled)
            end_time = time(end);
        else
            end_time = max(sorted_vesicle_release_times_scaled(end)+1, time(end));
        end
        vesicle_plot_x = [time(1), sorted_vesicle_release_times_scaled, end_time];
        vesicle_plot_y = [0, 1:length(vesicle_release_times_scaled), length(vesicle_release_times_scaled)];

        vesicle_release_prob = length(vesicle_release_times_scaled)./data.vesicle.results.metaData.nVesicleSites;

        fig = figure;
        yyaxis left;
        plot(time, calcium_concentration, 'LineWidth', 1);
        ylabel('Calcium Concentration (µM)');
        hold on;
        dummy = plot(NaN, NaN, 'LineStyle', 'none', 'Marker', 'none');
        yyaxis right;
        stairs(vesicle_plot_x, vesicle_plot_y, 'LineWidth', 1)
        ylabel('Total vesicles released');
        hold off;
        title([data.name ' = ' num2str(data.value)]);
        xlabel('Time (ms)');
        xlim([0, end_time]);
        legend(dummy, ['p_v = ' num2str(vesicle_release_prob)], Location="northwest");
        saveas(fig, sprintf("plots/experiment%d-%dVes.png", experiment, iteration))
    end
end

function plotCalciumConcentrations(data, experiment)
    
    fig = figure;
    for i=1:length(data)
        if data{i}.vesicle.startIdx ~= -1
            time = data{i}.TIME_VECTOR';
            calcium_concentration = data{i}.CALCIUM_CONCENTRATION;
            
            name = [data{i}.name ' = ' num2str(data{i}.value)];
            plot(time, calcium_concentration,'DisplayName', name);
            hold on;
        end
    end
    legend off; 
    %legend('Location', 'northeastoutside');
    xlabel('Time (ms)');
    ylabel('Calcium Concentration (µM)');
    title(['Calcium Concentrations for ' data{1}.name]);
    hold off;
    saveas(fig, sprintf("plots/experiment%dVes.png", experiment))
end

function plotCalciumDifference(data1, data2, experiment)
    if data1.vesicle.startIdx ~= -1 && data2.vesicle.startIdx ~= -1
        start1 = data1.vesicle.startIdx;
        start2 = data2.vesicle.startIdx;
        end1 = data1.vesicle.stopIdx;
        end2 = data2.vesicle.stopIdx;
        start = min(start1, start2);
        finish = max(end1, end2);
        
        calcium_difference = data1.CALCIUM_CONCENTRATION(start:finish) - data2.CALCIUM_CONCENTRATION(start:finish);
        time = data1.TIME_VECTOR(start:finish)';
        total_difference = sum(calcium_difference);

        legend_text = ['Total difference of ' num2str(total_difference)];
        fig = figure;
        plot(time, calcium_difference); hold on;
        yline(0, '--')
        dummy = plot(NaN, NaN, 'LineStyle', 'none', 'Marker', 'none'); hold off;
        
        legend(dummy, legend_text, Location="southwest");
        xlabel('Time (ms)');
        ylabel('Calcium Concentration Difference (µM)');
        xlim([time(1) time(end)])
        name = [data1.name ': Difference between ' num2str(data1.value) ' and ' num2str(data2.value)];
        title(name);
        saveas(fig, sprintf("plots/experiment%dCalDiff.png", experiment))
    end
end