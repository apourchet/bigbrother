classdef GothamMap < handle
    properties
        intersections
    end

    properties (Constant)
        nw = 6; % # of intersections in width
        nh = 30; % # of intersections in height
    end

    methods
        function map = GothamMap()
            map.intersections = Intersection.empty([GothamMap.nh * GothamMap.nw, 0]);
            for x=0:(GothamMap.nw-1)
                for y=0:(GothamMap.nh-1)
                    ind = GothamMap.nh * x + y + 1;
                    map.intersections(ind) = Intersection([x y], 15*60);
                end
            end
        end
        function resetIntersections(map)
            for b=1:length(map.intersections)
                map.intersections(b).reset();
            end
        end
        function intersections = initIntersections(map)
            map.resetintersections();
            intersections = map.intersections;
        end
        function intersection = getIntersection(map, x, y)
            ind = GothamMap.nh * x + y + 1;
            intersection = map.intersections(ind);
        end
        function tickAll(map, currTime)
            for b=1:length(map.intersections)
                map.intersections(b).tick(currTime);
            end
        end
        function update(map, drones, curr_time)
            for d=1:length(drones)
                drone = drones(d);
                if drone.isObserving()
                    observed = map.getIntersection(drone.position(1), drone.position(2));
                    observed.observe(curr_time);
                end
            end
        end
        function drawintersections(map)
            for b=1:length(map.intersections)
                map.intersections(b).draw(GothamMap.bw);
            end
        end
        function drawDrones(map, drones)
            for d=1:length(drones)
                drones(d).draw(100);
            end
        end
    end
end
