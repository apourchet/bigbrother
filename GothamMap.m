classdef GothamMap < handle
    properties
        intersections
        bounds
        nw
        nh
        curr_time
    end

    methods
        function map = GothamMap(nw, nh)
            map.nw = nw;
            map.nh = nh;
            map.bounds = [nw-1, nh-1];
            map.intersections = Intersection.empty([nh * nw, 0]);
            for x=0:(nw-1)
                for y=0:(nh-1)
                    ind = nh * x + y + 1;
                    map.intersections(ind) = Intersection([x y], 15*60);
                end
            end
        end
        function resetIntersections(map)
            curr_time = 0;
            for b=1:length(map.intersections)
                map.intersections(b).reset();
            end
        end
        function intersections = initIntersections(map)
            map.resetIntersections();
            intersections = map.intersections;
        end
        function intersection = getIntersection(map, x, y)
            ind = map.nh * x + y + 1;
            intersection = map.intersections(ind);
        end
        function intersections = getNeighbors(map, x, y)
            if y < map.bounds(2)
                intersections{1} = map.getIntersection(x, y+1);
            else
                intersections{1} = NaN;
            end
            if x < map.bounds(1)
                intersections{2} = map.getIntersection(x+1, y);
            else
                intersections{2} = NaN;
            end
            if y > 0
                intersections{3} = map.getIntersection(x, y-1);
            else
                intersections{3} = NaN;
            end
            if x > 0
                intersections{4} = map.getIntersection(x-1, y);
            else
                intersections{4} = NaN;
            end
        end
        function tickAll(map, currTime)
            for b=1:length(map.intersections)
                map.intersections(b).tick(currTime);
            end
        end
        function update(map, drones, curr_time)
            map.curr_time = curr_time;
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
                map.intersections(b).draw(bw);
            end
        end
        function drawDrones(map, drones)
            for d=1:length(drones)
                drones(d).draw(100);
            end
        end
    end
end
