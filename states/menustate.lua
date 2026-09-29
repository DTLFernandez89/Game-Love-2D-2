local SoundManager = require("managers.soundmanager")
local StateManager = require("statemanager")

local MenuState = {}


function MenuState.enter()

    SoundManager.playMusic("main_menu")

    MenuState.selectedIndex = 1
    MenuState.options = { "PLAY", "EXIT" }

    MenuState.fontTitle = love.graphics.newFont(64)
    MenuState.fontOption = love.graphics.newFont(32)

end


function MenuState.update(dt)
end


function MenuState.draw()

    love.graphics.clear(0.08, 0.08, 0.12)

    love.graphics.setFont(MenuState.fontTitle)
    love.graphics.setColor(0.2, 0.8, 1)
    love.graphics.printf("SOBREVIVIENTE TP2", 0, 180, 1280, "center")

    love.graphics.setFont(MenuState.fontOption)

    for i, option in ipairs(MenuState.options) do

        if i == MenuState.selectedIndex then

            love.graphics.setColor(1, 0.84, 0)
            love.graphics.printf("> " .. option .. " <", 0, 360 + (i * 60), 1280, "center")

        else

            love.graphics.setColor(0.7, 0.7, 0.7)
            love.graphics.printf(option, 0, 360 + (i * 60), 1280, "center")

        end

    end

end


function MenuState.keypressed(key)

    if key == "up" or key == "w" then

        MenuState.selectedIndex = 1

    elseif key == "down" or key == "s" then

        MenuState.selectedIndex = 2

    elseif key == "return" or key == "space" then

        if MenuState.selectedIndex == 1 then

            StateManager.switch("play")

        elseif MenuState.selectedIndex == 2 then

            love.event.quit()

        end

    end

end


function MenuState.mousepressed(x, y, button)

    if button == 1 then

        if y >= 400 and y <= 450 then

            StateManager.switch("play")

        elseif y >= 460 and y <= 510 then

            love.event.quit()

        end

    end

end


return MenuState
