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
                drones = [drones; NeighborDrone(map.bounds)];
            end
        end
        function [intersection, direction] = getUrgentNeighbor(strat, map, position, taken)
            neighbors = map.getNeighbors(position(1), position(2));
            weights = cell(1, 4);
            for i=1:4
                weights{i} = -Inf;
            end
            for i=1:4
                n = neighbors{i};
                if ~isempty(neighbors{i}) && ~taken(n.position(1)+1, n.position(2)+1)
                    weights{i} = neighbors{i}.urgency(map.curr_time);
                elseif ~isempty(neighbors{i})
                    weights{i} = [NaN];
                else
                    weights{i} = -Inf;
                end
            end
            [w, p] = max([weights{:}]);
            intersection = neighbors{p};
            direction = p-1;
        end
        function stepDrones(strat, drones, map, dt)
            cache = zeros(map.bounds(1)+1, map.bounds(2)+1);
            for d = 1:length(drones)
                drone = drones(d)
                drone.step(map, dt)
                if drone.isAtIntersection()
                    [i, d] = strat.getUrgentNeighbor(map, drone.position, cache);
                    cache(i.position(1)+1, i.position(2)+1) = 1;
                    drone.direction = d;
                end
            end
        end
    end
end
