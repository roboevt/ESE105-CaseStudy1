% 3.1 Lab Practice
close all
load('COVIDbyCounty.mat')

% 3.1.1 Most populus country per division
numDivisions = max(CNTY_CENSUS.DIVISION);

%Initialize arrays
maxPopulationCovidCases = zeros(numDivisions,size(CNTY_COVID, 2));
maxPopulationCntys = cell(numDivisions, 1);

%Fill arrays
for i = 1:numDivisions
    [maxPopulationCovidCases(i,:), maxPopulationCntys(i)] = ... 
        covidOFMaxPopOfDIvision(CNTY_CENSUS, CNTY_COVID, i);
end

%Plot Data
plot(dates, maxPopulationCovidCases');
title("Weekly Covid Cases for Most Populus County in Each Divisions of the United States")
xlabel("Time")
ylabel("Cases")
legend(maxPopulationCntys);

% 3.1.2 Linearly Independent?

% Check every combination of vectors
for i = 1:numDivisions
    for j = 1:numDivisions
        if(i ~= j) % Of course a vector is linearly dependent with itself
            cases1 = maxPopulationCovidCases(i,:);
            cases2 = maxPopulationCovidCases(j,:)';
            angle = acos(cases1 * cases2) / (norm(cases1) * norm(cases2));
            if(angle == 0)
                disp("Covid cases of most populus county in each division are not linearly independent!")
                break;
            end
        end
    end
end

% 3.1.3 Normalize
d = normalize(maxPopulationCovidCases, 2, "norm");

% 3.1.4 St Louis City Case Data

idx = strcmp(CNTY_CENSUS.CTYNAME, "St. Louis city");
c = CNTY_COVID(idx,:);

% ri = c − (cTdi)di
r = repmat(c, numDivisions, 1) - d.*(d*c');
rNorm = vecnorm(r,2,2);

%Function Definitions:

% Find the most populus county in each division and return it's name and weekly covid cases.
function [cases, cntyName] = covidOFMaxPopOfDIvision(CNTY_CENSUS, CNTY_COVID, div)
    idx = CNTY_CENSUS.DIVISION == div;
    divisionRows = CNTY_CENSUS(idx,:);
    [~,idx] = max(divisionRows.POPESTIMATE2021);
    row = divisionRows(idx,:);
    idx = strcmp(CNTY_CENSUS.CTYNAME, row.CTYNAME) & ...
        CNTY_CENSUS.POPESTIMATE2021==row.POPESTIMATE2021;
    cases = CNTY_COVID(idx,:);
    cntyName = CNTY_CENSUS.CTYNAME(idx);
end