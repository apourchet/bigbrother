classdef GreedyStrategy < handle
    % Corresponds to strategy 3 in the manuscript
    properties
        droneCount
    end
    methods
        function strat = GreedyStrategy(droneCount)
            strat.droneCount = droneCount;
        end
        function drones = initDrones(strat, map)
            drones = [];
            for i=1:strat.droneCount
                pos = [floor(rand * map.nw), floor(rand * map.nh)];
                drones = [drones; NeighborDrone(pos, map.bounds)];
            end
        end
        function [intersection, direction] = getMostUrgent(strat, map, position, taken)
            maxWeight = -Inf;
            for i=1:length(map.intersections)
                inter = map.intersections(i);
                if ~taken(inter.position(1)+1, inter.position(2)+1)
                    distance = 3*abs(inter.position(1) - position(1)) + abs(inter.position(2) - position(2));
                    urgency = inter.urgency(map.curr_time);
                    if distance ~= 0 && urgency/distance > maxWeight
                        maxWeight = urgency/distance;
                        intersection = inter;
                    end
                end
            end
            if intersection.position(2) ~= position(2)
                if intersection.position(2) > position(2)
                    direction = 0;
                else
                    direction = 2;
                end
            else
                if intersection.position(1) > position(1)
                    direction = 1;
                else
                    direction = 3;
                end
            end
        end
        function stepDrones(strat, drones, map, dt)
            cache = zeros(map.bounds(1)+1, map.bounds(2)+1);
            for d = 1:length(drones)
                drone = drones(d);
                if drone.isAtIntersection()
                    [i, d] = strat.getMostUrgent(map, drone.position, cache);
                    cache(i.position(1)+1, i.position(2)+1) = 1;
                    drone.setDirection(d);
                end
                drone.step(map, dt)
            end
        end
    end
end
