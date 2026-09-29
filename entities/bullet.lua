local Bullet = {}
Bullet.__index = Bullet

local fireImage = nil
local imageWidth = 0
local imageHeight = 0


function Bullet.initClass()

    if not fireImage then

        fireImage = love.graphics.newImage("Archives/enemies/fire.png")
        imageWidth = fireImage:getWidth()
        imageHeight = fireImage:getHeight()

    end

end


function Bullet.new(x, y, targetX, targetY, speed, isPlayerBullet, damage)

    local self = setmetatable({}, Bullet)

    self.x = x
    self.y = y
    self.speed = speed or 500
    self.isPlayerBullet = isPlayerBullet
    self.damage = damage or 25
    self.radius = 8
    self.alive = true

    --- Dirección calculada hacia el objetivo (coordenadas X, Y) ---
    local angle = math.atan2(targetY - y, targetX - x)
    self.vx = math.cos(angle) * self.speed
    self.vy = math.sin(angle) * self.speed

    pcall(function()

        self.image = love.graphics.newImage("Archives/enemies/FIRE.png")

    end)

    return self

end


function Bullet:update(dt)

    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    --- Eliminar al salir de pantalla ---
    if self.x < -50 or self.x > 1330 or self.y < -50 or self.y > 770 then

        self.alive = false

    end

end


function Bullet:draw()

    if self.image then

        love.graphics.setColor(1, 1, 1)

        local ox = self.image:getWidth() / 2
        local oy = self.image:getHeight() / 2

        love.graphics.draw(self.image, self.x, self.y, 0, 0.4, 0.4, ox, oy)

    else

        if self.isPlayerBullet then

            love.graphics.setColor(1, 0.9, 0.2)

        else

            love.graphics.setColor(1, 0.2, 0.2)

        end

        love.graphics.circle("fill", self.x, self.y, self.radius)

    end
    
end

return Bullet
