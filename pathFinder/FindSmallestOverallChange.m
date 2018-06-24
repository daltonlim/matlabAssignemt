function[locationOfMinimun] = FindSmallestOverallChange(wantedPostition,...
    rowsToSearch,previousColumn,elevationData)
% FindSmallestOverallChange will help find the location of smallest
% overall change.
% 
% Inputs: wantedPostition = The coordinate which you want to process.
%         rowsToSearch = an array representing the new rows to search.
%		  previousColumn = An array representing the minimum overall cost
%                          of traversing to a specified row in the previous
%                          column.
%		  elevationData = The elevation data represented in a 2d mattrix.
% Outputs: locationOfMinimun = A positive integer representing the position
%                              of the minimum.
% Author: Dalton Lim

%Set up coordinates
wantedRow = wantedPostition(1);
wantedCol = wantedPostition(2);

%Pre-allocation for speed
lengthRowsToSearch = length(rowsToSearch);
overallChange = zeros(1,lengthRowsToSearch);

% Find the overall change for all the possible rows to search.
for i =1:lengthRowsToSearch
    overallChange(i)= previousColumn(rowsToSearch(i))+abs(elevationData...
        (wantedRow,wantedCol)-elevationData(rowsToSearch(i),wantedCol-1));
end

% Find the location of the minimum difference
[~,locationOfMinimun] = min(overallChange);
end
