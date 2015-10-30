classdef Drone < handle
    properties
        position
        range
        path
        speed
        observing
        rechargeTimer
    end
    methods
        function obj = Drone(position, path)
            obj.position = position;
            obj.range = 80;
            obj.speed = 7;
            obj.path = path;
            obj.rechargeTimer = 500 * rand(1);
            obj.observing = 1;
        end
        function step(obj, dt)
            if obj.isObserving()
                dest = obj.path(1, :);
                dir = dest - obj.position;
                dir = dir/norm(dir);
                dir = dir * obj.speed * dt;
                newpos = obj.position + dir;
                if norm(obj.position - dest) < obj.speed * dt
                    obj.position = dest;
                    obj.path = [obj.path(2:end, :); dest];
                else
                    obj.position = newpos;
                end
                obj.rechargeTimer = obj.rechargeTimer + dt;
                if obj.rechargeTimer >= 18000
                    obj.observing = 0;
                end
            else
                obj.rechargeTimer = obj.rechargeTimer - dt*10;
                if obj.rechargeTimer <= 0
                    obj.observing = 1;
                end
            end
        end
        function draw(obj, radius)
            pos = [obj.position - radius/2 radius/2 radius/2];
            rectangle('Position', pos, 'Curvature', [1 1], 'FaceColor', 'black')
        end
        function bool = isObserving(obj)
            bool = obj.observing;
        end
    end
end
