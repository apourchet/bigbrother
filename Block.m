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
            obj.max_unobserved_time = max_interval;
        end
        function draw(obj, width)
            pos = [obj.position width width];
            rectangle('Position', pos)
        end
    end
end
