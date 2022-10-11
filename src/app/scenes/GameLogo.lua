local GameMenu=require('app.scenes.GameMenu')
local GameLogo=class("GameLogo", function()
    return display.newScene("GameLogo")
end)

function GameLogo:ctor()
    -- display.newSprite("bg_night.png", display.cx, display.cy, params)
    --     :addTo(self)

    local bg=cc.Sprite:create("bg_night.png")
    bg:setAnchorPoint(cc.p(0, 0))
    self:addChild(bg)
    
    local delay=cc.DelayTime:create(1.0)
    local callFunc=cc.CallFunc:create(function()
        local nextScene=GameMenu.new()
        local transition=cc.TransitionFadeBL:create(1.0, nextScene)
        display.replaceScene(transition)
    end)
    local seq=cc.Sequence:create(delay, callFunc)
    self:runAction(seq)

end

return GameLogo