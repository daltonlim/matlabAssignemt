function[locationOfMinima] = FindSmallestElevationChange...
    (currentElevation,possibleChoices)
% FindSmallestElevationChange will help find the locations of the elevation
% with the smallesst change in height.
%
% Inputs: currentElevation = The current elevation at the coordinate
%         possibleChoices = an array representing the new elevation
%         					choices.
% Outputs: locationOfMinima = An array representing the position(s)
%                             of the minima.
%
% Author: Dalton Lim

% Generate an array with the absolute difference between the current
% elevation and all possible choices
differences = abs(currentElevation-possibleChoices);

% Find the locations with the minimum difference
locationOfMinima = find(differences==min(differences));

end