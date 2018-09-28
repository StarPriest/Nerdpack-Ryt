
-- lowest with certain buff from ANY one
NeP.FakeUnits:Add('lbuffa', function(num, args)
    local buff, role = strsplit(',', args, 2)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:GetRoster()) do
          if (not role or Obj.role == role) and NeP.DSL:Get('buff.any')(Obj.key, buff) then
              tempTable[#tempTable+1] = {
                  key = Obj.key,
                  health = Obj.health
              }
          end
      end
      table.sort( tempTable, function(a,b) return a.health < b.health end )
      return tempTable[num] and tempTable[num].key
  end)
  
  -- lowets without certain buff from ANY one
  NeP.FakeUnits:Add('lnbuffa', function(num, args)
        local buff, role = strsplit(',', args, 2)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:GetRoster()) do
          if (not role or Obj.role == role) and not NeP.DSL:Get('buff.any')(Obj.key, buff) then
              tempTable[#tempTable+1] = {
                  key = Obj.key,
                  health = Obj.health
              }
          end
      end
      table.sort( tempTable, function(a,b) return a.health < b.health end )
      return tempTable[num] and tempTable[num].key
  end)
  
  -- lowest with certain buff from ANY one
  NeP.FakeUnits:Add('ldebuffa', function(num, args)
        local buff, role = strsplit(',', args, 2)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:GetRoster()) do
          if (not role or Obj.role == role) and NeP.DSL:Get('debuff.any')(Obj.key, buff) then
              tempTable[#tempTable+1] = {
                  key = Obj.key,
                  health = Obj.health
              }
          end
      end
      table.sort( tempTable, function(a,b) return a.health < b.health end )
      return tempTable[num] and tempTable[num].key
  end)
  
  -- lowets without certain buff from ANY one
  NeP.FakeUnits:Add('lndebuffa', function(num, args)
        local buff, role = strsplit(',', args, 2)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:GetRoster()) do
          if (not role or Obj.role == role) and not NeP.DSL:Get('debuff.any')(Obj.key, buff) then
              tempTable[#tempTable+1] = {
                  key = Obj.key,
                  health = Obj.health
              }
          end
      end
      table.sort( tempTable, function(a,b) return a.health < b.health end )
      return tempTable[num] and tempTable[num].key
  end)
--- Highest Health Enemy
NeP.FakeUnits:Add("highestenemy", function(num)
    local tempTable = {}
     for _, Obj in pairs(NeP.OM:Get("Enemy")) do
       if _G.UnitInPhase(Obj.key)
        and NeP.Protected.Distance("player", Obj.key) < 50
        and _G.UnitCanAttack(Obj.key, "player")
        and _G.UnitAffectingCombat(Obj.key)
        and not _G.UnitIsPlayer(Obj.key)
        and not _G.UnitIsPVP(Obj.key)
        and not NeP.DSL:Get("boss")(Obj.key)
        and NeP.Protected.Infront("player", Obj.key) then
         tempTable[#tempTable+1] = {
             key = Obj.key,
             health = _G.UnitHealth(Obj.key)
         }
       end
     end
     table.sort( tempTable, function(a,b) return a.health > b.health end )
     return tempTable[num] and tempTable[num].key
 end)
