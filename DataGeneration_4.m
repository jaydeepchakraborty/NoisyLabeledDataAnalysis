function DataGeneration_4()

    rng(1);  % For reproducibility
    n = 700; % Number of points per quadrant

    r1 = sqrt(rand(2*n,1));                     % Random radii
    t1 = [pi/2*rand(n,1); (pi/2*rand(n,1)+pi)]; % Random angles for Q1 and Q3
    X1 = [r1.*cos(t1) r1.*sin(t1)];             % Polar-to-Cartesian conversion

    r2 = sqrt(rand(2*n,1));
    t2 = [pi/2*rand(n,1)+pi/2; (pi/2*rand(n,1)-pi/2)]; % Random angles for Q2 and Q4
    X2 = [r2.*cos(t2) r2.*sin(t2)];

    X = [X1; X2];        % Predictors
    Y = ones(4*n,1);
    Y(2*n + 1:end) = 0; % Labels

    total_data = [X,Y];
    ind1 = total_data(:,3) == 1;
    cluster1 = total_data(ind1,:);
    ind2 = total_data(:,3) == 0;
    cluster2 = total_data(ind2,:);

    h = figure();
    h1 = scatter(cluster1(:,1),cluster1(:,2),10,'r.');hold on;
    h2 = scatter(cluster2(:,1),cluster2(:,2),10,'g.');hold on
    legend([h1,h2],'Cluster 1','Cluster 2','Location','NW')
    saveas(h,'Data_4.png');

    
    
    %70-30 data split
    idx = randperm(size(cluster1,1));
    train_cluster1 = cluster1(idx(1:700),:);
    test_cluster1 = cluster1(idx(701:end),:);
    train_cluster2 = cluster2(idx(1:700),:);
    test_cluster2 = cluster2(idx(701:end),:);

    train_data = [train_cluster1;train_cluster2];
    test_data = [test_cluster1;test_cluster2];

    csvwrite('trainData_4.csv',train_data)
    csvwrite('testData_4.csv',test_data)

end
