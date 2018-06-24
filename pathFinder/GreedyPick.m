function[newCoordinates] = GreedyPick(originalCoordinates,number,elevData)
% GreedyPick will pick the coordinate with the smallest elevation change 
% for a given corordinate, direction and elevation data.
% 
% Inputs: originalCoordinates = the starting coordinates represented by 
%                               the array [row, column].
%         number = a number dictating the direction. 1 means towards the
%                  east while -1 means towards the west.
%         elevData = the elevation data in a 2d matrix.
% Outputs: newCoordinates = a 1x2 array containg the new coordinate with 
%                           the lowest difference.
% 
% Author: Dalton Lim

% Find the number of rows in the elvation data
[rowElevationData] = size(elevData,1);

% Set up the original coordinates
rowOrigin = originalCoordinates(1);
colOrigin = originalCoordinates(2);

% Set up the rows to search out of one above, the same and one below
% Each requires an offset as the findSmallestElevationChange returns a 
% positive integer, which will be offset by either 1 or 2. E.g. a number
% with the same row will either be 1 or 2 when the 
% FindSmallestElevationChange function is run. This means you need to
% minus either 1 or 2 to make it zero.
if rowOrigin == 1
    rowsToSearch = [rowOrigin,rowOrigin+1];
    offset = 1;
elseif rowOrigin == rowElevationData
    rowsToSearch = [rowOrigin - 1,rowOrigin];
    offset = 2;
else
    rowsToSearch = [rowOrigin - 1,rowOrigin,rowOrigin+1];
    offset = 2;
end

% Find the rows with the smallest elevations changes
positionOfMinima = FindSmallestElevationChange(elevData...
       (rowOrigin,colOrigin),elevData(rowsToSearch,colOrigin+number));
   
% Find the new row using the northmost path
rowNew = rowOrigin - offset + positionOfMinima(1);

% Find new coordinates given the direction to pick from.
newCoordinates = [rowNew,colOrigin+number];

end