classdef NeighborStrategy < handle
    % Corresponds to strategy 3 in the manuscript
    properties
        droneCount
    end
    methods
        function strat = NeighborStrategy(droneCount)
            strat.droneCount = droneCount;
        end
        function drones = initDrones(strat, map)
            drones = [];
            for i=1:strat.droneCount
                pos = [floor(i/map.nh), mod(i, map.nh)];
                drones = [drones; NeighborDrone(pos, map.bounds)];
            end
        end
        function [intersection, direction] = getUrgentNeighbor(strat, map, position, taken)
            neighbors = map.getNeighbors(position(1), position(2));
            neighbors{5} = map.getIntersection(position(1), position(2));
            weights{5} = -Inf;
            for i=1:4
                n = neighbors{i};
                if ~isempty(neighbors{i}) && ~taken(n.position(1)+1, n.position(2)+1)
                    weights{i} = neighbors{i}.urgency(map.curr_time);
                else
                    weights{i} = NaN;
                end
            end
            [w, p] = max([weights{:}]);
            intersection = neighbors{p};
            direction = p-1;
        end
        function stepDrones(strat, drones, map, dt)
            cache = zeros(map.bounds(1)+1, map.bounds(2)+1);
            for d = 1:length(drones)
                drone = drones(d);
                if drone.isAtIntersection()
                    [i, d] = strat.getUrgentNeighbor(map, drone.position, cache);
                    cache(i.position(1)+1, i.position(2)+1) = 1;
                    drone.setDirection(d);
                end
                drone.step(map, dt)
            end
        end
    end
end
