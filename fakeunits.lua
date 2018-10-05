
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

-- USAGE: UNIT.area(DISTANCE, HEALTH).heal >= # 获取指定单位范围内血量小于多少的玩家数量
-- 治疗祷言的判断方法比较奇葩，所以呢，单独写个fakeunit以获取满足需要的，当然 ，队伍模式无视。
-- 获取40码内最近的x个队友，满足血量低于Y的数量为Z个
-- 获取40码内所有玩家，遍历每个玩家，也就是最多遍历40次！每次遍历按照距离从小到大排序取前四，放到新表检测是否满足条件 最后返回一个unit吧
--遍历套遍历 根据损失的血量百分比的均值来找最需要治疗的那个目标以及范围
NeP.DSL:Register("area.POH", function(unit, args)
	local total = 0
	if not _G.UnitExists(unit) then return total end
	local distance, health = _G.strsplit(",", args, 2)
	for _,Obj in pairs(NeP.OM:Get('Roster')) do
		local unit_dist = NeP.Protected.Distance(unit, Obj.key)
		if unit_dist < (tonumber(distance) or 20)
		and Obj.health < (tonumber(health) or 100) then
			total = total + 1
		end
	end
	return total
end)