%Import CSV Stiffness Data
%Data must be in the current directory

[filename, pathname] = uigetfile({'*.csv'},'Pick a file',...
    'multiselect','on');

StiffnessPlot = figure
hold on
xlabel('Deflection (mm)')
ylabel('Force (N)')

ForceCol = 3 % Newtons
DeflectCol = 2 % mm

%% Code to import multiple csv files
if length(cellstr(filename)) > 1 

    for i = 1:length(filename)
    
        M = csvread(char(filename(i)),2,0)

        Force = M(:,ForceCol)
        if Force(2) < 0 && Force(length(Force))<0
            PosForce = Force * -1
        else
            PosForce = Force
        end
    
        Deflection = M(:,DeflectCol)
        if Deflection(2) < 0 && Deflection(length(Deflection))<0
            PosDeflection = Deflection * -1
        else PosDeflection = Deflection
        end

        plot(PosDeflection,PosForce,'DisplayName',' a line');
        myLeg{i} = filename{i}(1:findstr(filename{i},'.csv')-1);
   
    end
    legend(myLeg)

%%This Else statement is to enable single file uploads.  
%{ This is because the uigetfile() funct handles variable classes
%differently  file is selected versus 2+ files
%1 filename -> class(filename) = char
%2+ filename -> class(filename) = cell
%input into csvread() must be char
%In hindsight, this is incredibly sloppy... Should have used if class()
%}
else
    M = csvread(filename,2,0)
   
    Force = M(:,ForceCol)
    if Force(2) < 0 && Force(length(Force))<0
        PosForce = Force * -1
    else
        PosForce = Force
    end
    
    Deflection = M(:,DeflectCol)
    if Deflection(2) < 0 && Deflection(length(Deflection))<0
        PosDeflection = Deflection * -1
    else PosDeflection = Deflection
    end
    
    plot(PosDeflection,PosForce,'DisplayName','a line')
    legend(filename)
end
