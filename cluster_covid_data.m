%eparates the data into "training" and “testing” groups, uses kmeans clustering 
% on the “training” group, and results in the construction of k centroids

close all
load('COVIDbyCounty.mat')

[idx, C] = kmeans(CNTY_COVID, 9);

CNTY_CENSUS.DIVISION(idx==2)

test = movmean(CNTY_COVID, 50);

% Prototype idea for determinging optimal k and w.
for w=5:50
    for k=9:20
        data = movmean(CNTY_COVID, w)
        [idx, C, sumd] = kmeans(data, k);
        error[w,k] = cost(sumd)
    end
end

plot(test')