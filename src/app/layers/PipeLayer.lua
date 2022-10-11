local Pipe=require("app.objects.Pipe")

local PipeLayer=class("PipeLayer", function()
    return display.newLayer("PipeLayer")
end)

function PipeLayer:ctor()

end

function PipeLayer:startAddPipe()
    self:schedule(function()
        Pipe.new()
        :align(display.CENTER, display.width+100, math.random(150, 300))--150 340
        :addTo(self)
    end, 2.0)
end

function PipeLayer:update(dt)
    local children=self:getChildren()
    for i,v in ipairs(children) do
        v:update(dt)
    end
end

function PipeLayer:restart()
    local children=self:getChildren()
    for i,v in ipairs(children) do
        v:setPositionX(display.width+100)
    end
end

return PipeLayer