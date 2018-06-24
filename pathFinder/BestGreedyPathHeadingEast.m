function [ pathRow,pathCol,pathElev ] = BestGreedyPathHeadingEast(elevData)
% BestGreedyPathHeadingEast takes a 2d matrix of elevation data and finds
% the best path starting from a row in the first column using greedy walk.
% It will produce the row and column path taken and the elevations for
% this path.
%
% Inputs: elevData = The elevation data stored in a 2D matrix
% Outputs: pathRow = The path taken to get from one side to the other in
%                    terms of rows.
%          pathCol = The path taken to get from one side to the other in
%                    terms of columns.
%          pathElev = The elevations encountered in this path.
%
% Author: Dalton Lim

%Set the size of the elevation data, its number of rows and columns
[rowElevationData,colElevationData] = size(elevData);

% Set a universal column path as it will always proceed from left to right
pathCol = 1:colElevationData;

% Pre-allocation for speed
elevations = zeros(rowElevationData,colElevationData);
cost = zeros(rowElevationData,1);
pathRowList = zeros(rowElevationData,colElevationData);

% Run thorugh the rows, with each path starting at the first column and
% proceding east
for i = 1:rowElevationData
    [pathRowList(i,:),~] = GreedyWalk([i,1],1,elevData);
    
    % Find the elevations for each path and the total cost for traversing
    % this path
    [elevations(i,:),cost(i,:)] = FindPathElevationsAndCost...
        (pathRowList(i,:),pathCol,elevData);
end

% Find the position of the minimum value
[~,positionOfMinValue] = min(cost);

% Set the pathRow ans elevation to the path with the lowest cost.
pathRow = pathRowList(positionOfMinValue,:);
pathElev = elevations(positionOfMinValue,:);

end
