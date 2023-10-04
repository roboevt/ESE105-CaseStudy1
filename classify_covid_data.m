% labels the data in the "testing" group (based on nearest neighbors to a finalized set of centroids and 
% centroid labels). Note that the finalized centroids should be designed through the use of the script 
% cluster covid data.m

% Note - This script depends on cluster_covid_data.m to be run first.

close all

% Create the centroid labels based on the most common division in each
% cluster
centroid_labels = zeros(bestK,1);
for centroid = 1:bestK
    cluster = centroidIdx == centroid;
    centroid_labels(centroid) = mode(trainingCensus.DIVISION(cluster));
    disp("Centroid " + centroid + " assigned to division " + centroid_labels(centroid))
end

% Label the testing data:
transformedTestingCases = (A * testingCases')';

testing_labels = zeros(height(transformedTestingCases), width(transformedTestingCases));
for i = 1:height(transformedTestingCases)
    testCase = transformedTestingCases(i,:);

    [~, assignedCentroid] = min(pdist2(centroids,testCase, 'euclidean'));
    testing_labels(i,:) = centroid_labels(assignedCentroid);
end