% Sarah Burnette
% seburne2@ncsu.edu
% April 15th, 2024
% Lab Section # 209
% Project 3: Earthquakes, Spring 2024
clc; clear; close('all');

% House keeping

% File identifiers, "fid" and "fidu" opened for writing at the beginning of the main
% Script

fid = fopen('World_EQ_report.txt', 'w');

fidu = fopen('USA_EQ_report.txt', 'w');

% Variable, "EQs" defined by student-developed function "getEQsFromFile" to
% Read the data in from 'earthquakesData.csv'

EQs = getEQsFromFile('earthquakesData.csv');

% USA_EQs structure built to include only USA earthquakes via
% Student-developed function, "getUSAEQs()"

USA_EQs = getUSAEQs(EQs);

% Different options for "gui" made

list = {'World', 'USA', 'World Report', 'USA Report'};

% List dialog box/ gui built using a following "switch" statement, "switch"
% Variable named "indx"

[indx,~] = listdlg('ListString',list, 'ListSize',[100,100], 'SelectionMode', 'single');

% Switch Statement 

switch indx

    case 1

        % File identifiers "fid" and "fidu" immediately closed since Case 1
        % Does not deal with reports

        fclose(fid);

        fclose(fidu);

        % Variable "scale" set to 'World' to be used in functions requiring
        % "scale" input

        scale = 'World';

        % Variable "whereToPrint" set to 1, to be used in functions
        % Requiring 'whereToPrint" input, this prints statements to the
        % Command window

        whereToPrint = 1;

        fprintf('Getting the Earthquakes from earthquakesData.csv...\n');

        fprintf('********************************************\nWorld Analysis\n********************************************\n\n');

        fprintf('Finding earthquakes with the largest magnitude\n\n');

        % User-prompted to enter in the number of earthquakes that would
        % Like to see printed to the command window. This information
        % Delivers N number of largest magnitudes/ most powerful
        % Earthquakes

        N = input('How many most powerful earthquakes would you like to see? ');

        fprintf('********************************************\n');

        % Student-developed function "findLargestEQs" defined by largestEQs
        % To print this information to the command window

        largestEQs = findLargestEQs(EQs, N, whereToPrint);

        fprintf('**********************************************\n\n');

        fprintf('Determining earthquakes per each year ...\n\n');

        % User prompted to enter in the range of years that would like to
        % See information graphed on

        yrRange = input('What year range would you like to plot?\n\n(Use brackets around the range)          ');

        fprintf('\nFigure 1: Number of Earthquakes from:    [%d %d]\n', yrRange);

        % Student-developed function "determineEQsPerYear()" to retrieve
        % Information on the number of EQs that happened each year

        EQsPerYear = determineEQsPerYear(EQs);

        % Figure window generated to facilitate delivery of plotted years/
        % Earthquake data

        figure(1);

        plotEQsPerYear(EQsPerYear, yrRange, scale);

        fprintf('\nDetermining earthquakes per each continent ...\n')

        fprintf('\nLoading...\n');

        % Variable "EQsPerContinent" defined by student-developed function
        % "determineNumEQs" to use for following bar graph

        EQsPerContinent = determineNumEQs(EQs, scale, whereToPrint);

        % Figure window "2" generated to display horizontal bar graph of
        % Earthquakes occuring in each continent for all of the world data.

        figure(2);

        plotNumEQs(EQsPerContinent);

        fprintf('\nFigure 2: Bar Graph of the Number of Earthquakes per continent\n\n');

    case 2

        % File identifiers "fid" and "fidu" closed since no reports will be
        % Generated for this case. All printing is done to the command
        % Window.

        fclose(fid);

        fclose(fidu);

        USA_EQs = getUSAEQs(EQs);

        whereToPrint = 1;

        % Variable "scale" immediately set to 'USA' for following functions
        % Requiring input, "scale"

        scale = 'USA';

        fprintf('Getting the Earthquakes from earthquakesData.csv ...\n');

        % The following statements are informative statements detailing
        % operation status in the program. Printed to the command window
        % via "fprintf" command

        fprintf('******************************************\nUSA Analysis\n******************************************\n\n');

        fprintf('Getting only the USA Earthquakes...\n\n');

        fprintf('Finding earthquakes with the largest magnitude\n\n');

        % "N" defined as user input for "findLargestEQs" function

        N = input('How many most powerful earthquakes would you like to see? ');

        largestEQs = findLargestEQs(USA_EQs, N, whereToPrint);

        fprintf('******************************************\n\n');

        fprintf('Determining earthquakes per each year...\n\n\n');

        % Variable "yrRange" defined as user input to direct the range of
        % Years to be plotted

        yrRange = input('What year range would you like to plot?\n\n(Use brackets around the range)          ');

        fprintf('\nFigure 1: Number of Earthquakes from:    [%d %d]\n', yrRange);

        fprintf('\n\nLoading...\n\n\n');

        fprintf('Earthquakes Per State\n');

        % Years/ earthquakes plotted using student-developed function
        % "determineEQsPerYear"

        EQsPerYear = determineEQsPerYear(USA_EQs);

        % Plot earthquake vs year data via student-developed function,
        % "plotEQsPerEYear(x,y,z)"

        plotEQsPerYear(EQsPerYear, yrRange, scale);

        % Determine number of earthquakes per state via the provided
        % Function, "determineNumEQs" defined by variable "EQsPerState" to
        % Be used in the following provided function, "createEQmap"

        EQsPerState = determineNumEQs(USA_EQs, scale, whereToPrint);

        % Figure "2" generated which display a color-coded map of the
        % United States

        figure(2);

        createEQMap(EQsPerState);

    case 3

        fprintf('Getting the Earthquakes from the earthquakesData.csv\n\n');

        fprintf('Report World_EQ_report.txt generated.\n\n');

        % File Identifer "fidu" closed, but file identifier "fid" to remain
        % Open so that the following fprintf statements will print to that
        % File.

        fclose(fidu);

        whereToPrint = fid;

        % "scale" set permanently to 'World' since al of this data will be
        % Printed to the 'World_EQ_report.txt'

        scale = 'World';

        N = 10;

        fprintf(fid,'World Earthquake Report: \n\n');

        fprintf(fid,'Top 10 most powerful Earthquakes:\n******************************************\n\n');

        % 10 of the largest (biggest magnitude) earthquakes are printed to
        % The report

        largestEQs = findLargestEQs(EQs,N,fid);

        fprintf(fid,'******************************************\n');

        fprintf(fid,'Earthquakes per Continent\n');

        EQsPerContinent = determineNumEQs(EQs, scale, whereToPrint);

    case 4

        USA_EQs = getUSAEQs(EQs);

        scale = 'USA';

        % File identifier "fid" closed, but file identifier "fidu" to
        % Remain open as that is where fprintf statements will be printing
        % To for this case -- to the 'USA_EQ_report.txt' file which was
        % Opened for writing at the beginning of this main script.

        fclose(fid);

        % Pre-set N to be 10 which is the number of times data will be
        % Printed to the report. N is permanently 10 for the reports.

        N = 10;

        whereToPrint = fidu;

        fprintf('Getting the Earthquakes from earthquakeData.csv\n\n');

        fprintf('Getting only the USA Earthquakes ...\n\n');

        fprintf('USA_EQ_report.txt generated.\n\n');

        % Print the following statements to file 'USA_EQ)report.txt'
        % Through setting file identifier directory in fprintf statements

        fprintf(fidu,'USA Earthquake Report:\n\n');

        fprintf(fidu,'Top 10 most powerful Earthquakes:\n');

        fprintf(fidu,'******************************************\n');

        % Define largestUS earthquakes with student-developed function,
        % "findLargestEQs" using USA_EQs as input

        largestUS = findLargestEQs(USA_EQs,N,whereToPrint);

        fprintf(fidu,'******************************************\n');

        fprintf(fidu,'\nEarthquakes per State:\n');

        EQsPerState = determineNumEQs(USA_EQs, scale, whereToPrint);

end

% Close all files

fclose('all');



