local Pipe=class("Pipe", function()
    return display.newNode("Pipe")
end)

function Pipe:ctor()
    local topY=math.random(150,190)    
    self.arrPipe={}
    self.speed=-200

    -- display.width+100, math.random(150, 350)
    local topPipe=display.newSprite('#pipe_down.png')
    :align(display.BOTTOM_CENTER, 0, topY )
    :addTo(self)

    local bottomPipe=display.newSprite('#pipe_up.png')
    :align(display.CENTER_TOP)
    :addTo(self)

    table.insert(self.arrPipe, topPipe)
    table.insert(self.arrPipe, bottomPipe)
end

function Pipe:update(dt)
    local x=self:getPositionX()
    x=x+self.speed*dt
    self:setPositionX(x)

    if x <=-100 then
		self:removeFromParent();
	end
end

function Pipe:isCollision(rcBouding)
    local leftBottomPos = cc.p(rcBouding.x,rcBouding.y);

	local posInPipe = self:convertToNodeSpace(leftBottomPos);

    local rc = cc.rect();
	rc.x = posInPipe.x;
	rc.y = posInPipe.y;
    rc.width = rcBouding.width/2;
    rc.height = rcBouding.height/2;

    -- rcBouding.x = posInPipe.x;
	-- rcBouding.y = posInPipe.y;

	for i,v in ipairs(self.arrPipe) do
        local pipeBox=v:getBoundingBox()
		if cc.rectIntersectsRect(rc,pipeBox) then
			return true;
		end
	end

	return false;

end

return Pipe