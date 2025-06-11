temp = load(sprintf("data/experiment%dVes.mat", 1));
field_names = fieldnames(temp);
experiment_data = temp.(field_names{1});

num_experiment_iterations = length(experiment_data);
for i=1:1
    experiment_iteration = experiment_data{i,1};
    plotVesicleRelease(experiment_iteration, sprintf("experiment1-%d", i))
end

plotCalciumConcentrations(experiment_data);


function plotVesicleRelease(data, experiment_name)
    if data.vesicle.startIdx ~= -1
        time = data.TIME_VECTOR';
        calcium_concentration = data.CALCIUM_CONCENTRATION;
        vesicle_release_times = data.vesicle.results.releaseTimes;

    
        start_time = time(data.vesicle.startIdx);
        vesicle_release_times_scaled = vesicle_release_times + start_time;
        figure;
        plot(time, calcium_concentration);
        hold on;
        xline(vesicle_release_times_scaled);
        hold off;
        title(experiment_name);
        xlabel('Time (s)');
        ylabel('Calcium Concentration (µM)');
    end
end

function plotCalciumConcentrations(data)
    
    figure;
    for i=1:length(data)
        if data{i}.vesicle.startIdx ~= -1
            time = data{i}.TIME_VECTOR';
            calcium_concentration = data{i}.CALCIUM_CONCENTRATION;
            
            path_string = [data{i}.name '.value.ref'];
            path_parts = strsplit(path_string, '.');
            value = getfield(data{i}.axon, path_parts{2});
            for j=3:length(path_parts)
                value = getfield(value, path_parts{j}); 
            end
            name = [path_parts{end-2} '=' num2str(value)];
            plot(time, calcium_concentration,'DisplayName', name);
            hold on;
        end
    end
    legend show;
    legend('Location', 'northwest');
    title('Calcium Concentrations Across Experiments');
    hold off;
end