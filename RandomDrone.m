classdef RandomDrone < handle
    properties
        bounds
        position
        range
        goal
        speed
        observing
        rechargeTimer
    end
    methods
        function obj = RandomDrone(boundingBox)
            obj.range = 80;
            obj.speed = 7;
            obj.bounds = boundingBox;
            obj.position = rand(1, 2) .* obj.bounds;
            obj.goal = rand(1, 2) .* obj.bounds;   
            obj.rechargeTimer = 500 * rand(1);
            obj.observing = 1;
        end
        function step(obj, dt)
            dest = obj.goal;
            dir = obj.goal - obj.position;
            dir = dir/norm(dir);
            dir = dir * obj.speed * dt;
            newpos = obj.position + dir;
            if norm(obj.position - dest) < obj.speed * dt
                obj.position = dest;
                obj.goal = rand(1, 2) .* obj.bounds;
            else
                obj.position = newpos;
            end
            if obj.isObserving()
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
