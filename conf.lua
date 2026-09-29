function love.conf(t)

    t.identity = "Game_Love2D_TP2"

    t.version = "11.4"

    t.window.title = "Sobreviviente - TP2 LÖVE2D"

    t.window.width = 1280
    t.window.height = 720

    t.window.resizable = false

    t.window.vsync = 1

    t.modules.audio = true
    t.modules.sound = true

    t.modules.graphics = true

    t.modules.timer = true

    t.modules.keyboard = true
    t.modules.mouse = true

end
