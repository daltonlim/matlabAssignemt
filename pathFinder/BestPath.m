function[pathRow,pathCol,pathElev] = BestPath(elevationData)
% BestPath takes a 2d matrix of elevation data and finds the best path
% by finding the shortest paths for all coordinates moving column by column
% and finding the minimum path to each coordinate. 
% It will produce the row and column path taken and the elevations at this 
% path.
%
% This code is based on Dijkstra's algorithm
% source:https://brilliant.org/wiki/dijkstras-short-path-finder/
%
% Inputs: elevationData = The elevation data in a 2D matrix.
% Outputs: pathRow = The path taken to get from one side to the other in
%          terms of rows.
%          pathCol = The path taken to get from one side to the other in
%          terms of columns.
%          pathElev = The elevations encountered in this path.
%
% Author: Dalton Lim

% Set up some variables like the number of rows and columns in the 
% elevation data
rowElevationData = size(elevationData,1);
colElevationData = size(elevationData,2);

% Setup the overall change for the first column which will be zero as 
% the elevation change to the first column will be zero
previousColumnOverallChange = zeros(rowElevationData,1);

% Set up the column path for the first row
previousColumnPath = [1:rowElevationData]';

% Run this loop for every row before moving onto the next column
for wantedCol = 2:colElevationData
    for wantedRow = 1:rowElevationData
        
        % Pick the row which has the lowest overall change
        rowNew = OverallPick([wantedRow,wantedCol],elevationData ...
            ,previousColumnOverallChange);
        
        % Set up a variable representing the rowpath to the wanted
        % coordinate
        rowPathToWanted = [previousColumnPath(rowNew,:),wantedRow];
        
        % Generate a new array which contains the row path to the wanted
        % coordinate
        newPreviousColumnPath(wantedRow,:) = rowPathToWanted;
        
        %Find the path cost for the newly found row path to the wanted
        %coordinate
        [~,pathCost] = FindPathElevationsAndCost(rowPathToWanted ...
            ,(1:wantedCol),elevationData);
        
        % Place the path cost in an array so that you can compare later
        newPreviousColumnOverallChange(wantedRow,1) = pathCost;
    end
    
    % Set the old values to new ones so that the loop can continue
    previousColumnOverallChange = newPreviousColumnOverallChange;
    previousColumnPath = newPreviousColumnPath;
    
    clear newPreviousColumnPath
end

% Find the postition of the minimum.
[~,positionOfMinimum] = min(newPreviousColumnOverallChange);

% Find the pathRow,pathCol and pathElev at the minimum.
pathRow = previousColumnPath(positionOfMinimum,:);
pathCol = 1:colElevationData;
pathElev = FindPathElevationsAndCost(pathRow,pathCol,elevationData);
end