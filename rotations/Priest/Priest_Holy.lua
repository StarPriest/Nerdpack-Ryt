local _, yobleed = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\holy.blp",
    width = 512, 
    height = 256, 
    offset = 90, 
    y = 42, 
    center = true},


    {type = 'header', text = '通用设置', align = 'center'},

    {type = 'checkbox', text = '天堂之羽', key = 'key_AF', width = 55, default = true},
    {type = 'checkspin',text = '食物', key = 'key_Food', check = false, spin = 80},
    {type = 'checkspin',text = '饮料', key = 'key_Drink', check = false, spin = 80},
    {type = 'checkbox', text = '烹饪', key = 'key_Cooking', width = 55, default = false},
    {type = 'checkbox', text = '战斗中检测buff', key = 'key_CheckBuffInCombat', width = 55, default = true},

    {type = 'ruler'},{type = 'spacer'},

    {type = 'header', text = '单人模式设置', align = 'center'},
    {type = 'ruler'},{type = 'spacer'},

    {type = 'header', text = '队伍模式设置', align = 'center'},
    {type = 'ruler'},{type = 'spacer'},


}

local exeOnLoad = function()
    print('|cffFACC2E 神牧战斗策略已载入|r')
    print('|cffff0000 设置项: |r右键主开关可找到|r')
  --[[
      NeP.Interface:AddToggle({
      key = 'xDPS',
      name = 'DPS Mode',
      text = 'ON/OFF DPS Mode',
      icon = 'Interface\\ICONS\\inv_staff_2h_artifactheartofkure_d_06', --toggle(xDPS)
    })
  
    NeP.Interface:AddToggle({
      key = 'disp',
      name = 'dispel',
      text = 'ON/OFF Dispel All',
      icon = 'Interface\\ICONS\\spell_holy_dispelmagic', --toggle(disp)
    })
  
    NeP.Interface:AddToggle({
      key = 'mana',
      name = 'Mana Management',
      text = 'ON/OFF Mana Management',
      icon = 'Interface\\ICONS\\inv_misc_ancient_mana', --toggle(mana)
    })
      ]]
  end

--圣言术：灵



--设置项
--[[ 战斗中
    单人模式
        恢复
        愈合祷言
        治疗术
        快速治疗
        圣言术：静
        守护之魂
        希望象征
        天堂之羽
        渐隐术
        心灵尖啸
        真言术：韧
        神圣赞美诗
        束缚亡灵
        治疗祷言
        漂浮术
        神圣新星
        精神控制
        绝望祷言
        纯净术
        驱散魔法
        群体驱散
        复活术
        群体复活
        


        神圣之火
        惩击

        
    队伍模式

    团队模式
]]

--开关项
--[[
    1.开关dps功能
    2.开关吃药
    3.开关吃烹饪
    
]]




local purfy =
{   
    --注意 指定buff层数远离人群这种。 可以写出来 利用区域检测 暗影束缚
    --指定buff层数 去指定地点写不出来 
    {'纯净术','debuff(烈焰震击).any & distance < 40','friendly'},
    {'纯净术','debuff(毒蛇诱惑).any & distance < 40','friendly'},
    {'纯净术','debuff(瘟疫).any & distance < 40','friendly'},
    {'纯净术','debuff(感染之伤).any & distance < 40','friendly'},
    {'纯净术','debuff(火把攻击).any & distance < 40','friendly'},
    {'纯净术','debuff(衰弱怒吼).any & distance < 40','friendly'},
    {'纯净术','debuff(火力压制).any & distance < 40','friendly'},
    {'纯净术','debuff(点火器).any & distance < 40','friendly'},
    {'纯净术','debuff(正义烈焰).any & distance < 40','friendly'},
    {'纯净术','debuff(冰霜震击).any & distance < 40','friendly'},

}

local dispel =
{
    {'驱散魔法','buff(带电鳞片).any & distance < 30','enemies'},
    {'驱散魔法','buff(水之护盾).any & distance < 30','enemies'},
    {'驱散魔法','buff(力量药水).any & distance < 30','enemies'},
    {'驱散魔法','buff(敏捷药剂).any & distance < 30','enemies'},
    {'驱散魔法','buff(健康补益).any & distance < 30','enemies'},
    {'驱散魔法','buff(积攒电荷).any & distance < 30','enemies'},
    {'驱散魔法','buff(黑影步).any & distance < 30','enemies'},
    {'驱散魔法','buff(流水护甲).any & distance < 30','enemies'},
    {'驱散魔法','buff(大地之盾).any & distance < 30','enemies'},
    
}

--加速
local boostSpeed =
{
    --羽毛
    {'Angelic Feather','UI(key_AF) & talent(2,3) & player.moving & !player.buff(Angelic Feather)','player.ground'},
}

--真言术：耐
local BuffCheck =
{
    {'Power Word: Fortitude','group.type==1 & !player.buff(Power Word: Fortitude)','player'},
    {'Power Word: Fortitude','friendly.distance<40 & group.type ==2 & !buff(Power Word: Fortitude)','friendly'},
}


