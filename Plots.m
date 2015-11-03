M = GothamMap(100,15);
dronecount = [1 2 4 6 8 10 12 14 16 18 20 23 25];
maxNeighbor = [];
totalNeighbor = [];
for i = 1:1:length(dronecount)
    S = NeighborStrategy(dronecount(i));
    [x, y, max] = simulate(M, S);
    maxNeighbor = [maxNeighbor max];
    totalNeighbor = [totalNeighbor y];
end
plot(dronecount, maxNeighbor)
xlabel('max');
figure
plot(dronecount, totalNeighbor)
xlabel('total');