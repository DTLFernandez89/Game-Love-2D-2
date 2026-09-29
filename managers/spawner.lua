local Enemy = require("entities.enemy")

local Spawner = {}


function Spawner.init()
    
    Spawner.enemies = {}
    Spawner.spawnTimer = 0
    Spawner.spawnInterval = 1.0

end


function Spawner.update(dt, playerX, playerY, bullets, onEnemyKilled)

    Spawner.spawnTimer = Spawner.spawnTimer + dt

    if Spawner.spawnTimer >= Spawner.spawnInterval then
        Spawner.spawnTimer = 0

        --- Aparición desde los bordes de la pantalla (1280x720) ---
        local side = math.random(1, 4)
        local x, y

        if side == 1 then x = math.random(0, 1280); y = -30
        elseif side == 2 then x = math.random(0, 1280); y = 750
        elseif side == 3 then x = -30; y = math.random(0, 720)
        else x = 1310; y = math.random(0, 720) end

        local enemyType = math.random(1, 4)
        table.insert(Spawner.enemies, Enemy.new(x, y, enemyType))

    end

    --- Actualización y eliminación de enemigos muertos ---
    for i = #Spawner.enemies, 1, -1 do

        local enemy = Spawner.enemies[i]
        enemy:update(dt, playerX, playerY, bullets)

        if not enemy.alive then

            table.remove(Spawner.enemies, i)

            if onEnemyKilled then

                onEnemyKilled()

            end

        end

    end

end


function Spawner.draw()

    for _, enemy in ipairs(Spawner.enemies) do

        enemy:draw()

    end

end

return Spawner
