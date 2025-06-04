function Project()
    % Directory of this file
    thisDirectory = fileparts(mfilename('fullpath'));
    
    % Choose a location to save simulation results.
    saveDirectory = fullfile(thisDirectory, 'Ford2015Results');
    if ~isdir(saveDirectory)
        mkdir(saveDirectory)
    end

    
end