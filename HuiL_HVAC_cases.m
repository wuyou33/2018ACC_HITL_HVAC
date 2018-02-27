%% HuiL_HVAC_cases
% Script to run the test cases
% Saves test case simulation results in timestamped MAT file.

%% Tuning
caseName = 'Tuning';

results = HuiL_HVAC_mdl_all_sim();

saveCase(caseName, results);    

%% Case 1: cold outside
caseName = 'Case1';

results = HuiL_HVAC_mdl_all_sim(...
    'clothing_t',1, ...
    'activity_t',1, ...
    'in_out_t',1, ...
    'clothing_0', 'pants_jckt', ...
    'activity_0', 'wlk_m', ...
	'T_out', 7, ...
    'IC_source', 1, ...
    'sim_dur',120);

saveCase(caseName, results);

% Case 1 is used for the publication, so create the publication figure
HuiL_HVAC_plot_paper(results);

%% Case 2: warm outside
caseName = 'Case2';

results = HuiL_HVAC_mdl_all_sim(...
    'clothing_t',1, ...
    'activity_t',1, ...
    'in_out_t',1, ...
    'clothing_0', 'pants_jckt', ...
    'activity_0', 'wlk_m', ...
	'T_out', 14, ...
    'IC_source', 1, ...
    'sim_dur',120);

saveCase(caseName, results);

%% Case 3: energy concious 
caseName = 'Case3';

results = HuiL_HVAC_mdl_all_sim(...
    'clothing_t',1, ...
    'activity_t',1, ...
    'in_out_t',1, ...
    'clothing_0', 'pants_jckt', ...
    'activity_0', 'wlk_m', ...
    'xi_5_0', 40, ...
    'xi_5_on', 40, ...
	'T_out', 7, ...
    'IC_source', 1, ...
    'sim_dur',120);

saveCase(caseName, results);

%% Save the resulting data in a timestamped MAT file
function saveCase (caseName, results)
    
    % Create timestamp for file names
    timeStamp = datestr(now(),'yyyymmddHHMMSS');

    fprintf('Saving results from %s at %s\n', caseName, timeStamp);
    
    if ~exist('out','dir')
        mkdir('out');
    end

    % Save figures
    saveas(results.hFig(1), sprintf('out/%s_%s_SCT.fig', timeStamp, caseName));
    saveas(results.hFig(2), sprintf('out/%s_%s_T.fig', timeStamp, caseName));
    
    % Remove the figure handles before saving to avoid the following warning
    %   "Saving graphics handle variables can cause the creation of very
    %   large files. To save graphics figures, use savefig."
    results.hFig = [];
    save(sprintf('out/%s_%s.mat', timeStamp, caseName), 'results');
end
