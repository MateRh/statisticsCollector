WEAPON_IDS = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45}

Weapon = class(
    function(this, id)
        this.id = id
        this.damage = 0
	end
)

function Weapon:setDamage(damage)
    self.damage = damage
end

function Weapon:getDamage()
    return self.damage
end

function Weapon:getName()
    return getWeaponNameFromID(self.id)
end