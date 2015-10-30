function [total_drones, total_overdue, max_overdue] = simulate(map, strat)
tic;
% HOWTO
% m = GothamMap;
% s = BasicStrategy;
% simulate(s, m)

if nargin < 3
    draw = 0;
end

intersections = map.initIntersections();
drones = strat.initDrones(map);

dt = 10;
endTime = 3600 * 24;
drawspeed = 10000;

toc;
for t=0:dt:endTime
    if mod(100 * t/endTime, 10) == 0
        disp(sprintf('Progress: %d%%', 100 * t/endTime));
    end
    strat.stepDrones(drones, dt);
    map.update(drones, t);
end

map.tickAll(endTime);

total_drones = length(drones);
total_overdue = 0;
max_overdue = 0;
for b=1:length(map.intersections)
    inter = map.intersections(b);
    total_overdue = total_overdue + inter.total_unobserved;
    if inter.total_unobserved > max_overdue
        max_overdue = inter.total_unobserved;
    end
end
total_overdue = total_overdue/3600;
max_overdue = max_overdue/3600;
toc;

