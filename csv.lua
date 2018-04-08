Csv = class(
    function(this, filePath)
        this.separator = ","
        this.endLine = "\n"
        this.file = File.new(filePath)
    end
)

function Csv:printHeader()
    local header = "Player name,Total damage,"
    for k, id in ipairs(WEAPON_IDS) do
        header = header .. getWeaponNameFromID(id) .. " damage"
        if (k < #WEAPON_IDS) then
            header = header .. self.separator
        end
    end
    self.file:write(header, self.endLine)
end

function Csv:printRow(player)
    local line = ""
    local totalDamage = 0
    for k, id in ipairs(WEAPON_IDS) do
        local damage = player:getWeapon(id):getDamage()
        totalDamage = totalDamage + damage
        line = line .. damage
        if (k < #WEAPON_IDS) then
            line = line .. self.separator
        end
    end 
    self.file:write(player:getName(), self.separator, tostring(totalDamage), self.separator, line, self.endLine)
end

function Csv:export(players) 
    self:printHeader()
    for k, player in pairs(players) do
        self:printRow(player)
    end
    self.file:close()
end