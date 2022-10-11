local Player=class("Player", function()
    return display.newSprite("#bird0_0.png")
end)

function Player:ctor(params)
    self.speed= 0;
    self.accel=-300;
    self.degreeSpeed=300
    local frames = display.newFrames("bird0_%d.png", 0,3);
	local animation = display.newAnimation(frames, 0.5 / 3) 
	self:playAnimationForever(animation)
end

function Player:update(dt)
    local y=self:getPositionY()
    self.speed=self.speed+self.accel*dt
    y=y+self.speed*dt
    self:setPositionY(y)

    if self.speed>=0 then return end    

    local rotation = self:getRotation();
	rotation =rotation+self.degreeSpeed*dt;
	if rotation >=90 then
		rotation = 90;
	end
	self:setRotation(rotation);

end

function Player:jump()
    self.speed=200;
    self:setRotation(-30)
end

function Player:restart()
    self:setPosition(-50,display.cy)
    self:setRotation(0)
    self.speed=0
    self:stopAllActions()
    self:unscheduleUpdate()
end

return Player