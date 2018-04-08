Player = class(
    function(this, serial, name)
        this.serial = serial
        this.name = name
        this.weapons = {}
        for k, id in ipairs(WEAPON_IDS) do
            table.insert(this.weapons, id, Weapon(id))
        end
	end
)

function Player:getWeapon(id)
    return self.weapons[id]
end

function Player:getSerial()
    return self.serial
end

function Player:getName()
    return self.name
end