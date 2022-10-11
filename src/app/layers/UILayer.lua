local UILayer=class("UILayer", function()
    return display.newLayer("UILayer")
end)

function UILayer:ctor()
    self.score1=display.newSprite("#font_048.png")
    :align(display.CENTER, display.cx-15, display.cy+200)
    :addTo(self)

    self.score2=display.newSprite("#font_048.png")
    :align(display.CENTER, display.cx+15, display.cy+200)
    :addTo(self)

 
    self.gameOver=display.newSprite('#text_game_over.png')
    :align(display.CENTER, display.cx, display.cy+150)
    :addTo(self)

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
        self:getParent():startGame()
        self:hideDefeat()
    end)
    self.btnStart:setVisible(false)
    self.gameOver:setVisible(false)

    self.panel=display.newSprite('score_panel.png', display.cx, display.cy)
    :addTo(self)

    local str=string.format("%d", 0)
    self.panel.bestScore=display.newTTFLabel({text=str,size=14,textAlign=display.CENTER,x=185,y=35})
    :addTo(self.panel)

    local str1=string.format("%d", 0)
    self.panel.score=display.newTTFLabel({text=str1,size=14,textAlign=display.CENTER,x=185,y=80})
    :addTo(self.panel)

    self.panel:setVisible(false)

    self.tutorial=display.newSprite('tutorial.png', display.cx, display.cy+20)
    :addTo(self)

    self.tutorial:setVisible(false)

end

function UILayer:changeLabel(score)
    local single=score%10+48
    local gewei=string.format("font_0%d.png",single)
    local frame=display.newSpriteFrame(gewei)
    self.score2:setSpriteFrame(frame)

    local ten=score/10+48
    local shiwei=string.format("font_0%d.png",ten)
    local frame=display.newSpriteFrame(shiwei)
    self.score1:setSpriteFrame(frame)

end 

function UILayer:showDefeat()
    self.btnStart:setVisible(true)
    self.gameOver:setVisible(true)
    self.panel:setVisible(true)
    self.score1:setVisible(false)
    self.score2:setVisible(false)

    local scores=self:getParent():getScore()
    local str1=string.format("%d", scores.score)
    local str2=string.format("%d", scores.bestscore)
    self.panel.score:setString(str1)
    self.panel.bestScore:setString(str2)
end

function UILayer:hideDefeat()
    self.gameOver:setVisible(false)
    self.btnStart:setVisible(false)
    self.panel:setVisible(false)
    self:changeLabel(0)
end

function UILayer:changeVisable(isVisable)
    self.tutorial:setVisible(isVisable)
end

return UILayer