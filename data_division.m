% NOTE Moved into cluster_covid_data.m

close all
load('COVIDbyCounty.mat'); % load data

trainingData = sortrows(CNTY_CENSUS, 3, "ascend"); % Sort by division
% Count counties number in each division
for i = 1 : 9
    quantities = 0;
    for j = 1 : 225
        if trainingData.DIVISION(j) == i
            quantities = quantities + 1;
        end
    end
    disp("Division " + i + " has " + quantities + " counties");
end



test = 5; % How any test samples
for div = 1 : 9
    for i = 1 : test
        rand = int32(randi([1,25 - (i - 1)])); % find a random number from 1 to 25 - (i - 1)
        testingData((div - 1) * test + i, :) = trainingData((div - 1) * 20 + rand,:); % Find the random row and assign it to testing data 
        trainingData((div - 1) * 20 + rand, : ) = []; % Remove the testing data from training data table
    end 
end