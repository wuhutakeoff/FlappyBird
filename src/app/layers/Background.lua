local Background=class("Background", function()
    return display.newNode("Background")
end)

function Background:ctor(params)
    self.height=params.height
    self.speed=params.speed or -200
    self.arrBg={}

    local bg1=display.newSprite(params.img)
    :align(display.BOTTOM_LEFT)
    :addTo(self)

    local bg2=display.newSprite(params.img)
    :align(display.BOTTOM_LEFT,bg1:getContentSize().width,0)
    :addTo(self)

    table.insert(self.arrBg,bg1)
    table.insert(self.arrBg,bg2)   

end

function Background:update(dt)
    local x1=self.arrBg[1]:getPositionX()
    local x2=self.arrBg[2]:getPositionX()

    x1=self.speed*dt+x1
    x2=self.speed*dt+x2

    local width1=self.arrBg[1]:getContentSize().width;
    local width2=self.arrBg[2]:getContentSize().width;

    if x1<=-width1 then
        x1=x2+width2
    end
    if x2<=-width2 then
        x2=x1+width1
    end  

    self.arrBg[1]:setPositionX(x1)
    self.arrBg[2]:setPositionX(x2)

end


return Background;