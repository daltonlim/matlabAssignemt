function[pathRows,pathCols]=GreedyWalk(originalCoordinates,number,elevData)
% GreedyWalk will find a path using the greedy algorithm from a set of
% elevation Data from a specified origin to either the east or west edge.
%
% Inputs: originalCoordinates = the starting coordinate.
%         number = a number dictating the direction. 1 means towards the
%                  east while -1 means towards the west.
%         elevData =  a 2d array representing the elevations at
%                          different points.
% Outputs: pathRows = The path taken to get from the original coordinate to
%                     one side in terms of rows.
%          pathCols = The path taken to get from the original coordinate to
%                     one side in terms of columns.
%
% Author: Dalton Lim

% Find the number of columns in the elevation data.
[colElevationData] = size(elevData,2);

% Set up the final columnn to run the greedy pick
if number == 1
    endColumn = colElevationData-1;
elseif number == -1
    endColumn = 2;
end

% Preallocation for speed
pathRows = zeros(1,length(originalCoordinates(2):number:endColumn)+1);
pathCols = zeros(1,length(originalCoordinates(2):number:endColumn)+1);

% Setup original coordinates
pathRows(1) = originalCoordinates(1);
pathCols(1) = originalCoordinates(2);

count = 1;

% Run the GreedyPick function from the originnal coordinate to the last
% column.
for i = pathCols:number:endColumn
    count = count+1;
    originalCoordinates = GreedyPick(originalCoordinates,number,...
        elevData);
    
    % Place the new coordinates into the array.
    pathRows(count) = originalCoordinates(1);
    pathCols(count) = originalCoordinates(2);
    
end
end
