classdef Block < handle
    properties
        position
        last_observed
        last_tick
        max_unobserved
        total_unobserved
    end
    methods
        function obj = Block(position, max_interval)
            % Constructor
            obj.position = position;
            obj.last_observed = 0;
            obj.last_tick = 0;
            obj.total_unobserved = 0;
            obj.max_unobserved = max_interval;
        end
        function reset(obj)
            obj.last_observed = 0;
            obj.total_unobserved = 0;
            obj.last_tick = 0;
        end
        function tick(block, curr_time)
            if curr_time - block.last_observed > block.max_unobserved
                delta = curr_time - max(block.last_tick, block.last_observed + block.max_unobserved);
                block.total_unobserved = block.total_unobserved + delta;
            end 
            block.last_tick = curr_time;
        end
        function observe(block, curr_time)
            block.tick(curr_time);
            block.last_observed = curr_time;
        end
        function draw(obj, width)
            pos = [obj.position width width];
            rectangle('Position', pos, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none');
        end
    end
end
