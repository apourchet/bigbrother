classdef NeighborDrone < handle
    properties
        bounds
        position
        direction % 0, 1, 2, 3 = N, E, S, W
        deltaToDest
        observing
        rechargeTimer
    end
    methods
        function drone = NeighborDrone(boundingBox)
            drone.bounds = boundingBox;
            drone.position = floor(rand(1, 2) .* drone.bounds);
            drone.rechargeTimer = 17000 * rand(1);
            drone.observing = 1;
            drone.direction = floor(rand * 4);
        end
        function step(drone, map, dt)
            drone.checkCharge(dt)
            if drone.isObserving()
                drone.deltaToDest = drone.deltaToDest - 1;
                if drone.deltaToDest == 0
                    drone.updatePosition();
                    prevDir = drone.direction;
                    drone.getNextDirection(curr_time);
                    if drone.direction ~= prevDir
                        drone.drainCharge(dt * 1.5);
                    end
                end
            end
        end
        function getNextDirection(drone, map)
            neighbors = map.getNeighbors(drone.position(1), drone.position(2))
            if ~isempty(neighbors{0})
                weights{0} = neighbors{0}.urgency(map.curr_time)
            end
            if ~isempty(neighbors{1})
                weights{1} = neighbors{1}.urgency(map.curr_time)
            end
            if ~isempty(neighbors{2})
                weights{2} = neighbors{2}.urgency(map.curr_time)
            end
            if ~isempty(neighbors{3})
                weights{3} = neighbors{3}.urgency(map.curr_time)
            end
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
