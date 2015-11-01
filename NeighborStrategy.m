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
        function stepDrones(obj, drones, map, dt)
            for d = 1:length(drones)
                drones(d).step(map, dt)
            end
        end
    end
end
