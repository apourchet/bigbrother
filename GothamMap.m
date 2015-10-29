classdef GothamMap < handle
    
    properties
        blocks
    end

    methods
        function obj = GothamMap()
            obj.blocks = [];
            for x=0:29
                for y=0:149
                    obj.blocks = [obj.blocks; Block([x*100 y*100], 15*60)];
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
        function update(obj, blocks, drones)
        end
        function drawBlocks(obj, blocks)
            for b=1:length(blocks)
                blocks(b).draw(100)
            end
        end
        function drawDrones(obj, drones)
            for d=1:length(drones)
                drones(d).draw(100)
            end
        end
    end
end
