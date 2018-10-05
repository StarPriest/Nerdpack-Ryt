local _G = _G
local NeP = NeP

local UnitBuff         = UnitBuff
local UnitDebuff       = UnitDebuff
local GetSpellInfo     = GetSpellInfo
local IsSpellInRange   = IsSpellInRange
local UnitIsPlayer     = UnitIsPlayer
local IsInInstance     = IsInInstance
local GetSpellAutocast = GetSpellAutocast
local HasPetUI         = HasPetUI
local IsCurrentSpell   = IsCurrentSpell
local UnitExists       = UnitExists
local UnitIsVisible    = UnitIsVisible
local IsStealthed      = IsStealthed

--/dump NeP.DSL.Parse("player.mana.actual", "", "")
NeP.DSL:Register("mana.actual", function(target)
	return _G.UnitMana(target)
end)

--/dump NeP.DSL.Parse("player.mana.max", "", "")
NeP.DSL:Register("mana.max", function(target)
	return _G.UnitManaMax(target)
end)

--/dump NeP.DSL.Parse("rake.stun", "", "")
NeP.DSL:Register("rake.stun", function(target)
    if NeP.DSL:Get("debuff.many")(target, "Rake") == 2 then
      return true
    end
end)

--/dump NeP.DSL.Parse("player.immune_all", "", "")
--/dump NeP.DSL.Parse("target.immune_all", "", "")
NeP.DSL:Register("immune_all",function(target)
 local immunallbuff = { 642, 133093, 63148, 186265, 19263, 122464, 122465, 122470, 124280, 125174, 45438, 145533, 41590, 36911, 27619, 47585 }
  for i = 1, #immunallbuff do
   local BuffName = _G.GetSpellInfo(immunallbuff[i])
   if _G.UnitBuff(target, BuffName) then
    return true 
   end
  end
  local immunalldebuff = { 33786, 209753, 88010 }
  for i = 1, #immunalldebuff do
   local DebuffName = _G.GetSpellInfo(immunalldebuff[i])
   if _G.UnitDebuff(target, DebuffName) then
    return true 
   end
  end
end)





--/dump NeP.DSL.Parse("target.immune_stun", "", "")
NeP.DSL:Register("immune_stun",function(target)
 local immunstun = { 
   48792,   -- Icebound Fortitude                  -- Death Knight
   115018,  -- Desecrated Ground                   -- Death Knight
   46924,   -- Bladestorm                          -- Warrior
   19574,   -- Bestial Wrath                       -- Hunter
   213658,  -- Craft: Nimble Brew                  -- Monk
   204336,  -- Grounding Totem (Player Spell)      -- Shaman
   8178,    -- Grounding Totem (Totem Spell)       -- Shaman
}
  for i = 1, #immunstun do
    local immunstunName = _G.GetSpellInfo(immunstun[i])
	 if _G.UnitBuff(target, immunstunName) then
    	return true end
  end
end)

--/dump NeP.DSL.Parse("target.immune_spell", "", "")
NeP.DSL:Register("immune_spell",function(target)
 local immunspell = { 31224, 65961, 81549, 213915, 114028, 23920, 216890, 57643, 48707 }
  for i = 1, #immunspell do
    local immunspellName = _G.GetSpellInfo(immunspell[i])
	 if _G.UnitBuff(target, immunspellName) then
    	return true end
  end
end)

--/dump NeP.DSL.Parse("target.Garrote_Silence", "", "")
NeP.DSL:Register("Garrote_Silence", function(target)
   if _G.UnitDebuff(target, _G.GetSpellInfo(1330)) then
     return true
   end
end)

--/dump NeP.DSL.Parse("buff_of_the_bones", "", "")
--DK骨盾buff
NeP.DSL:Register("buff_of_the_bones", function()
  local roll = 0
    if NeP.DSL:Get("buff.duration")("player", _G.GetSpellInfo(193357)) > 1.5 then  roll = roll + 2 end -- Shark Infested Waters
    if NeP.DSL:Get("buff.duration")("player", _G.GetSpellInfo(193359)) > 1.5 then  roll = roll + 2 end -- True Bearing
    if NeP.DSL:Get("buff.duration")("player", _G.GetSpellInfo(199603)) > 1.5 then  roll = roll + 1 end -- Jolly Roger
    if NeP.DSL:Get("buff.duration")("player", _G.GetSpellInfo(193358)) > 1.5 then  roll = roll + 1 end -- Grand Melee
    if NeP.DSL:Get("buff.duration")("player", _G.GetSpellInfo(199600)) > 1.5 then  roll = roll + 1 end -- Buried Treasure
    if NeP.DSL:Get("buff.duration")("player", _G.GetSpellInfo(193356)) > 1.5 then  roll = roll + 2 end -- Broadsides
    if _G.UnitDebuff("player", _G.GetSpellInfo(202665)) then roll = roll + 1 end -- Curse of the Dreadblades
    if roll > 1 then
    return true
   end
end)

