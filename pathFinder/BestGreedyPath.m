function [ pathRow,pathCol,pathElev ] = BestGreedyPath( elevationData )
% BestGreedyPath takes a 2d matrix of elevation data and finds the best
% path by finding greedy paths for all coordinates and finding the minimum
% path  cost. It will produce the row and column path taken and the
% elevations for this path.
%
% Inputs: elevationData = The elevation data stored in a 2D matrix.
% Outputs: pathRow = The path taken to get from one side to the other in
%          terms of rows.
%          pathCol = The path taken to get from one side to the other in
%          terms of columns.
%          pathElev = The elevations encountered in this path.
%
% Author: Dalton Lim

% Set the size of the elevation data, its number of rows and columns.
[rowElevationData,colElevationData] = size(elevationData);

count = 0;

% Use one universal pathCol as it will always be the same with the columns
% progressing from 1 to the number of columns.
pathCol= 1:colElevationData;

% Preallocation for faster processing
pathRowsList = zeros(rowElevationData*colElevationData,colElevationData);

%Loop through the rows and columns to find the greedy path for every
%coordinate
for i = 1:rowElevationData
    for j = 1:colElevationData
        count = count+1;
        
        if j >=2 && j<colElevationData
            pathRowsEast= GreedyWalk([i,j],1,elevationData);
            pathRowsWest = GreedyWalk([i,j],-1,elevationData);
            
            % Take the second element of the array onwards otherwise
            % you'll have a repeat of the row coordinate
            pathRowsWestAmmended = pathRowsWest(2:length(pathRowsWest));
            
            % Reverse the shortened array.
            pathRowsWestReversed = Reverse(pathRowsWestAmmended);
            
            % Concatenate the two to create a final row path.
            pathRowsList(count,:) = [pathRowsWestReversed,pathRowsEast];
            
        elseif j == colElevationData
            pathRowsWest = GreedyWalk([i,j],-1,elevationData);
            
            % Reverse the array so it starts from west and moves towards
            % the east.
            pathRowsList(count,:) = Reverse(pathRowsWest);
            
        elseif j== 1
            % Add the Greedy Walk path east onto the array
            pathRowsList(count,:) = GreedyWalk([i,j],1,elevationData);
        end
    end
end

pathRowsLength = size(pathRowsList,1);

%Pre-allocation for faster processing
elevationList = zeros(pathRowsLength,colElevationData);
cost = zeros(pathRowsLength,1);

%Generate the elevations and cost for each row path.
for i = 1:pathRowsLength
    [elevationList(i,:),cost(i,:)]=FindPathElevationsAndCost...
        (pathRowsList(i,:),pathCol,elevationData);
end

%Find the position fo the minimum cost.
[~,positionOfMinValue] = min(cost);

%Set the pathRow and elevations to the path with minimum cost.
pathRow = pathRowsList(positionOfMinValue,:);
pathElev = elevationList(positionOfMinValue,:);
end
