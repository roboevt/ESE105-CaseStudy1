% labels the data in the "testing" group (based on nearest neighbors to a finalized set of centroids and 
% centroid labels). Note that the finalized centroids should be designed through the use of the script 
% cluster covid data.m

% Note - This script depends on cluster_covid_data.m to be run first.

close all
load("competition.mat")

% Label the testing data:
transformedTestingCases = (A * testingCases')';

testing_labels = zeros(height(transformedTestingCases), width(transformedTestingCases));
for i = 1:height(transformedTestingCases)
    testCase = transformedTestingCases(i,:);

    [~, assignedCentroid] = min(pdist2(centroids,testCase, 'euclidean'));
    testing_labels(i,:) = centroid_labels(assignedCentroid);
    disp("Test case " + i + " assigned to division " + centroid_labels(assignedCentroid));
end