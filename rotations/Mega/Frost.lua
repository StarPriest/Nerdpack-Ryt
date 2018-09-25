--local _, RYT = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    --texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\holy.blp",
    width = 512, 
    height = 400, 
    offset = 90, 
    y = 42, 
    center = true},
}

local exeOnLoad = function()
    print('|cffFACC2E 冰法战斗策略已载入|r')
    print('|cffff0000 设置项: |r右键主开关可找到|r')    
  end


local HealStone ={
    --当绝望祷言CD且我血量低于20%时使用
    {'!/use 治疗石','UI(Key_UseHS_check) & spell(绝望祷言).cooldown > 0 & player.health < UI(Key_UseHS_spin) & item(5512).usable & item(5512).count>0'},
}


--药水
local Posion =
{
    --使用优先级：绝望祷言 糖 治疗药水 活力药水
    {'!/use 海滨治疗药水', 'UI(Key_UseHP_check) & {spell(绝望祷言).cooldown > 0 || !UI(Key_DP)} & player.health < UI(Key_UseHP_spin) & item(152494).usable & item(152494).count > 0'},
    {'!/use 海滨活力药水','UI(Key_UseMHP_check) & {spell(绝望祷言).cooldown > 0 || !UI(Key_DP)} & player.health < UI(Key_UseMHP_spin) & item(163082).usable & item(163082).count >0 & item(152494).cooldown > 0'},
    {'!/use 海滨法力药水','UI(Key_UseMP_check) & player.mana < UI(Key_UseMP_spin) & item(152495).usable & item(152495).count > 0'},
}

local Buffcheck={
    {'奥术智慧','!buff(奥术智慧) & group.type == 1','player'},
    {'奥术智慧','!buff(奥术智慧) & group.type ~= 1','friendly'},
}

local shuchu1={
    --四层冰刺 有 冰冷智慧 
    -- 先放 冰风暴 
    -- 五层冰刺 无冰冷智慧
    -- 黑冰箭没CD 释放黑冰箭
    -- 五层冰刺 有冰冷智慧
    -- 
    
}
--4层冰刺有冰冷智慧
local bc4_yblzh={
    {'寒冰箭','!player.moving || player.buff(浮冰)','target'},
}




local inCombat ={
    -- 当所有药水或者治疗石CD且血量低于10% 冰箱
    {HealStone},
    {Posion},
    {'!急速冷却','spell(寒冰屏障).cooldown > 0 & {!item(152494).usable || item(152494).count == 0} & {!item(163082).usable || item(163082).count == 0} & {!item(5512).usable || item(5512).count == 0} & health <= 10','player'},
    {'!寒冰屏障',' {!item(152494).usable || item(152494).count == 0} & {!item(163082).usable || item(163082).count == 0} & {!item(5512).usable || item(5512).count == 0} & health <= 10','player'},
    {Buffcheck},     
    {'冰川尖刺','{!player.moving || player.buff(浮冰)} & talent(7,3) & player.buff(冰刺).count == 5','target'},
    {'!冰风暴','player.buff(冰冷智慧)','target'},
    {'!冰枪术','target.debuff(冰川尖刺) || target.debuff(冰风暴)','target'},    
    {'!冰枪术','player.buff(寒冰指) & !player.casting(冰川尖刺)','target'},
    {'彗星风暴','player.buff(冰刺).count < 4','target'},
    {'寒冰新星','player.buff(冰刺).count < 4','target'},
    {'寒冰箭','player.buff(冰刺).count < 5','target'},
    
    


}

local outCombat ={    
    {HealStone},
    {Posion},
    {'!寒冰屏障','{!item(152494).usable || item(152494).count == 0} & {!item(163082).usable || item(163082).count == 0} & {!item(5512).usable || item(5512).count == 0} & health <= 10','player'},
    {Buffcheck},

}

local blacklist = {
    debuff = {name = "Misery"},
}

local Spell_wow801_MageFrost=
{

}

NeP.CR:Add(64, {
    name = '|cffFACC2E [老日]|r 冰霜 - |cffFACC2E法师|r',
    ic = inCombat,
    ooc =outCombat,
    gui = GUI,
    gui_st = {title='老日的法师助手-冰法', width='512', height='256', color='FACC2E'},
    ids = Spell_wow801_MageFrost,
    load = exeOnLoad,    
    blacklist = blacklist  
  })