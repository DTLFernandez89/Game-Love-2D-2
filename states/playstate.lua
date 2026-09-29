local SoundManager = require("managers.soundmanager")
local StateManager = require("statemanager")
local Player = require("entities.player")
local Spawner = require("managers.spawner")
local HUD = require("ui.hud")

local PlayState = {}

function PlayState.enter()

    SoundManager.playMusic("gameplay")

    local scenarioIndex = math.random(1, 3)
    PlayState.bgImage = love.graphics.newImage("Archives/scenarios/scenario0" .. scenarioIndex .. ".png")

    PlayState.player = Player.new(640, 360)
    PlayState.bullets = {}
    PlayState.score = 0
    PlayState.elapsedTime = 0
    PlayState.timeLimit = 150

    Spawner.init()

end


function PlayState.update(dt)

    PlayState.elapsedTime = PlayState.elapsedTime + dt
    local timeRemaining = math.max(0, PlayState.timeLimit - PlayState.elapsedTime)

    --- Condición de Victoria ---
    if timeRemaining <= 0 then

        StateManager.switch("win", PlayState.score)

        return
    end

    PlayState.player:update(dt, PlayState.bullets)

    --- Condición de Derrota (Game Over) ---
    if PlayState.player.health <= 0 then

        SoundManager.playSFX("death_player")
        StateManager.switch("gameover", PlayState.score)

        return

    end


    Spawner.update(dt, PlayState.player.x, PlayState.player.y, PlayState.bullets, function()

        PlayState.score = PlayState.score + 100

    end)


    --- Actualización y colisiones de proyectiles ---
    for i = #PlayState.bullets, 1, -1 do

        local b = PlayState.bullets[i]
        b:update(dt)

        if not b.alive then

            table.remove(PlayState.bullets, i)

        else
            if b.isPlayerBullet then
                for _, enemy in ipairs(Spawner.enemies) do
                    if enemy.alive then
                        local dist = math.sqrt((b.x - enemy.x)^2 + (b.y - enemy.y)^2)

                        if dist < (b.radius + enemy.radius) then

                            enemy:takeDamage(b.damage)
                            b.alive = false
                            break

                        end

                    end

                end

            else

                local dist = math.sqrt((b.x - PlayState.player.x)^2 + (b.y - PlayState.player.y)^2)

                if dist < (b.radius + PlayState.player.radius) then

                    PlayState.player:takeDamage(b.damage)
                    b.alive = false

                end

            end

        end

    end

end


function PlayState.draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(PlayState.bgImage, 0, 0)

    PlayState.player:draw()
    Spawner.draw()

    for _, b in ipairs(PlayState.bullets) do

        b:draw()

    end

    local timeRemaining = math.max(0, PlayState.timeLimit - PlayState.elapsedTime)
    
    HUD.draw(
    
        PlayState.score,
        PlayState.player.health,
        PlayState.player.maxHealth,
        PlayState.player.regenTimer,
        PlayState.elapsedTime,
        timeRemaining

    )

end

return PlayState
