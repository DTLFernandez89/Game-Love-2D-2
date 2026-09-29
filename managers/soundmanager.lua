local SoundManager = {}

function SoundManager.init()

    SoundManager.sounds = {

        main_menu = love.audio.newSource("Archives/audio/main_menu.mp3", "stream"),
        gameplay = love.audio.newSource("Archives/audio/gameplay.mp3", "stream"),

        death_enemies = love.audio.newSource("Archives/audio/death_enemies.mp3", "static"),
        death_player = love.audio.newSource("Archives/audio/death_player.mp3", "static"),

        healt_enemies = love.audio.newSource("Archives/audio/healt_enemies.mp3", "static"),
        healt_player = love.audio.newSource("Archives/audio/healt_player.mp3", "static"),
        
        win = love.audio.newSource("Archives/audio/win.mp3", "stream"),
        lose = love.audio.newSource("Archives/audio/lose.mp3", "stream")
    }

    SoundManager.sounds.main_menu:setLooping(true)
    SoundManager.sounds.gameplay:setLooping(true)

end


function SoundManager.playMusic(name)

    SoundManager.stopAllMusic()

    if SoundManager.sounds[name] then

        SoundManager.sounds[name]:seek(0)
        SoundManager.sounds[name]:play()

    end

end


function SoundManager.playSFX(name)

    if SoundManager.sounds[name] then

        SoundManager.sounds[name]:stop()
        SoundManager.sounds[name]:play()

    end

end


function SoundManager.stopAllMusic()

    SoundManager.sounds.main_menu:stop()
    SoundManager.sounds.gameplay:stop()
    SoundManager.sounds.win:stop()
    SoundManager.sounds.lose:stop()

end

return SoundManager
