-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
display.setStatusBar( display.HiddenStatusBar )

-- vars
local gravX = 0
local gravY = 0

-- create background
local myBackground = display.newImageRect( "background.jpg", display.actualContentWidth, display.actualContentHeight )

-- center background
myBackground.x = display.contentCenterX
myBackground.y = display.contentCenterY

-- create doge
local doge = display.newImageRect( "doge.png", 75, 75 )
doge.x = display.contentCenterX
doge.y = display.contentCenterY

-- create platforms
local plat1 = display.newRect( 100, 100, 100, 15 )
plat1:setFillColor( 0, .5, .3 )
local plat2 = display.newRect( 250, 250, 100, 15 )
plat2:setFillColor( 0, .2, .3 )
local plat3 = display.newRect( 150, 400, 100, 15 )
plat3:setFillColor( 0, .1, .3 )

-- detect tilt
local function onAccelerate( event )
    gravX = event.xRaw*3
end

Runtime:addEventListener( "accelerometer", onAccelerate )
system.setAccelerometerInterval( 100 )


-- touches
local function onTouch( event )
	local myTouch = event.x - display.contentCenterX
	if myTouch < 0 then
		gravX = -3
	elseif myTouch > 0 then
		gravX = 3
	end
end
Runtime:addEventListener( "touch", onTouch )

-- check collision
local function checkCollide( obj )
	if  doge.y + doge.height*.5 > obj.y - obj.height*.5 and
		doge.y - doge.height*.5 < obj.y + obj.height*.5 and
		doge.x + doge.width*.5 > obj.x - obj.width*.5 and
		doge.x - doge.width*.5 < obj.x + obj.width*.5 then
		return true
	else
		return false
	end
end

-- game loop
local gameLoop = function( event )
	-- moving doge
	gravY = gravY + .5
	doge.x = doge.x + gravX
	doge.y = doge.y + gravY

	-- collision detection
	if gravY > 0 then
		if checkCollide(plat3) or checkCollide(plat2) or checkCollide(plat1) then
			gravY = -14
		end
	end
end
Runtime:addEventListener( "enterFrame", gameLoop )














