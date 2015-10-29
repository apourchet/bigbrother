classdef BasicStrategy < handle
    
    methods
        function drones = initDrones(obj)
            drones =[Drone([0 0], 1, 1, [0 1000; 0 0]);
                Drone([0 0], 1, 1, [1000 1000; 0 0]);
                Drone([2000 2000], 1, 1, [2500 2000; 2500 2500; 2000 2500; 2000 2000])
            ];
        end
        function stepDrones(obj, drones, dt)
            for d = 1:length(drones)
                drones(d).step(dt)
            end
        end
    end
end
