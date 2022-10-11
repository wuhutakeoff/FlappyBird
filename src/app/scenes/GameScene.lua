local Background=require("app.layers.Background")
local Player=require("app.objects.Player")
local PipeLayer=require("app.layers.PipeLayer")
local UILayer=require("app.layers.UILayer")

local GameScene=class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()
    self.score=0;

    self.bg=Background.new({img='bg_day.png',speed = -200})
    :addTo(self)

    self.pipeLayer=PipeLayer.new()
    :addTo(self)

    self.floor=Background.new({img='land.png',speed = -200})
    :addTo(self)

    display.addSpriteFrames("FlappyBird.plist", "FlappyBird.png");

    self.uiLayer=UILayer.new()
    :addTo(self,2)

    self.player=Player.new()
    :align(display.CENTER,-50,display.cy)
    :addTo(self)

    self.isStartGame=false;

    local seq=transition.sequence({cc.MoveTo:create(2.0,cc.p(display.cx,display.cy)),cc.CallFunc:create(function()
        self.isStartGame=true;
        self.uiLayer:changeVisable(true)
    end)})
    self.player:runAction(seq)

    self.times=0
    self.touchLayer=display.newLayer()
    :addTo(self,2)
    self.touchLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
        if not self.isStartGame then return end
        if event.name=="began" then
            return true
        end
        if event.name=="moved" then 
        end
        if event.name=="ended" then
            if self.times==0 then 
                self:startUpdate() 
                self.uiLayer:changeVisable(false) 
                self.times=self.times+1 
                print("start")
            end
            self.player:jump()
        end
    end)
   
end

function GameScene:startUpdate()
    self.pipeLayer:startAddPipe()
	--必要两行代码
	self:scheduleUpdate();
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,handler(self,self.update));
end

function GameScene:update(dt)
    if self.isStartGame then
		self.bg:update(dt);
		self.floor:update(dt);
		self.pipeLayer:update(dt);
	end

    self.player:update(dt)
    self:onCollision()
    self:addScore()
end

function GameScene:onCollision()
    local children = self.pipeLayer:getChildren();
	local playerBoudingBox = self.player:getBoundingBox();
	for i,pipe in ipairs(children) do
		if pipe:isCollision(self.player:getBoundingBox()) then
            --print(1,'pipe:',pipe:getPositionX(),'player')
			self:GameOver();
			return;
		end
	end

	local playerBox = self.player:getBoundingBox();
	local arrFloor = self.floor:getChildren();
	for i,v in ipairs(arrFloor) do
		local rcFloor = v:getBoundingBox();
		if cc.rectIntersectsRect(playerBox,rcFloor) then
            print(2)
            self.player:stopAllActions();
            self:unscheduleUpdate();
			self:GameOver();
			return;
		end
	end
end

function GameScene:GameOver()
    --print(self.touchLayer);
    if not self.bestscore then self.bestscore=0 end
    if self.score>self.bestscore then self.bestscore=self.score end
    self.touchLayer:setTouchEnabled(false);
    self.isStartGame=false;
    self.pipeLayer:stopAllActions()
    self.uiLayer:showDefeat()
end

function GameScene:addScore()
    local children = self.pipeLayer:getChildren();
	for i,pipe in ipairs(children) do
		if self.player:getPositionX() >= pipe:getPositionX() and not pipe.isCompare then
			pipe.isCompare = true;
			self.score=self.score+1;
			self.uiLayer:changeLabel(self.score);
		end
	end
end

function GameScene:startGame()
    self:unscheduleUpdate()
    display.getRunningScene():ctor()

    -- UserDefault:setIntegerForKey("bestscore", self.bestscore)
    -- local value=UserDefault:getIntegerForKey("bestscore", self.bestscore)
    -- print(value)

    -- self:unscheduleUpdate()
    -- self.player:restart()
    -- self.score=0
    -- self.touchLayer:setTouchEnabled(true);
    -- local seq=transition.sequence({cc.CallFunc:create(function() self.pipeLayer:restart() end),cc.MoveTo:create(2.0,cc.p(display.cx,display.cy)),
    -- cc.CallFunc:create(function()
    --     self.isStartGame=true;
    --     self:startUpdate();
    -- end)})
    -- self.player:runAction(seq)   
end

function GameScene:getScore()
    local scores={score=self.score or 0,bestscore=self.bestscore or 0}
    return scores
end

return GameScene