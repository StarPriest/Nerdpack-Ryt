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
    NeP.Interface:AddToggle({
        key = 'bqjg',
        name = '冰枪拉怪/蹭怪',
        text = '方便做任务',
        icon = 'Interface\\ICONS\\spell_frost_frostblast', --toggle(disp)
      })

      NeP.Interface:AddToggle({
        key = 'dt',
        name = '单体输出',
        text = '单体输出模式',
        icon = 'Interface\\ICONS\\spell_frost_frostblast', --toggle(disp)
      })

      NeP.Interface:AddToggle({
        key = 'aoe',
        name = 'AOE',
        text = 'AOE模式',
        icon = 'Interface\\ICONS\\spell_frost_frostblast', --toggle(disp)
      })

      NeP.Interface:AddToggle({
        key = 'cm',
        name = '法术反制',
        text = '自动打断',
        icon = 'Interface\\ICONS\\spell_frost_frostblast', --toggle(disp)
      })
  end


local HealStone ={
    --当绝望祷言CD且我血量低于20%时使用
    {'!/use 治疗石','UI(Key_UseHS_check) & spell(绝望祷言).cooldown > 0 & player.health < UI(Key_UseHS_spin) & item(5512).usable & item(5512).count>0'},
}


local interrupt ={
    {'法术反制','distance < 40 & casting(快速治疗) & health < 20 & interruptAt(10)','enemies'},

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


local test1 = {
    -- 有黑冰箭和无黑冰箭是2个职业！马丹输出循环完全不一样的。


    {'寒冰箭','infront & player.buff(冰刺).count < 5 & {!player.buff(冰冷智慧) || {player.buff(冰冷智慧) & player.buff(冰刺).count >= 3}} & !player.buff(寒冰指) & !target.debuff(冰风暴)','target'},
    {'冰风暴','infront & player.buff(冰刺).count < 3 & player.buff(冰冷智慧)','target'},
    {'冰枪术','infront & target.debuff(冰风暴)','target'},
    {'冰枪术','infront & player.buff(寒冰指)','target'},
    {'冰川尖刺','infront & player.buff(冰刺).count == 5','target'},


}

local singletarget = {
 --三层以下冰冷智慧随便放，三层以上留到四层
    {'冰川尖刺','infront & {!player.moving || player.buff(浮冰)} & talent(7,3) & player.buff(199844)','target'},
    {'冰风暴','infront & player.buff(冰冷智慧) & {player.buff(冰刺).count < 3 || player.buff(199844)}','target'},
    --{'冰枪术','infront & {debuff(寒冰新星) || debuff(冰霜新星) || debuff(冰冻术) || debuff(228600) || debuff(冰风暴)}','target'},   
    {'冰枪术','infront & debuff(寒冰新星)','target'},   
    {'冰枪术','infront & debuff(冰霜新星)','target'},   
    {'冰枪术','infront & debuff(冰冻术)','target'},   
    {'冰枪术','infront & debuff(228600)','target'},   
    {'冰枪术','infront & debuff(冰风暴)','target'},   
    {'冰枪术','infront & player.buff(寒冰指)','target'}, 
    {'冰枪术','infront & player.moving & !player.buff(浮冰)','target'}, 
    {'彗星风暴','talent(6,3) & player.buff(冰刺).count < 4 & area(6).enemies.count > 3','target'},
    {'暴风雪','player.buff(冰冻之雨) & talent(6,1)','target.ground'},
    {'寒冰新星','player.buff(冰刺).count < 4','target'},
   -- {'黑冰箭','talent(4,3) & infront & {!player.moving || player.buff(浮冰)} & player.buff(冰刺).count==4 & !player.buff(冰冷智慧) & !player.buff(寒冰指) ','target'},
   {'黑冰箭','talent(4,3) & infront & {!player.moving || player.buff(浮冰)} & player.buff(冰刺).count==4 & player.buff(冰冷智慧) & !player.buff(寒冰指) ','target'},
   {'黑冰箭','talent(4,3) & infront & {!player.moving || player.buff(浮冰)} & player.buff(冰刺).count==5 & !player.buff(冰冷智慧) & !player.buff(寒冰指) ','target'},
    {'寒冰箭','infront & {!player.moving || player.buff(浮冰)} & !player.buff(199844) & {!player.buff(冰冷智慧) || {player.buff(冰冷智慧) & player.buff(冰刺).count >= 3}} & !player.buff(寒冰指) & !debuff(寒冰新星) & !debuff(冰霜新星) & !debuff(冰冻术) & !debuff(228600) & !debuff(冰风暴)','target'},    
 
    
}



local inCombat ={
    -- 当所有药水或者治疗石CD且血量低于10% 冰箱
    {HealStone},
    {Posion},
    {'!急速冷却','spell(寒冰屏障).cooldown > 0 & {!item(152494).usable || item(152494).count == 0} & {!item(163082).usable || item(163082).count == 0} & {!item(5512).usable || item(5512).count == 0} & health <= 10','player'},
    {'!寒冰屏障',' {!item(152494).usable || item(152494).count == 0} & {!item(163082).usable || item(163082).count == 0} & {!item(5512).usable || item(5512).count == 0} & health <= 10','player'},
    {Buffcheck},     
    {'冰枪术','health.actual > 100 & infront & toggle(bqjg)','target'},
    --{test1,'telent(4,1) & !toggle(bqjg) & !target.friend'},
    --{test2,'telent(4,3) & !toggle(bqjg) & !target.friend'},
    {singletarget,'!toggle(bqjg) & !target.friend'},


}

local outCombat ={    
    {'#8529','!buff(16591) & item(16591).cooldown == 0','player'},   
    {HealStone},
    {Posion},
    {'!寒冰屏障','{!item(152494).usable || item(152494).count == 0} & {!item(163082).usable || item(163082).count == 0} & {!item(5512).usable || item(5512).count == 0} & health <= 10','player'},
    {Buffcheck},
    {'召唤水元素','!pet.exists'},

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