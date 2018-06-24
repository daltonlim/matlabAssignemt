function[reversedArray] = Reverse(array)
% Reverse will reverse the order of the elements in a 1d input array.
% E.g [1 2 3] will become [3 2 1] and [1;2;3] will become [3;2;1].
% Input: array = the array to be reversed.
% Output: reversedArray = the reversed array.
% Author: Dalton Lim

% Reverse the array and set it to the output
reversedArray = flip(array);

end
