local HUD = {}

function HUD.draw(score, playerHp, maxHp, regenTimer, elapsedTime, timeRemaining)
    love.graphics.setFont(love.graphics.newFont(16))

    --- Fondo transucido superior ---
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 10, 10, 1260, 60, 8, 8)

    --- Puntuacion ---
    love.graphics.setColor(1, 0.84, 0)
    love.graphics.print("PUNTOS: " .. score, 30, 28)

    --- Barra de Vida del Jugador ---
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("VIDA:", 230, 28)

    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 285, 26, 200, 20, 4, 4)

    local healthRatio = playerHp / maxHp
    love.graphics.setColor(0.1, 0.85, 0.2)
    love.graphics.rectangle("fill", 285, 26, 200 * healthRatio, 20, 4, 4)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(math.ceil(playerHp) .. " / " .. maxHp, 350, 28)

    --- Contador de Regeneracion de Vida (+10 HP cada 10s) ---
    love.graphics.setColor(0.4, 0.8, 1)
    love.graphics.print("REGEN EN: " .. string.format("%.1fs", regenTimer), 520, 28)

    --- Tiempo Transcurrido ---
    local elapsedMin = math.floor(elapsedTime / 60)
    local elapsedSec = math.floor(elapsedTime % 60)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format("TIEMPO: %02d:%02d", elapsedMin, elapsedSec), 750, 28)

    --- Tiempo Restante para ganar (Supervivencia de 2m 30s = 150s) ---
    local remMin = math.floor(timeRemaining / 60)
    local remSec = math.floor(timeRemaining % 60)

    love.graphics.setColor(1, 0.3, 0.3)
    love.graphics.print(string.format("META SOBREVIVIR: %02d:%02d", remMin, remSec), 970, 28)

    love.graphics.setColor(1, 1, 1)

end

return HUD
