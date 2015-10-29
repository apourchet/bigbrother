function simulate(strat, map, draw)
% HOWTO
% m = GothamMap;
% s = BasicStrategy;
% simulate(s, m)

if nargin < 3
    draw = 1;
end

map.resetBlocks();
blocks = map.initBlocks();
drones = strat.initDrones();

dt = 10;
endTime = 3600 * 24;
drawspeed = 10000;
if draw
    figure('Position', [1000, 0, 300, 1500])
    axis([-100 3000 -100 15000]);
end

disp('Starting simulation');
for i=1:endTime
    strat.stepDrones(drones, dt);
    map.update(drones, i * dt);
    if draw
        clf
        axis([-100 3000 -100 15000]);
        map.drawDrones(drones);
        pause(dt/drawspeed);
    end
end

map.tickAll(endTime);
