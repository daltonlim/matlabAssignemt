function[rowNew] = OverallPick(wantedPostition,elevationData,previousColumn)
% OverallPick will pick the coordinate with the smallest overall elevation
% change for a given corordinate,previous column elevation data.
%
% Inputs: wantedPostition = The coordinate which you want to process.
%		  previousColumn = An array representing the minimum overall cost
%                          of traversing to a specified row in the previous
%                          column.
%		  elevationData = The elevation data represented in a 2d mattrix.
% Outputs: RowNew = The row which contains the lowest possible elevation
%                   change for the specified wanted coordinate.
%
% Author: Dalton Lim.

% Find the number of rows in the elvation data
[rowElevationData] = size(elevationData,1);

% Set up the wanted coordinates
rowWanted = wantedPostition(1);

% Set up the rows to search out of one above, the same and one below
% Each requires an offset as the FindSmallestOverallChange returns a
% positive integer, which will be offset by either 1 or 2. E.g. a number
% with the same row will either be  1 or 2 when the
% FindSmallestOverallChange function is run. This means you need to
% minus either 1 or 2 to make it zero.
if rowWanted == 1
    rowsToSearch = [rowWanted,rowWanted+1];
    offset = 1;
elseif rowWanted == rowElevationData
    rowsToSearch = [rowWanted - 1,rowWanted];
    offset = 2;
else
    rowsToSearch = [rowWanted - 1,rowWanted,rowWanted+1];
    offset = 2;
end

% Find row which contains the lowest possible elevation change for the
% wanted coordinate.
rowNew =  rowWanted + FindSmallestOverallChange(wantedPostition,...
    rowsToSearch,previousColumn,elevationData) - offset;
end