M = GothamMap(3, 20);
dronecount =  [1 3 5 7 9 10 12 15 17 18 20 22 24 25 26 28 30];
maxOverdues = [];
totalOverdues = [];
for i = 1:1:length(dronecount)
    S = GreedyStrategy(dronecount(i));
    [x, y, max] = simulate(M, S);
    maxOverdues = [maxOverdues max];
    totalOverdues = [totalOverdues y];
end
plot(dronecount, maxOverdues)
xlabel('max');
figure
plot(dronecount, totalOverdues)
xlabel('total');
