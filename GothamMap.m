classdef GothamMap < handle
    properties
        blocks
    end

    properties (Constant)
        bw = 100; % BLOCK WIDTH
        bh = 100; % BLOCK HEIGHt
        nw = 30; % # of blocks in width
        nh = 150; % # of blocks in height
    end

    methods
        function obj = GothamMap()
            obj.blocks = Block.empty([GothamMap.nh * GothamMap.nw, 0]);
            for x=0:(GothamMap.nw-1)
                for y=0:(GothamMap.nh-1)
                    obj.blocks(GothamMap.nh*x + y + 1) = Block([x*GothamMap.bw y*GothamMap.bh], 15*60);
                end
            end
        end
        function resetBlocks(obj)
            for b=1:length(obj.blocks)
                obj.blocks(b).reset();
            end
        end
        function blocks = initBlocks(obj)
            obj.resetBlocks();
            blocks = obj.blocks;
        end
        function blocks = getBlockRange(obj, x, y, side)
            minx = round(x/GothamMap.bw);
            miny = round(y/GothamMap.bh);
            maxx = round((x+side)/GothamMap.bw);
            maxy = round((y+side)/GothamMap.bh);
            blocks = [];
            for x=minx:maxx
                for y=miny:maxy
                    b = obj.blocks(GothamMap.nh * x + y + 1);
                    blocks = [blocks, b];
                end
            end
        end
        function tickAll(map, currTime)
            for b=1:length(map.blocks)
                map.blocks(b).tick(currTime);
            end
        end
        function update(map, drones, curr_time)
            for d=1:length(drones)
                drone = drones(d);
                observed = map.getBlockRange(drone.position(1), drone.position(2), drone.range);
                for b=1:length(observed)
                    observed(b).observe(curr_time);
                end
            end
        end
        function drawBlocks(obj)
            for b=1:length(blocks)
                blocks(b).draw(GothamMap.bw);
            end
        end
        function drawDrones(obj, drones)
            for d=1:length(drones)
                drones(d).draw(100);
            end
        end
    end
end
