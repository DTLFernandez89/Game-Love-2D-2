local SoundManager = require("managers.soundmanager")
local StateManager = require("statemanager")

local GameOverState = {}


function GameOverState.enter(finalScore)

    SoundManager.playMusic("lose")
    GameOverState.finalScore = finalScore or 0
    GameOverState.fontBig = love.graphics.newFont(56)
    GameOverState.fontMedium = love.graphics.newFont(28)

end


function GameOverState.update(dt)
end


function GameOverState.draw()

    love.graphics.clear(0.15, 0.02, 0.02)

    love.graphics.setFont(GameOverState.fontBig)
    love.graphics.setColor(1, 0.2, 0.2)
    love.graphics.printf("¡HAS SIDO DERROTADO!", 0, 200, 1280, "center")

    love.graphics.setFont(GameOverState.fontMedium)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Puntaje Final: " .. GameOverState.finalScore, 0, 320, 1280, "center")

    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.printf("Presiona [ R ] para Reiniciar", 0, 440, 1280, "center")
    love.graphics.printf("Presiona [ M ] para volver al Menú Principal", 0, 500, 1280, "center")

end


function GameOverState.keypressed(key)

    if key == "r" then

        StateManager.switch("play")

    elseif key == "m" then

        StateManager.switch("menu")

    end

end


return GameOverState
