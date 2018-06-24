function [ elevations,pathCost ] = FindPathElevationsAndCost( pathRows,...
    pathCols,elevationData )
% FindPathElevationsAndCost will find the elevations for a specified path
% and total path cost for a given path represented by two 1 d arrays for
% the row path and column path and a 2d array representing elevation data.
%
% Inputs: pathRows = The path taken to get from one point to another in
%                    terms of rows.
%         pathCols = The path taken to get from one point to another in
%                    terms of columns taken.
%		  elevationData = The elevation data in a 2D matrix.
% Outputs: elevations = The elevations encountered in this path.
% 		   pathCost = The sum of the differences in elevation or the total
%                     path cost.
%
% Author: Dalton Lim

lengthPathRows = length(pathRows);

% Pre-allocation for  speed
elevationDiff = zeros(1,lengthPathRows-1);
elevations = zeros(1,lengthPathRows);

%Find the elevation for each row and colum coordinate in pathRows and
% pathCols
for i = 1:lengthPathRows
    elevations(i) = elevationData(pathRows(i),pathCols(i));
end

%Loop through all the elevation data and find the absolute difference.
for j = 1:(lengthPathRows-1)
    elevationDiff(j) = abs(elevations(j)-elevations(j+1));
end

%Find the path cost by adding together all of the elevation differences
pathCost = sum(elevationDiff);

end

