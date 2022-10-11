local GameScene=require("app.scenes.GameScene")
local GameMenu=class("GameMenu", function()
    return display.newScene("GameMenu")
end)

function GameMenu:ctor()
    local bg=cc.Sprite:create("bg_day.png")
    bg:setAnchorPoint(cc.p(0, 0))
    self:addChild(bg)

    local title=cc.Sprite:create("title.png")
    title:setPosition(display.cx,display.cy+150)
    self:addChild(title)

    local img = {
		normal ='button_play.png',
		pressed ='button_play.png'
	}
    
    self.isClick=false;
	self.btnStart = cc.ui.UIPushButton.new(img)
	:align(display.CENTER,display.cx, display.cy-100)
	:addTo(self)
    :onButtonPressed(function()
        if self.isClick then return end
        print("click")
        self.isClick=true
        local seq=transition.sequence({
            cc.ScaleBy:create(0.1,1.2),
            cc.ScaleBy:create(0.1,1/1.2),
            cc.CallFunc:create(function()
                self.isClick=false
            end)
        })
        self.btnStart:runAction(seq)
    end)
    :onButtonRelease(function()
        local nextScene=GameScene.new();
        local transition=display.wrapSceneWithTransition(nextScene, "crossFade", 0.5)
		display.replaceScene(transition)
    end)

end

return GameMenu