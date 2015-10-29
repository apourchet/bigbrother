classdef Drone < handle
    properties
        position
        range
        path
        speed
    end
    methods
        function obj = Drone(position, range, speed, path)
            obj.position = position;
            obj.range = range;
            obj.speed = speed;
            obj.path = path;
        end
        function step(obj, dt)
            dest = obj.path(1, :);
            dir = obj.path(1, :) - obj.position;
            dir = dir/norm(dir);
            dir = dir * obj.speed * dt;
            newpos = obj.position + dir;
            if norm(obj.position - dest) < obj.speed * dt
                obj.position = dest;
                obj.path = [obj.path(2:end, :); dest];
            else
                obj.position = newpos;
            end
        end
        function draw(obj, radius)
            pos = [obj.position - radius/2 radius/2 radius/2];
            rectangle('Position', pos, 'Curvature', [1 1])
        end
    end
end
