% Add path of Vesicle Model
addpath("../SytSim_Matlab/");

num_experiments = 2;

run_experiment = {true, false};

threshold_calcium_concentraion = 1e-4;

for i=1:num_experiments
    if run_experiment{i}
        fprintf('Running experiment %d...\n', i);
    
        temp = load(sprintf("data/experiment%d.mat", i));
        field_names = fieldnames(temp);
        experiment_data = temp.(field_names{1});
    
        num_experiment_iterations = length(experiment_data);
        for j=1:num_experiment_iterations
            fprintf('  |-iteration %d...\n', j);

            experiment_iteration = experiment_data{j,1};
            
            if any(abs(experiment_iteration.CALCIUM_CONCENTRATION) > 0.1 + threshold_calcium_concentraion)

                calcium_change_idx_start = find(abs(experiment_iteration.CALCIUM_CONCENTRATION) > 0.1 + threshold_calcium_concentraion, 1, 'first');
                calcium_change_idx_finish = find(abs(experiment_iteration.CALCIUM_CONCENTRATION) > 0.1 + threshold_calcium_concentraion, 1, 'last');
                
                if (calcium_change_idx_start ~= calcium_change_idx_finish) % sanity check

                    calcium_time_series = [experiment_iteration.TIME_VECTOR(calcium_change_idx_start:calcium_change_idx_finish)', experiment_iteration.CALCIUM_CONCENTRATION(calcium_change_idx_start:calcium_change_idx_finish)];
                    
                    vesicle_results = run_simulation('CaTimeSeries', calcium_time_series);
                    
                    experiment_iteration.vesicle.startIdx = calcium_change_idx_start;
                    experiment_iteration.vesicle.stopIdx = calcium_change_idx_finish;
                    experiment_iteration.vesicle.results = vesicle_results;
                    experiment_data{j,1} = experiment_iteration;
                else
                   fprintf('    |-CALCIUM_CURRENT is zero throughout.\n');
                    experiment_iteration.vesicle.startIdx = -1;
                    experiment_iteration.vesicle.stopIdx = -1;
                    experiment_iteration.vesicle.results = -1;
                    experiment_data{j,1} = experiment_iteration;
                end
            else
                fprintf('    |-CALCIUM_CURRENT is zero throughout.\n');
                experiment_iteration.vesicle.startIdx = -1;
                experiment_iteration.vesicle.stopIdx = -1;
                experiment_iteration.vesicle.results = -1;
                experiment_data{j,1} = experiment_iteration;
            end
        end

        save(sprintf("data/experiment%dVes.mat", i), "experiment_data");
    end
end