classdef Block < handle
    properties
        position
        last_observed
        max_unobserved_time
    end
    methods
        function obj = Block(position, max_interval)
            % Constructor
            obj.position = position;
            obj.last_observed = 0;
            obj.max_unobserved_time = max_interval;
        end
        function reset(obj)
            obj.last_observed = 0;
        end
        function draw(obj, width)
            pos = [obj.position width width];
            rectangle('Position', pos, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none');
        end
    end
end