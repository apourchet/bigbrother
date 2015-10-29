function simulate(strat, map, draw)
% HOWTO
% m = GothamMap;
% s = BasicStrategy;
% simulate(s, m)

if nargin < 3
    draw = 1;
end

drones = strat.initDrones();
blocks = map.initBlocks();

dt = 10;
drawspeed = 10000;
if draw
    figure('Position', [1000, 0, 300, 1500])
    axis([-100 3000 -100 15000]);
end

disp('Starting simulation');
for i=1:3600*24
    strat.stepDrones(drones, dt);
    map.update(blocks, drones);
    if draw
        clf
        axis([-100 3000 -100 15000]);
        map.drawDrones(drones);
        pause(dt/drawspeed);
    end
end
