% Main script

map = GothamMap(6, 30);
droneCounts = [3 5 10 20 30 50 75 100];
results = zeros(length(droneCounts), 3);
for d=1:length(droneCounts)
    count = droneCounts(d);
    strat = RandomStrategy(count);
    tic;
    [a, b, c] = simulate(map, strat, false);
    toc;
    results(d, :) = [a, b, c];
end

