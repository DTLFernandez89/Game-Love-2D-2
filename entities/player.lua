local Bullet = require("entities.bullet")
local SoundManager = require("managers.soundmanager")

local Player = {}
Player.__index = Player


function Player.new(x, y)

    local self = setmetatable({}, Player)

    self.image = love.graphics.newImage("Archives/player/player.png")

    self.x = x
    self.y = y

    self.scale = 0.25 --- Escala sprite de 300x300 a ~75x75 ---

    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.radius = self.width / 2

    self.speed = 290
    self.health = 100
    self.maxHealth = 100

    self.regenTimer = 10
    self.fireCooldown = 0
    self.fireRate = 0.25

    return self

end


function Player:update(dt, bullets)

    --- Movimiento WASD / Flechas ---
    local moveX, moveY = 0, 0
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then moveX = moveX - 1 end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then moveX = moveX + 1 end
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then moveY = moveY - 1 end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then moveY = moveY + 1 end

    --- Movimiento Diagonal ---
    if moveX ~= 0 and moveY ~= 0 then

        moveX = moveX * 0.7071
        moveY = moveY * 0.7071

    end

    self.x = math.max(self.radius, math.min(1280 - self.radius, self.x + moveX * self.speed * dt))
    self.y = math.max(self.radius, math.min(720 - self.radius, self.y + moveY * self.speed * dt))

    --- Contador de Regeneración (+10 HP cada 10s) ---
    self.regenTimer = self.regenTimer - dt

    if self.regenTimer <= 0 then

        self.regenTimer = 10

        if self.health < self.maxHealth then

            self.health = math.min(self.maxHealth, self.health + 10)

        end

    end


    --- Cooldown de disparo ---
    if self.fireCooldown > 0 then

        self.fireCooldown = self.fireCooldown - dt

    end

    --- Disparo con Click Izquierdo ---
    if love.mouse.isDown(1) and self.fireCooldown <= 0 then

        local mx, my = love.mouse.getPosition()
        table.insert(bullets, Bullet.new(self.x, self.y, mx, my, 550, true, 25))
        self.fireCooldown = self.fireRate

    end

end


function Player:takeDamage(amount)

    self.health = self.health - amount
    SoundManager.playSFX("health_player")

    if self.health <= 0 then

        self.health = 0

    end

end


function Player:draw()

    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(
    
        self.image,
        self.x, self.y,
        0, --- Ángulo 0 constante para que el cuerpo NO rote ---
        self.scale, self.scale,
        self.image:getWidth() / 2, self.image:getHeight() / 2

    )

end

return Player
