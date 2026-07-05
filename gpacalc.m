% GPA Calculator;


exitLoop = input("\n\nWould you like to calculate your GPA? (Y/N): ","s");

if exitLoop == "N"

    fprintf("Exiting Program...\n\n\nGoodbye!\n\n\n");

end

while exitLoop == "Y"

    x = [];

    grades = [];

    gpaType = input("\nWould you like to calculate GPA given grades or would you like to see\n\n" + ...
        "what you need to make to achieve a certain GPA? \n\n(1) Calculate GPA Based on Grades\n(2) Calculate Hypothetical Grades Based on a Certain GPA" + ...
        " \n\nPlease enter 1 or 2: ");

    if gpaType == 1

        prevCredits = input("\nHow many credits do you have? ");

        currentGPA = input("\nWhat is your current GPA? ");

        gradePoints = currentGPA * prevCredits;

        currentCredits = input("\nHow many additional credits? ");

        numGrades = input("\nHow many grades would you like to pass through? ");

        if rem(currentCredits,numGrades) == 0

            mrg = [];

            hrg = [];

            bu = currentCredits / numGrades; 

            for i = 1:numGrades

                fprintf("Pass me a grade for class # %d\n", i);

                letterGrade = input("\nPass me a grade: ", "s");

                if letterGrade == "A+"
                    gpa = 4.3;
                elseif letterGrade == "A"
                    gpa = 4;
                elseif letterGrade == "A-"
                    gpa = 3.7;
                elseif letterGrade == "B+"
                    gpa = 3.3;
                elseif letterGrade == "B"
                    gpa = 3;
                elseif letterGrade == "B-"
                    gpa = 2.7;
                elseif letterGrade == "C+"
                    gpa = 2.3;
                elseif letterGrade == "C"
                    gpa = 2;
                elseif letterGrade == "C-"
                    gpa = 1.7;
                elseif letterGrade == "D+"
                    gpa = 1.3;
                elseif letterGrade == "D"
                    gpa = 1;
                elseif letterGrade == "D-"
                    gpa = 0.7;
                else
                    gpa = 0;
                end

                hrg = [hrg,credit];

                hrgs = sum(hrg);

                mrg = [mrg,gpa];

                nrg = hrg .* mrg;

                a = sum(nrg);

                gps1 = a + gradePoints;

                credits1 = hrgs + prevCredits;

                newcum = gps1 / credits1;

                newsemes = a / hrgs;

                newcumcred = prevCredits + currentCredits;

            end


        elseif rem(currentCredits,numGrades) ~= 0

            mrg = [];

            hrg = [];

            for i = 1:numGrades

                fprintf("\nHow many credits are in class #: %d\n", i);

                credit = input("\nEnter # of credits: \n\n");

                fprintf("Pass me a grade for class # %d\n", i);

                letterGrade = input("\nPass me a grade: ", "s");

                if letterGrade == "A+"
                    gpa = 4.3;
                elseif letterGrade == "A"
                    gpa = 4;
                elseif letterGrade == "A-"
                    gpa = 3.7;
                elseif letterGrade == "B+"
                    gpa = 3.3;
                elseif letterGrade == "B"
                    gpa = 3;
                elseif letterGrade == "B-"
                    gpa = 2.7;
                elseif letterGrade == "C+"
                    gpa = 2.3;
                elseif letterGrade == "C"
                    gpa = 2;
                elseif letterGrade == "C-"
                    gpa = 1.7;
                elseif letterGrade == "D+"
                    gpa = 1.3;
                elseif letterGrade == "D"
                    gpa = 1;
                elseif letterGrade == "D-"
                    gpa = 0.7;
                else
                    gpa = 0;
                end

                hrg = [hrg,credit];

                hrgs = sum(hrg);

                mrg = [mrg,gpa];

                nrg = hrg .* mrg;

                a = sum(nrg);

                gps1 = a + gradePoints;

                credits1 = hrgs + prevCredits;

                newcum = gps1 / credits1;

                newsemes = a / hrgs;

                newcumcred = prevCredits + currentCredits;

            end

        end

        fprintf("\nYour new cumulative GPA is: %.3f\n" ,newcum);

        fprintf("\nYour new semester GPA is: %.3f\n", newsemes);

        fprintf("\nYour new cumulative credits is: %.3f\n\n", newcumcred);


        exitLoop = input("\nWould you like to try another scenario? (Y/N): ","s");

        if exitLoop == "N"

            fprintf("\n\n\n\n\n\n\nThank you for using the Sarah GPA Calculator\n\nExiting Program...\n\n\nGoodbye!\n\n\n\n\n\n");

        end


    elseif gpaType == 2

        gpaArray = [0,.7,1,1.3,1.7,2,2.3,2.7,3,3.7,4,4.3];

        idealGPA = input("\nWhat is your cumulative GPA goal? ");

        prevCredits = input("\nHow many credits do you already have? ");

        numberClasses = input("\nHow many classes are you taking? ");

        currentGPA = input("\nWhat is your current GPA? ");

        gradePoints = currentGPA * prevCredits;

        additionalCredits = input("\nHow many additional credits? ");

        credPerClass = additionalCredits/ numberClasses;

        disme = [];

        diffs = input("\nAre credits weighted differently in each class? (Y/N):  ", "s");

        creditsTotal = prevCredits + additionalCredits;

        currentGradePoints = idealGPA * additionalCredits;

        gradePointsTotal = currentGradePoints + gradePoints;

        gpa = (additionalCredits * 4.3 + gradePoints) / (prevCredits + additionalCredits);

        newArray = [];

        if gpa < idealGPA

            fprintf("\nThat GPA goal is not possible given the ratio of credits " + ...
                "with current GPA.\nLet's try for a more realistic goal. \n")
        else

            for u = 1:length(gpaArray)

                newArray = [newArray,gpaArray(u)];

                if (gpaArray(u)* additionalCredits + gradePoints)/ creditsTotal > idealGPA

                    break

                end

            end

            p = 1;

            while p + gradePoints  < idealGPA * creditsTotal

                p = p + .1;

            end

            jr = p / additionalCredits;

            minGPA = newArray(end);

            if jr <= 4.3 && jr >= 4.0
                g = "A+";
            elseif jr < 4.0 && jr >= 3.7
                g = "A";
            elseif jr < 3.7 && jr >= 3.3
                g = "A-";
            elseif jr < 3.3 && jr >= 3.0
                g = "B+";
            elseif jr < 3.0 && jr >= 2.7
                g = "B";
            elseif jr < 2.7 && jr >= 2.3
                g = "B-";
            elseif jr < 2.3 && jr >= 2.0
                g = "C+";
            elseif jr < 2.0 && jr >= 1.7
                g = "C";
            elseif jr < 1.7 && jr >= 1.3
                g = "C-";
            elseif jr < 1.3 && jr >= 1.0
                g = "D+";
            elseif jr < 1.0 && jr >= .7
                g = "D";
            elseif jr < .7 && jr > 0
                g = "D-";
            elseif jr == 0
                g = "F";
            end

            anyCombo = [];

            for i = 1:length(gpaArray)

                if gpaArray(i) >= minGPA

                    anyCombo = [anyCombo,gpaArray(i)];

                end

            end

            xer = [0,0.7,1,1.3,1.7,2,2.3,2.7,3,3.3,3.7,4,4.3];

            club = [];

            br = [];

            cr = [];

            for y = 1:numberClasses

                cr = [cr,xer'];

            end

            bud = nchoosek(xer,numberClasses);

            bud = [bud;cr];

            dub = [];

            z = strings();

            if diffs == "Y"

                for f = 1:numberClasses

                    fprintf("\nEnter number of credits for class %d ", f)

                    hu = input("\n\nEnter here: ");

                    disme = [disme;hu];

                end

                fprintf("\n");

                disme = disme';

                for q = 1:length(disme)

                    for v = 1:length(bud)

                        if sum(bud(v,:) * disme(q)) >= p

                            dub = [dub;bud(v,:)];

                        end

                    end

                end


                if jr == 4.300

                    fprintf("\nThe semester GPA you would need to achieve your ideal \ncumulative GPA of %.3f correlates to the following: %.3f\nwhich means you would need " + ...
                        "to make an A+ in all of your classes.\n", idealGPA, jr);
                else

                    fprintf("\nThe semester GPA you would need to achieve your ideal \ncumulative GPA of %.3f correlates to the following: %.3f, in other words " + ...
                        "\nyou will need to average a(n)  %s or higher which could be any combination of\n" + ...
                        "the following: \n\n\n",idealGPA, jr, g);

                    xer = [0,0.7,1,1.3,1.7,2,2.3,2.7,3,3.3,3.7,4,4.3];

                    club = [];

                    br = [];

                    cr = [];

                    for y = 1:numberClasses

                        cr = [cr,xer'];

                    end

                end


            elseif diffs ~= "Y"


                for k = 1:length(bud)

                    if sum(bud(k,:))/numberClasses < jr

                        club = [club;bud(k,:)];

                    else

                        dub = [dub;bud(k,:)];

                    end

                end

            end


            for r = 1:numel(dub(:,1))

                for n = 1:numberClasses

                    if dub(r,n) == 4.3
                        z(r,n) = "A+";
                    elseif dub(r,n) == 4.0
                        z(r,n)  = "A";
                    elseif dub(r,n) == 3.7
                        z(r,n) = "A-";
                    elseif dub(r,n) == 3.3
                        z(r,n) = "B+";
                    elseif dub(r,n) == 3.0
                        z(r,n) = "B";
                    elseif dub(r,n) == 2.7
                        z(r,n) = "B-";
                    elseif dub(r,n) == 2.3
                        z(r,n) = "C+";
                    elseif dub(r,n) == 2.0
                        z(r,n) = "C";
                    elseif dub(r,n) == 1.7
                        z(r,n) = "C-";
                    elseif dub(r,n) == 1.3
                        z(r,n) = "D+";
                    elseif dub(r,n) == 1.0
                        z(r,n) = "D";
                    elseif dub(r,n) == .7
                        z(r,n) = "D-";
                    elseif dub(r,n) == 0
                        z(r,n) = "F";

                    end

                end

            end

            fprintf("\nThe semester GPA you would need to achieve your ideal \ncumulative GPA of %.3f correlates to the following: %.3f, in other words " + ...
                "\nyou will need to average a(n)  %s or higher which could be any combination of\n" + ...
                "the following: \n\n\n",idealGPA, jr, g);


            for j = 1: numel(z(:,1))

                for h = 1:numberClasses

                    fprintf("\nClass %d: %s     ", h, z(j,h));

                    if h == numberClasses

                        fprintf("\n");

                    end

                end

            end

        end

        exitLoop = input("\nWould you like to try another scenario? (Y/N): ","s");

    end

    if exitLoop == "N"

        fprintf("\n\n\n\n\n\n\n\n\n\nThank you for using the Sarah GPA Calculator!\n\n\nGoodbye!\n\n\n\n");

    end

end






