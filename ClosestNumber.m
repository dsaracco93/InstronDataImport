function [X,Y] = ClosestNumber(ThisNum,SearchThisArray,FindValArray)

L_Array = length(SearchThisArray);
Difference = zeros(1,L_Array);
for i = 1:L_Array
    Difference(i) = abs(SearchThisArray(i)-ThisNum);
end
MinDiff = min(Difference);
IndexMin = abs(Difference)==MinDiff;
X = SearchThisArray(IndexMin);
Y = FindValArray(IndexMin);
    