--队伍模式战斗中治疗策略
local inCombat_Party =
{
    
    {'/use 治疗石','player.health < 30 & item(5512).usable & item(5512).count>0'},
    {'/use 海滨治疗药水','spell(Desperate Prayer).cooldown > 0 & player.health < 30 & item(152494).usable & item(152494).count>0'},
    {'/use 海滨活力药水','spell(Desperate Prayer).cooldown > 0 & player.health < 30 & item(163082).usable & item(163082).count>0 & item(163082).cooldown == 0'},
    {'/use 海滨法力药水','player.mana < 30 & item(152495).usable & item(152495).count>0'},
    --{'/use 缠结精华之牙','player.mana < 90 & item(158368).cooldown ==0'},
    {purfy},
    {dispel},
    --化身条件有问题 莫名其妙开。
    {'神圣化身','area(40,50).heal >= 2 || {tank.health <30 & tank.distance < 40}','player'}, --增加范围识别
    --当自己血量低于35% 绝望祷言
    {'!Desperate Prayer','player.health < 30','player'},
    --当自己血量低于15% 翅膀
    {'!Guardian Spirit','player.health < 15','player'},
    --当T血量低于10% 翅膀
    {'!Guardian Spirit','tank.health < 20','tank'},
    --当dps血量低于15% 翅膀
    {'!Guardian Spirit','lowest.health < 10','lowest'},
    --愈合祷言 前提是没人血危
    {'Prayer of Mending', 'tank.health>30 & tank.alive & !player.moving & lowest.health >55 & !buff(Prayer of Mending)', {'tank','player','lowest'}},
    -- 治疗祷言 前提是没人血危
    {'Prayer of Healing','tank.health>30 & tank.alive & lowest.health >35 & lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & lowest.area(40,80).heal > 3 & !player.moving','lowest'},
    -- 圣言术：灵
    {'光晕','player.area(30,85)>10 & talent(6,3)'},
    {'!Holy Word: Sanctify','lowest.distance<40 & lowest.area(10,80).heal > 3','lowest.ground'},
    -- 联结治疗（天赋5,2）
    {'!Binding Heal','spell(Holy Word: Serenity).cooldown>0 & lowest.distance < 40 & lowest.area(20,80)>0 & spell(Holy Word: Sanctify).cooldown>0 & !player.moving & talent(5,2)','lowest'},
   -- 快速治疗 无论有无瞬发buff
   {'Flash Heal','spell(Holy Word: Serenity).cooldown>0 & distance < 40 & health < 75 & !player.moving','tank'},    
   
    -- 快速治疗 无论有无瞬发buff
    {'Flash Heal','tank.health>30 & tank.alive & spell(Holy Word: Serenity).cooldown>0 & lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},    
    -- 快速治疗2 有瞬发buff 
    {'!Flash Heal','{player.moving || player.buff(Surge of Light).duration<=3 || lowest.health < 40} & spell(Holy Word: Serenity).cooldown>0 & player.buff(Surge of Light) & lowest.distance < 40 & lowest.health < 85','lowest'},  
    -- 圣言术：静
    {'!Holy Word: Serenity','lowest.distance < 40 & lowest.health < 70','lowest'},
    --治疗术
    --{'Heal','lowest.distance < 40 & lowest.health < 90 & !player.moving','lowest'},
    --恢复
    --{'Renew','!tank.buff(Renew) & tank.distance < 40 & tank.health > 70','tank'}


}







local inCombat=
{
    {boostSpeed},
    
    {BuffCheck,'UI(key_CheckBuffInCombat)'},
    {inCombat_Party},
    
}

--吃食物
local eatFood = 
{

}
--吃烹饪
local eatCooking =
{

}

--喝水
local drinkWater = 
{
    --159868 散养羊奶
    {'#159868',' item(159868).count>0'},    
}

--喝完水，站立,直接给自己上个恢复
local Standup =
{

}


--吃喝
local eatAnddrink=
{
    --{eatFood，'UI(key_Food_check) & !player.buff(吃) & player.moving & player.health<UI(key_Food_spin)'},
    {drinkWater,'UI(key_Drink)'},
    {eatCooking,'UI(key_Cooking)'},
    --{Standup},    
}
--单人模式非战斗状态策略
local outCombat_Solo =
{    
    --血量低于70 圣言术：静
    {'Holy Word: Serenity','player.health<70','player'},
    --血量低于80 快速治疗
    {'Flash Heal','player.health<80','player'},
    --血量低于90 治疗术
    {'Heal','player.health<90','player'},
    --血量低于95 恢复
    {'Renew','player.health<100 & !player.buff(Renew)','player'},    
    {eatAnddrink},
    {'%ressdead(群体复活)'},


}
--队伍模式非战斗状态策略
local outCombat_Party =
{
    {BuffCheck},
    -- 治疗祷言
    {'Prayer of Healing','lowest.distance < 40 & spell(Holy Word: Sanctify).cooldown>0 & lowest.area(40,85).heal > 2 & !player.moving'},
    -- 圣言术：灵
    {'Holy Word: Sanctify','lowest.distance<40 & lowest.area(10,85).heal>2','lowest.ground'},
    -- 联结治疗（天赋5,2）
    {'Binding Heal','lowest.distance < 40 & lowest.area(20,80)>0 & spell(Holy Word: Sanctify).cooldown>0 & !player.moving & talent(5,2)','lowest'},
    -- 快速治疗
    {'Flash Heal','lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},       
    -- 圣言术：静
    {'Holy Word: Serenity','lowest.distance < 40 & lowest.health<70','lowest'},
}


--非战斗状态策略
local outCombat=
{
    --{'驱散魔法','buff(水之护盾).any','enemies'},
   
    {BuffCheck},
    {eatAnddrink},
    {boostSpeed},    
    {outCombat_Party},
    
}

local blacklist = {
    debuff = {name = "Misery"},
}

local Spell_wow801_Priest_Holy={

}


NeP.CR:Add(257, {
    name = '|cffFACC2E [老日]|r 老年人助手 - |cffFACC2E神牧|r',
    ic = {{inCombat,'!player.channeling(Divine Hymn)'}},
    ooc = {{outCombat,'!player.channeling(Divine Hymn)'}},
    gui = GUI,
    gui_st = {title='老日的牧师助手-神牧', width='512', height='256', color='FACC2E'},
    ids = Spell_wow801_Priest_Holy,
    load = exeOnLoad,  
    blacklist = blacklist
  
  })