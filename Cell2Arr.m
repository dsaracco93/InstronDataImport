%Use this Script to make all string lengths the same to enable cell2mat
%Input needs to be a "cell" type with an array full of 'char type

function [ReadyToPlot] = Cell2Arr(CellData)

%determine length of data to ensure all values have the same num of str's
%This is needed to enable the cell2mat funct to work
L_first = length(CellData{1});
L_Data = L_first - 1;
L_vector = length(CellData);

for i = 1:L_vector  % loop through the inputted cell
    Output{i} = CellData{i}(1:L_Data);
end

OutputTranspose = Output';
OutputChar = cell2mat(OutputTranspose);
ReadyToPlot = str2num(OutputChar);
%exported values are numeric type values which can be plotted