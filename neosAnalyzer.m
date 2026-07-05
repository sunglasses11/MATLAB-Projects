% Sarah Burnette
% seburne2@ncsu.edu
% February 6th, 2024
% Lab Section: 209
% Project 1: NEOs and Fireballs Analysis, Spring 2024
clc ; clear ; close('all');
%% User Input

% "Close all" to remove Figure Window from previous run

% User Input Question to determine which data set will be used,
% FireballsData.xlsx or neosData.xlsx. Variable "answer" used as switch
% Variable.

answer = input('Analyze Options\n    (1) Near Earth Objects\n    (2) Fireballs\nEnter Option:  ');

%% Switch Statement/ Load neosData.xlsx

% Switch statement to route the correct data set and engage the
% Appropriate path depending on which selection the user makes for
% Variable, "answer"

switch answer
    case 1

        % Loading data set 'neosData.xlsx' via built-in command,
        % "readmatrix()" into variable, "loadneos"

        loadneos = readmatrix('neosData.xlsx');

        %% Indexing of Neos Data

        % General house keeping/ pre- indexing to index pertinent columns:
        % Diameters, Distances, and Years
        % Conversion of given data for distances from astronomical units to
        % Kilometers
        % Indexing to retrieve and remove columns so that only the Years column and Diameters column are left

        yrnDiams = loadneos(:,3:7);
        yrnDiams(:,2:4) = [];
        distnDiams = loadneos(:,4:7);
        distnDiams(:,2:3) = [];
        diamNeos = distnDiams(:,2);
        distNeos = distnDiams(:,1);

        % Conversion factor = 1.496 * 10^8 km = 1 astronomical unit

        convertDist = distNeos.*1.496*10.^8;

        % Horizontal Concatenation

        newDistDiamMat = [convertDist,diamNeos];

        % Use of built- in function, "mean()" to find the average of both NEOs
        % Distances and Diameters

        NewDisDiaAvg = mean(newDistDiamMat);
        minDisDia = min(newDistDiamMat);
        maxDisDia = max(newDistDiamMat);
        disDiaAvg = mean(distnDiams);

        % Indexing only the Years column

        yr = yrnDiams(:,1);

        % Indexing only the Diameters column

        diamtrs = yrnDiams(:,2);

        %% Logic/ Logical Indexing

        % Using Boolean math/ logic to create specified bounds for "Big
        % NEOs" and "Biggest NEOs" ( Big NEOs are bigger than 1000 meters and
        % Less than or equal to 2000 meters. The Biggest NEOs are equal to or bigger
        % Than 2000 meters

        BigNEOs = (diamtrs > 1000 & diamtrs <= 2000);
        BiggestNEOs = (diamtrs >= 2000);

        % Logical Indexing into the Years column to find correlating years
        % With specified bounds and designating these as the parameters for
        % The plot graph

        yrElim2 = yr(BiggestNEOs);
        yrElim1 = yr(BigNEOs);

        % Designating the parameters/ inputs for the plot graph

        graph1 = diamtrs(BigNEOs);
        graph2 = diamtrs(BiggestNEOs);

        % Creating a matrix of relevant Distances, Diameters, and Averages
        % So that it may be used as input for fprintf statement. I used one
        % Variable, one matrix, to sub into my %f/ %d placeholders.
        % Transposing so that when the fprintf statement loads data, it
        % Will read correctly down each column.

        %% Concatenation/ Indexing/ Built-in Commands

        NewAvgMatT  = NewDisDiaAvg';

        % Transposing

        minDisDiaT = minDisDia';
        maxDisDiaT = maxDisDia';

        % Vertical Concatenation to create new matrix/ manipulate how mat is read in fprintf
        % Since it prints by going down the columns.

        mat = [NewDisDiaAvg;maxDisDia;minDisDia];
        newmat = mat';

        % Using built-in commands min() and max() to retrieve the minimum
        % Distances of already-converted distances and the largest diameter

        closest = min(convertDist);
        Biggestneo = max(diamNeos);

        neomat = [yr,diamNeos,convertDist];

        % [just, fun] and [ok,again] to call the [value,index] of the
        % Minimum and maximum values of distances and diameters.

        [just,fun] = min(convertDist);
        [ok,again] = max(diamNeos);

        % Indexing into different columns to find relevant information that
        % correlates with the pre-determined condition by the aforementioned min()
        % And max() functions assigned to variables: rep, repp, rep2, reppi

        rep = yr(fun);
        repp = convertDist(again);
        rep2 = yr(again);
        reppi = diamNeos(fun);

        % Creation of matrix mat2fit to substiutute into fprintf statement
        % Transposing matrix so that the fprintf statement reads the matrix
        % Columns correctly

        mat2fit = [rep,just,reppi;rep2,repp,ok];
        dearmat = mat2fit';

        %%  Print NEOs Data Statistics to Command Window/ Plot Graphs

        fprintf('***************************************************************************\nAnalyzing Near-Earth Objects (NEOs)\n***************************************************************************\t\tStatistics:\t\tAvg,\t\tMax,\t\tMin\nDistance from Earth (km):\t  %.2f,\t %.2f, \t  %.2f\t\t  \t \n   \t    Diameter (m):            %.2f, \t    %.2f,          %.2f\t \t\t\n***************************************************************************\nClosest NEO: Year %d, %.2f  km from Earth, Diameter %.2f m\nBiggest NEO: Year %d, %.2f km from Earth, Diameter %.2f m\n',mat,dearmat);

        % Plotting Figure 1 of NEOs data in two different subplots, the
        % Top, "Near-Earth Objects by Year" and the bottom, "Largest
        % Near-Earth Objects"

        % "figure(1)" to introduce a figure window/ name it as Figure 1.
        % "subplot(# of rows, # of columns, position # in the column (top
        % (1) and bottom (2)

        figure(1);
        subplot(2,1,1);

        % Using "histogram" so that we may input the number of bins to represent,
        % In this case 6 bins will be shown.

        histogram(yr,6);
        xlabel('Year');
        ylabel('Number of NEOs');
        title('Near-Earth Objects by Year');

        % Plot of bottom subplot in Figure 1 representing "Big" and
        % "Biggest" diameters of NEOs by Year. Legend in top right to
        % Include a red circle which shows the occurence of NEOs with
        % Diameters larger than 2000 meters and a black asterick to show
        % Diameters larger than 1000 meters and smaller than or equal to
        % 2000 meters

        % "subplot(# of rows, # of columns, position within column. This
        % Subplot will be on the bottom of the figure as it is give a
        % Position (2 rows, 1 column, 2, second position within that
        % Column)

        subplot(2,1,2);

        % 'K*' to specify style markers, k for color: black, * for style of plotted
        % Point, in this case * draws an asterick. Use of "plot" command to
        % Designate the type of plot. "plot() may be used for scatter plots
        % As well as scatter()

        plot(yrElim1,graph1,'k*');

        % "hold on" to specify that two graphs will be plotted on the same subplot,
        % One on top of the other

        hold on

        % "xlabel()" and "ylabel()" to name the x-axis and y-axis, respectively

        xlabel('Year');
        ylabel('Diameter (m)');
        title('Largest Near-Earth Objects');

        % Using "plot" to assign the top of graph that will be shown, in this case
        % A scatter plot

        plot(yrElim2,graph2,'ro');

        % "legend() to create a small legend in the top right corner of the graph
        % To represent the marker styles and colors for easy-readability

        legend('1000 < Diamter <= 2000','2000 < Diamter');

        % "grid on" to have a grid only in the bottom sublot, "Largest Near-Earth
        % Objects"

        grid on;

        %% Load Fireballs data, fireballsData.xlsx/ Index

    case 2


        % Variable, "fload" assigned to data that has been read via readmatrix()
        % Command with file, fireballsData.xlsx.

        fload = readmatrix('fireballsData.xlsx');

        % Indexing information from the fireballs data set.
        % variable, alt, represents altitudes; variable "energy" represents impact
        % Energies and variable, "year" represents the column with years data.
        % Variable, "month" used to index the months that each measure occured
        % Regarding altitudes and energies of the fireballs.

        alt = fload(:,5);
        energy = fload(:,8);
        year = fload(:,1);
        month = fload(:,2);

        % Indexing using [value, index] to return the value of minimum altitudes
        % And correlating index. This is used to find botht the minimum altitudes
        % And the maximum energies occured and the "index" variable is then used to
        % Further index into the year column to retrieve relevant year information
        % So that accurate data may be printed to the command window.

        [hi,bye] = min(alt);
        [hola,adios] = max(energy);

        % Using logical indexing to index back into other columns to find relevant
        % Information based on the built-in commands min() and max() that
        % We used. These values will be used to print information about the
        % Lowest altitude and highest energy of the fireballs to the
        % Command window.

        yrfb = year(adios);
        yrfb1 = year(bye);
        endex = energy(bye);
        endex1 = alt(adios);

        % A matrix, "fbmat" is created and will be then transposed, due to how the 
        % Columns are read top to bottom first and then to the right and used as the
        % Input in fprintf statement. This can also be done
        % By inputting each individual variable at the end the fprintf
        % Display quotes where the inputs for the "%" placeholders are stored

        fbmat = [yrfb1,hi,endex;yrfb,endex1,hola];
        fbmatfix = fbmat';

        %% Print Fireball Statistics to Command Window

        fprintf('***************************************************************************\nAnalyzing Fireballs\n****************************************************************************\n\nFireball Statistics\n----------------------\nLowest Altitude: Year %d, %.2f km from Earth, %.2f kt\n Highest Energy: Year %d, %.2f km from Earth, %.2f kt\n\nPlotting Fireballs\n----------------------\n',fbmatfix);

        % Variable, "selection," is created so that the user may decide which year
        % That the user would like to view in the following plotted graph.

        selection = input('Select a year from 1997 to 2023: ');

        % Variable, "var," is created for if/else statement to run effectively and
        % Use for Boolean operations/ logic.

        var = 2023;

        % If the user chooses the exact year, 2023, then the code will pull data
        % Out of the Altitude/ Month/ Energy columns and plot data associated only
        % With the year 2023.

        if selection == var

            % "if/else" statement to set the first condition, or "branch" for the code
            % To go through

            plotalt = alt(year == 2023);
            plotmonth = month(year == 2023);
            plotenergy = energy(year == 2023);

            % If the user chooses a year other than 2023, then the code will
            % Pull data only associated with that exact year from Altitude/ Month/
            % Energy columns. This is executed only after the "else" statment.

        else
            plotalt = alt(year == selection);
            plotmonth = month( year == selection);
            plotenergy = energy(year == selection);
        end

        %% Plot Altitudes/ Impact Energies

        % A figure is plotted with two subplots, the top contatining information
        % About the altitude of the fireballs and the bottom containing information
        % About the impact energy of the fireballs of the year that the user has
        % Selected, (between 1997 and 2023)

        figure(1);
        subplot(2,1,1);

        % Indexed information, "plotmonth" and "plotalt" will plot the occurences
        % Of the altitudes of selected year in the months in which they occurred.
        % Style markers "black (k) astericks (*) are used in the top subplot with a
        % Slightly larger size specified by "'MarkerSize',10"

        plot(plotmonth,plotalt,'k*','MarkerSize',10);
        grid on
        title('Altitude of the Fireballs');
        ylabel('Altitude (km)');

        % "xticks(1:12)" is used to relate the months labeled in "xticklabels"
        % (Jan,Feb,Mar,Apr,etc.) to the data from the indexed column, "Months" that
        % Range from 1 to 12

        xticks(1:12);
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
        subplot(2,1,2);

        % A bottom subplot plots data about the impact energies of the fireballs
        % And the month in which they occurred, "plotmonth." Red (r) diamond
        % markers are assigned with a marker size of 10, which is slightly bigger
        % than the default

        plot(plotmonth,plotenergy,'rdiamond','MarkerSize',10);
        title('Impact Energy of the Fireballs');
        ylabel('Impact Energy (kt)');
        xticks(1:12);

        % "xticklabels" is used to provide the corresponding display (the names of the months) to the
        % designated number of ticks, in this case one through 12.

        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
        grid on
end

% End of code



































