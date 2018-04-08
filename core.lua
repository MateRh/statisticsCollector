Core = class(
    function(this)
        this.players = {}
	end
)

function Core:generateFileName()
    local date = getRealTime()
    return string.format("exports/%s_%02d_%02d_%02d-%02d-%02d.csv",
        1900 + date.year,
        date.month + 1,
        date.monthday,
        date.hour + 1,
        date.minute,
        date.second + 1)
end

function Core:getPlayers()
    return self.players
end

function Core:getPlayer(serial, name, health)
    if self.players[serial] then
        return self.players[serial]
    end
    return self:createPlayer(serial, name, health)
end 

function Core:createPlayer(serial, name, health)
    self.players[serial] = Player(serial, name, health)
    return self.players[serial]
end

function Core:calculateDamage(weapon, loss)
    weapon:setDamage(weapon:getDamage() + loss)
end 

local core = Core()

addEventHandler("onPlayerDamage", getRootElement(), 
    function(attacker, weapon, bodypart, loss) 
        if attacker and weapon then
            core:calculateDamage(core:getPlayer(attacker:getSerial()):getWeapon(weapon), loss)
        end
        core:getPlayer(source:getSerial()):setHealth(source:getHealth())
    end
)

addEventHandler("onPlayerWasted", getRootElement(),
    function(ammo, attacker, weapon)
        if attacker and weapon then
            core.calculateDamage(core:getPlayer(attacker:getSerial()):getWeapon(weapon), core:getPlayer(source:getSerial()):getHealth())
        end
    end 
)

addEventHandler("onPlayerJoin", getRootElement(),
    function()
        core:getPlayer(source:getSerial(), source:getName(), source:getHealth())
    end
)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
    function()
        for k, source in pairs(getElementsByType("player")) do
            core:createPlayer(source:getSerial(), source:getName(), source:getHealth())    
        end
    end
)

addCommandHandler("export",
    function(player)
        local tickCount = getTickCount()
        local fileName = core:generateFileName()
        Csv(fileName):export(core:getPlayers())
        outputChatBox("#3399ffStatistics have been exported to a file #cc0000'#33cc33" .. fileName .. "#cc0000' [#33cc33" .. getTickCount()
            - tickCount .." ms#cc0000]", player, 255, 255, 255, true)
    end, true
)