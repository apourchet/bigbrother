function [total_drones, total_overdue, max_overdue] = simulate(map, strat, draw)
tic;
% HOWTO
% m = GothamMap;
% s = BasicStrategy;
% simulate(s, m)

if nargin < 3
    draw = 0;
end

blocks = map.initIntersections();
drones = strat.initDrones();

dt = 10;
endTime = 3600 * 24;
drawspeed = 10000;
if draw
    figure('Position', [1000, 0, 300, 1500])
    axis([-100 3000 -100 15000]);
end

disp('Starting simulation');
for t=1:dt:endTime
    strat.stepDrones(drones, dt);
    map.update(drones, t);
    if draw
        clf
        axis([-100 3000 -100 15000]);
        map.drawDrones(drones);
        pause(dt/drawspeed);
    end
end

map.tickAll(endTime);

total_drones = length(drones);
total_overdue = 0;
max_overdue = 0;
for b=1:length(map.blocks)
    block = map.blocks(b);
    total_overdue = total_overdue + block.total_unobserved;
    if block.total_unobserved > max_overdue
        max_overdue = block.total_unobserved;
    end
end
total_overdue = total_overdue/3600;
max_overdue = max_overdue/3600;
toc;
