classdef Intersection < handle
    properties
        position
        last_observed
        last_tick
        max_unobserved
        total_unobserved
    end
    methods
        function inter = Intersection(position, max_interval)
            % Constructor
            inter.position = position;
            inter.last_observed = 0;
            inter.last_tick = 0;
            inter.total_unobserved = 0;
            inter.max_unobserved = max_interval;
        end
        function reset(inter)
            inter.last_observed = 0;
            inter.total_unobserved = 0;
            inter.last_tick = 0;
        end
        function tick(inter, curr_time)
            if curr_time - inter.last_observed > inter.max_unobserved
                delta = curr_time - max(inter.last_tick, inter.last_observed + block.max_unobserved);
                inter.total_unobserved = inter.total_unobserved + delta;
            end 
            inter.last_tick = curr_time;
        end
        function observe(inter, curr_time)
            inter.tick(curr_time);
            inter.last_observed = curr_time;
        end
        function draw(inter, width)
        end
    end
end
