
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.ui.UILabel.new({
            UILabelType = 2, text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)

    local label=display.newTTFLabel({text="New Label",size=64,textAlign=display.CENTER,x=display.cx,y=display.cy-100})
    self:addChild(label)

    
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
