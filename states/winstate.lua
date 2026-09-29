local SoundManager = require("managers.soundmanager")
local StateManager = require("statemanager")

local WinState = {}

function WinState.enter(finalScore)

    SoundManager.playMusic("win")
    WinState.finalScore = finalScore or 0
    WinState.fontBig = love.graphics.newFont(56)
    WinState.fontMedium = love.graphics.newFont(28)

end


function WinState.update(dt)
end


function WinState.draw()

    love.graphics.clear(0.02, 0.15, 0.05)

    love.graphics.setFont(WinState.fontBig)
    love.graphics.setColor(0.2, 1, 0.4)
    love.graphics.printf("¡VICTORIA! HAS SOBREVIVIDO", 0, 200, 1280, "center")

    love.graphics.setFont(WinState.fontMedium)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Puntaje Final: " .. WinState.finalScore, 0, 320, 1280, "center")

    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.printf("Presiona [ R ] para Jugar de nuevo", 0, 440, 1280, "center")
    love.graphics.printf("Presiona [ M ] para volver al Menú Principal", 0, 500, 1280, "center")

end


function WinState.keypressed(key)

    if key == "r" then

        StateManager.switch("play")

    elseif key == "m" then

        StateManager.switch("menu")

    end

end

return WinState