--/dump NeP.DSL.Parse("target.enemy_totem", "", "")
NeP.DSL:Register("enemy_totem", function(target)
 local TotemsID = { 
   2630,   -- Earthbind Totem
   113845, -- Totem Mastery
   102392, -- Resonance Totem
   106317, -- Storm Totem
   106319, -- Ember Totem
   106321, -- Tailwind Totem
   3527,   -- Healing Stream Totem
   59764,  -- Healing Tide Totem
   5925,   -- Grounding Totem
   53006,  -- Spirit Link Totem
}
  for i = 1, #TotemsID do
   local TotemsName = TotemsID[i]
	if NeP.DSL:Get("id")(target, TotemsName) then
    	return true
	end
  end
end)

--/dump NeP.DSL.Parse("isgcd", "", "")
NeP.DSL:Register("isgcd", function()
    if NeP.DSL:Get("spell.cooldown")("player", "61304") > 0.0000 then
	  return true
	end
end)

--USAGE UNIT.inRange(SPELL_NAME).spell
--/dump NeP.DSL.Parse("target.inRange(真言术：韧).spell","","")
--测试是否在施法范围内
NeP.DSL:Register("inRange.spell", function(target, spell)
  local spellIndex, spellBook = NeP.Core:GetSpellBookIndex(spell)
   if not spellIndex then return false end
   if spellIndex and _G.IsSpellInRange(spellIndex, spellBook, target) == 1 then
  return true end
end)
 
-- Arcane Mage 3x(Arcane Missile!) Condition 
--/dump NeP.DSL.Parse("missile.ready", "", "")
--奥术飞弹准备完毕。。。
NeP.DSL:Register("missile.ready", function()
  if NeP.DSL:Get("buff.count")("player", _G.GetSpellInfo(79683)) == 3 then
	return true
  end
end)

--/dump NeP.DSL.Parse("dungeon.interrupts", "", "")
--副本打断列表
NeP.DSL:Register("dungeon.interrupts", function(target)
local cast = { 
    196392, 226206, 226269, 226285, 211007, 203176,  -- Arcway
    194657, 199514, 198405, 194266, 195293, 198407, 198495,  -- MoS
    225573, 196883, 200248, -- BrH
    202181, 193585, -- NL
    215204, 211299, 211470, 211401, 208165, 209413, 209485, 209404, 225100, -- CoS
    200658, 200642, 204243, 201411, -- DHT
    218532, 196870, 195108, 195129, 195046, 197502, 196027, 196175, 192003, -- EoA
    198595, 198931, 198934, 198962, 198959, 192563, 192288, 199726, 198750, -- HoV
    193069, 191595, 191823, 194675, 202661, 201488, 195332, -- VotW
    --228255, 228239, 227917, 232115, 228280, 228279, 228277, 226316, 228625, 227823, 227800, 227545, 227616, 227542, 228606, 229307, 36247, 227628, 227592, 229714, 211464, 229083, 230084, -- Karazhan (Upper + Lower)
    --205112, 224453, 224460, 204963, -- VH
    221059, 205070, 223392, 225042, 223565, 208697, 225079, 205300, 211368, 223038, 223590, 222939,  -- EN Raid
}
    for i = 1, #cast do
     local SpellName = _G.GetSpellInfo(cast[i])
    if NeP.DSL:Get("casting")(target, SpellName) and not _G.UnitIsPlayer(target) and NeP.DSL:Get("indungeon")(nil) then
      return true end
  end
end)

--[[USAGE: instanceType == none --when outside an instance
pvp --when in a battleground
arena --when in an arena
party --when in a 5-man instance
raid --when in a raid instance
nil --when in an unknown kind of instance, eg. in a scenario]]

--/dump NeP.DSL.Parse("instanceType", "", "")
NeP.DSL:Register("instanceType", function()
  if select(1, _G.IsInInstance()) then
   return select(2, _G.IsInInstance())
  end
end)

