local Bullet = require("entities.bullet")
local SoundManager = require("managers.soundmanager")

local Enemy = {}
Enemy.__index = Enemy

--- Configuración de los 4 tipos de enemigos (Velocidad, Vida, Daño, Frecuencia de Disparo, Escala) ---
local ENEMY_CONFIGS = {

    [1] = { speed = 120, health = 30, damage = 15, shootInterval = 2.0, scale = 0.25 }, -- Estándar --
    [2] = { speed = 180, health = 20, damage = 10, shootInterval = 1.5, scale = 0.22 }, -- Rápido --
    [3] = { speed = 80,  health = 70, damage = 25, shootInterval = 3.0, scale = 0.30 }, -- Tanque --
    [4] = { speed = 140, health = 45, damage = 20, shootInterval = 1.8, scale = 0.25 }  -- Tirador --

}


function Enemy.new(x, y, enemyType)

    local self = setmetatable({}, Enemy)
    self.x = x
    self.y = y
    self.type = enemyType or math.random(1, 4)

    --- Selección segura de la configuración (si falla el tipo, usa el tipo 1 por defecto) ---
    local config = ENEMY_CONFIGS[self.type] or ENEMY_CONFIGS[1]

    self.scale = config.scale or 0.25
    self.image = love.graphics.newImage("Archives/enemies/enemy" .. self.type .. ".png")

    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.radius = self.width / 2

    self.speed = config.speed
    self.health = config.health
    self.maxHealth = config.health
    self.damage = config.damage
    self.shootInterval = config.shootInterval
    self.shootTimer = math.random(1, 3)
    self.alive = true

    return self

end


function Enemy:update(dt, playerX, playerY, bullets)

    if not self.alive then return end

    --- Movimiento directo hacia la posición del jugador ---
    local dx = playerX - self.x
    local dy = playerY - self.y
    local dist = math.sqrt(dx * dx + dy * dy)

    if dist > 0 then

        self.x = self.x + (dx / dist) * self.speed * dt
        self.y = self.y + (dy / dist) * self.speed * dt

    end

    --- Disparo apuntando hacia el jugador ---
    self.shootTimer = self.shootTimer - dt

    if self.shootTimer <= 0 then

        self.shootTimer = self.shootInterval
        table.insert(bullets, Bullet.new(self.x, self.y, playerX, playerY, 350, false, self.damage))

    end

end


function Enemy:takeDamage(amount)

    self.health = self.health - amount

    if self.health <= 0 then

        self.health = 0
        self.alive = false
        SoundManager.playSFX("death_enemies")

    else

        SoundManager.playSFX("healt_enemies")

    end

end


function Enemy:draw()

    if not self.alive then return end

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(
    
        self.image,
        self.x, self.y,
        0, --- Ángulo 0 fijo para evitar rotación del sprite ---
        self.scale, self.scale,
        self.image:getWidth() / 2, self.image:getHeight() / 2

    )

end

return Enemy
