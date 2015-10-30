classdef RandomDrone < handle
    properties
        bounds
        position
        direction % 0, 1, 2, 3 = N, E, S, W
        deltaToDest
        observing
        rechargeTimer
    end
    methods
        function drone = RandomDrone(boundingBox)
            drone.bounds = boundingBox;
            drone.position = floor(rand(1, 2) .* drone.bounds);
            drone.rechargeTimer = 500 * rand(1);
            drone.observing = 1;
            drone.direction = -1;
            drone.getRandomDirection();   
        end
        function getRandomDirection(drone)
            directions = [];
            if drone.direction ~= 0 && drone.position(2) < drone.bounds(2)
                directions = [directions, 0];
            end
            if drone.direction ~= 2 && drone.position(2) > 0
                directions = [directions, 2];
            end
            if drone.direction ~= 1 && drone.position(1) < drone.bounds(1)
                directions = [directions, 1];
            end
            if drone.direction ~= 3 && drone.position(1) > 0
                directions = [directions, 3];
            end
            dirNum = ceil(rand * length(directions));
            drone.direction = directions(dirNum);
            drone.deltaToDest = mod(drone.direction, 2) * 2 + 1;
        end
        function step(drone, dt)
            drone.checkCharge(dt)
            if drone.isObserving()
                drone.deltaToDest = drone.deltaToDest - 1;
                if drone.deltaToDest == 0
                    drone.updatePosition();
                    drone.getRandomDirection();
                end
            end
        end
        function checkCharge(drone, dt)
            if drone.isObserving()
                drone.rechargeTimer = drone.rechargeTimer + dt;
                if drone.rechargeTimer >= 18000
                    drone.observing = 0;
                end
            else
                drone.rechargeTimer = drone.rechargeTimer - dt*10;
                if drone.rechargeTimer <= 0
                    drone.observing = 1;
                end
            end
        end
        function updatePosition(drone)
            if drone.direction == 0
                drone.position(2) = drone.position(2) + 1;
            elseif drone.direction == 1
                drone.position(1) = drone.position(1) + 1;
            elseif drone.direction == 2
                drone.position(2) = drone.position(2) - 1;
            elseif drone.direction == 3
                drone.position(1) = drone.position(1) - 1;
            end
        end
        function draw(drone, radius)
            pos = [drone.position - radius/2 radius/2 radius/2];
            rectangle('Position', pos, 'Curvature', [1 1], 'FaceColor', 'black')
        end
        function bool = isObserving(drone)
            bool = drone.observing;
        end
    end
end
