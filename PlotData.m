function [X,Y] = PlotData(filename)

fid = fopen(filename);
try

    RawData = textscan(fid,'%s%s%s','Delimiter',',');

    for i = 1:length(RawData)
        CleanData{i} = strrep(RawData{i},'"','');
        Headers{i} = CleanData{i}(1:2);
        DataTitle(i) = Headers{i}(1);
        DataOnly{i} = CleanData{i}(3:length(CleanData{i}));       
    end
catch
    warning('Error...');
    fclose(fid);
    return
end

fclose(fid);

X = Cell2Arr(DataOnly{2}); % Should be extension values
Y = Cell2Arr(DataOnly{3}); % Should be Load values