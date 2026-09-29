local StateManager = require("statemanager")
local SoundManager = require("managers.soundmanager")


function love.load()

    love.graphics.setDefaultFilter("linear", "linear")
    math.randomseed(os.time())

    --- Cargar de Sonidos y Estados ---
    SoundManager.init()
    StateManager.init()

end


function love.update(dt)

    StateManager.update(dt)

end


function love.draw()

    StateManager.draw()

end


function love.keypressed(key)

    StateManager.keypressed(key)

end


function love.mousepressed(x, y, button)

    StateManager.mousepressed(x, y, button)

end



