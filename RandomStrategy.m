classdef RandomStrategy < handle
    properties
        droneCount
    end
    methods
        function strat = RandomStrategy(droneCount)
            strat.droneCount = droneCount;
        end
        function drones = initDrones(obj)
            drones = [];
            for i=1:obj.droneCount
                drones = [drones; RandomDrone([3000 15000])];
            end
        end
        function stepDrones(obj, drones, dt)
            for d = 1:length(drones)
                drones(d).step(dt)
            end
        end
    end
end
