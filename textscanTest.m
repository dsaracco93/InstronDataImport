%Main Script
%{
Calls the following files:
    Cell2Arr.m
    PlotData.m
    ClosestNumber.m
%}

[filename, pathname] = uigetfile({'*.csv'},'Pick a file',...
    'multiselect','on');
if isempty(filename) 
    return %end script if nothing was selected
end

%Make all filenames class = cell
if ischar(filename)
    filenameCell = cellstr(filename);
else 
    filenameCell = filename;
end

%determine units to use with plot
XUnits = char(input('units of deflection?','s'));
YUnits = char(input('units of Load?','s'));

%Plot data
F = figure;

%create empty variables to prevent changing var size as script iterates.
myLegend = cell(1,length(filenameCell));
CreateEmpty = zeros(1,length(filenameCell));
x1 = CreateEmpty;
x2 = CreateEmpty;
y1 = CreateEmpty;
y2 = CreateEmpty;


for i = 1:length(filenameCell)
    [X,Y] = PlotData(filenameCell{i});
    %determine stiffness values HERE and create table
    
    
    [x1(i),y1(i)] = ClosestNumber(0.5,X,Y);
    [x2(i),y2(i)] = ClosestNumber(2.5,X,Y);
   
    plot(X,Y,'DisplayName',' a line');
    hold on
    %legend(filenameCell)
    myLegend{i} = filenameCell{i}(1:strfind(filenameCell{i},'.csv')-1);
   
end
legend(myLegend,'Location','northwest')
xlabel(strcat('Deflection',' (',XUnits,') '))
ylabel(strcat('Load',' (',YUnits,') '))


%Make Stiffness Table

X05 = x1;
X25 = x2;
Y1 = y1;
Y2 = y2;
StiffnessVal = (Y2-Y1)./(X25-X05);
ColumnTitles = {'X05','X25','Y1','Y2','Stiffness'};
StiffnessT = table(X05',X25',Y1',Y2',StiffnessVal',...
    'RowNames',filenameCell','VariableNames',ColumnTitles) %#ok<NOPTS>

%Write table to csv file
csvFilename = 'StiffnessData.csv';
writetable(StiffnessT,csvFilename);
