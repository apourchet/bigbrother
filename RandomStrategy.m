classdef RandomStrategy < handle
    properties
        droneCount
    end
    methods
        function strat = RandomStrategy(droneCount)
            strat.droneCount = droneCount;
        end
        function drones = initDrones(strat, map)
            drones = [];
            for i=1:strat.droneCount
                drones = [drones; RandomDrone(map.bounds)];
            end
        end
        function stepDrones(obj, drones, map, dt)
            for d = 1:length(drones)
                drones(d).step(dt)
            end
        end
    end
end
