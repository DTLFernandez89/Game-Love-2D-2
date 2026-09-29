local StateManager = {}

function StateManager.init()

    --- Carga los estados una vez inicializado el gestor ---
    StateManager.states = {

        menu = require("states.menustate"),
        play = require("states.playstate"),
        gameover = require("states.gameoverstate"),
        win = require("states.winstate")

    }

    StateManager.switch("menu")

end


function StateManager.switch(stateName, ...)

    if StateManager.currentState and StateManager.currentState.exit then

        StateManager.currentState.exit()

    end

    StateManager.currentState = StateManager.states[stateName]

    if StateManager.currentState and StateManager.currentState.enter then

        StateManager.currentState.enter(...)

    end

end


function StateManager.update(dt)

    if StateManager.currentState and StateManager.currentState.update then

        StateManager.currentState.update(dt)

    end

end


function StateManager.draw()

    if StateManager.currentState and StateManager.currentState.draw then

        StateManager.currentState.draw()

    end

end


function StateManager.keypressed(key)

    if StateManager.currentState and StateManager.currentState.keypressed then

        StateManager.currentState.keypressed(key)

    end

end


function StateManager.mousepressed(x, y, button)

    if StateManager.currentState and StateManager.currentState.mousepressed then

        StateManager.currentState.mousepressed(x, y, button)

    end

end

return StateManager
