%eparates the data into "training" and “testing” groups, uses kmeans clustering 
% on the “training” group, and results in the construction of k centroids

close all
load('COVIDbyCounty.mat');

minK = 1;  %K-means k value (number of clusters)
maxK = 30;
minW = 1;  % Block average window length
maxW = 50;

K = minK:maxK;
W = minW:maxW;

costs = zeros(maxK-minK, maxW-minW);

for w = W
    for k = K
        A = generateBlockAverageMatrix(length(dates), w);
        transformedCovidCases = A * CNTY_COVID';

        [idx, C,sumd] = kmeans(transformedCovidCases, k);
        cost = sum(sumd);
        costs(k-minK+1,w-minW+1) = cost;
    end
end

bar3(costs)

% xlim([W(1)-1,W(end)+1])
set(gca,'XTick', W)
% ylim([K(1)-1,K(end)+1])
set(gca,'YTick', K)

title("Error Across Various K Values and Window Lengths")
ylabel("K-means k")
xlabel("Window Length")
zlabel("Sum of sumd")

% [idx, C,sumd] = kmeans(CNTY_COVID, 9);
% 
% CNTY_CENSUS.CTYNAME(idx==2)


% Prototype idea for determinging optimal k and w.
% for w=5:50
%     for k=9:20
%         data = movmean(CNTY_COVID, w)
%         [idx, C, sumd] = kmeans(data, k);
%         error[w,k] = cost(sumd)
%     end
% end


function A = generateBlockAverageMatrix(n, window)
    block = ones(1,window)/window;
    A=zeros(n-window,n);
    for i = 1:n-window+1
        row = [zeros(1,i-1), block, zeros(1,n-i-window+1)];
        A(i,:) = row;
    end
end