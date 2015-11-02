classdef NeighborDrone < handle
    properties
        bounds
        position
        direction % 0, 1, 2, 3, 4 = N, E, S, W, NOTHING
        deltaToDest
        observing
        rechargeTimer
    end
    methods
        function drone = NeighborDrone(position, boundingBox)
            drone.bounds = boundingBox;
            drone.position = position;
            drone.rechargeTimer = 17000 * rand(1);
            drone.observing = 1;
            drone.direction = 4;
            drone.deltaToDest = 0;
        end
        function step(drone, map, dt)
            drone.checkCharge(dt)
            if drone.isObserving()
                drone.deltaToDest = drone.deltaToDest - 1;
                if drone.deltaToDest == 0
                    drone.updatePosition();
                end
            end
        end
        function setDirection(drone, d)
            prevDir = drone.direction;
            drone.direction = d;
            if prevDir ~= drone.direction

            end
            drone.deltaToDest = mod(drone.direction, 2)*2 + 1;
        end
        function bool = isAtIntersection(drone)
            bool = (drone.deltaToDest == 0);
        end
        function drainCharge(drone, dt)
            drone.rechargeTimer = drone.rechargeTimer + dt;
        end
        function recharge(drone, dt)
            drone.rechargeTimer = drone.rechargeTimer - dt*10;
        end
        function checkCharge(drone, dt)
            if drone.isObserving()
                drone.drainCharge(dt);
                if drone.rechargeTimer >= 18000
                    drone.observing = 0;
                end
            else
                drone.recharge(dt);
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