--/dump NeP.DSL.Parse("pvp.area", "", "")
NeP.DSL:Register("pvp.area", function()
  if NeP.DSL:Get("instanceType")(nil) == "arena" or NeP.DSL:Get("instanceType")(nil) == "pvp" then
    return true 
  end 
   return false
end)

--/dump NeP.DSL.Parse("indungeon", "", "")
NeP.DSL:Register("indungeon", function()
  if NeP.DSL:Get("instanceType")(nil) == "party" or NeP.DSL:Get("instanceType")(nil) == "raid" then 
    return true 
  end 
   return false
end)

--/dump GetSpellAutocast("Waterbolt")
--/dump NeP.DSL.Parse("PetSpell(Waterbolt).autocast", "", "")
NeP.DSL:Register("PetSpell.autocast", function(_, spell)
  if select(1, _G.HasPetUI()) then
  return select(2, _G.GetSpellAutocast(spell)) 
  end
end)

--/dump NeP.DSL.Parse("PetUIExists", "", "")
NeP.DSL:Register("PetUIExists", function()
  return select(1, _G.HasPetUI())
end)

--/dump NeP.DSL.Parse("target.fixRange", "", "")
NeP.DSL:Register("fixRange", function(target)
   return NeP.Protected.Distance("player", target)
end)

--/dump NeP.DSL.Parse("player.rangebetween(target)", "", "")
NeP.DSL:Register("rangebetween", function(unit, unit2)
  return NeP.Protected.Distance(unit, unit2)
end)

-- Checks if the player has autoattack toggled currently (Hunters Specificaly)
-- Use {'/startattack', '!isshooting'}, at the top of a CR to force autoattacks
NeP.DSL:Register("isshooting", function(target)
  return _G.IsCurrentSpell(75)
end)

--/dump NeP.DSL.Parse("IsMounted", "", "")
NeP.DSL:Register("IsMounted", function()
  return SecureCmdOptionParse("[overridebar][vehicleui][possessbar,@vehicle,exists][mounted]true")
end)

--/dump NeP.DSL.Parse("target.InLOS", "", "")
--视线内
NeP.DSL:Register("InLOS", function(target)
  if _G.UnitExists(target) and _G.UnitIsVisible(target) then
  return NeP.Protected.LineOfSight("player", target) end
end)

--/dump NeP.DSL.Parse("IsStealthed", "", "")
--是否潜行 貌似只能看到自己
NeP.DSL:Register("IsStealthed", function()
  return _G.IsStealthed()
end)

--那些目标是我或者我的队友的怪 或者 红名怪 怎么写

--获取指定范围内最近且血量小于指定值的人数 用于治疗祷言这种奇葩
NeP.DSL:Register("area.heal", function(unit, args)
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

NeP.DSL:Register("NearestFriendly",function(unit,args)
--先范围内所有人，根据距离从小到大排序取距离最近的若干个，之后查看前若干个的血量是否低于指定百分比，若低于，累加计数
  return 0
end)




--------------------------------------------------------------------------------
------------------------------ Xeer-TRAVEL SPEED--------------------------------
--------------------------------------------------------------------------------

-- List of know spells travel speed. Non charted spells will be considered traveling 40 yards/s
-- To recover travel speed, open up /eventtrace, calculate difference between SPELL_CAST_SUCCESS and SPELL_DAMAGE events

-- Return the time a spell will need to travel to the current target

-- /dump NeP.DSL.Parse("target.spell(Pyroblast).traveltime", "", "")
-- 弹道的飞行时间
NeP.DSL:Register("spell.traveltime", function(unit, spell)
  local Travel_Chart = {
    [116]    = 23.174, -- Frostbolt
    [228597] = 23.174, -- Frostbolt
    [133]    = 45.805, -- Fireball
    [11366]  = 52, -- Pyroblast
    [29722]  = 18, -- Incinerate
    [30455]  = 25.588, -- Ice Lance
    [105174] = 33, -- Hand of Gul'dan
    [120644] = 10, -- Halo
    [122121] = 25, -- Divine Star
    [127632] = 19, -- Cascade
    [210714] = 38, -- Icefury
    [51505]  = 38.090, -- Lava Burst
    [205181] = 32.737, -- Shadowflame
}
	local spellID = NeP.Core:GetSpellID(spell)
	if Travel_Chart[spellID] then
		TravelSpeed = Travel_Chart[spellID]
		return NeP.DSL:Get("distance")(unit) / TravelSpeed
	else
		return 0
	end
end)

