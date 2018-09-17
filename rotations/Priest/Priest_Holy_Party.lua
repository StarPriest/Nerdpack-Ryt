local _, yobleed = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    --texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\holy.blp",
    width = 512, 
    height = 256, 
    offset = 90, 
    y = 42, 
    center = true},


    {type = 'header', text = '通用设置', align = 'center'},
    {type = 'checkbox', text = '天堂之羽', key = 'key_AF', width = 55, default = true},
    {type = 'checkspin',text = '食物', key = 'key_Food', check = false, spin = 80},
    {type = 'checkspin',text = '饮料', key = 'key_Drink', check = true, spin = 80},
    {type = 'checkbox', text = '烹饪', key = 'key_Cooking', width = 55, default = false},
    {type = 'checkbox', text = '战斗中检测buff', key = 'key_CheckBuffInCombat', width = 55, default = true},
    {type = 'ruler'},{type = 'spacer'},
    {type = 'header', text = '队伍模式设置', align = 'center'},
    {type = 'ruler'},{type = 'spacer'},


}

local exeOnLoad = function()
    print('|cffFACC2E 神牧战斗策略已载入|r')
    print('|cffff0000 设置项: |r右键主开关可找到|r')
  end

local purfy ={   
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
    {'纯净术','debuff(腐败之血).any & distance < 40','friendly'},
    --地渊孢林

    {'纯净术','debuff(化学灼烧).any & distance < 30','friendly'},
    {'纯净术','debuff(浸油之刃).any & distance < 30','friendly'},
    --远离人群多少码驱散 如：area(10).friendly == 0  意思就是10码内没人
    --{'纯净术','debuff(debuff名称).any & distance < 40 & area(10).friendly == 0','friendly'},

}

local dispel ={
    
    {'驱散魔法','buff(水之护盾).any & distance < 30','enemies'},
    {'驱散魔法','buff(力量药水).any & distance < 30','enemies'},
    {'驱散魔法','buff(敏捷药剂).any & distance < 30','enemies'},
    {'驱散魔法','buff(健康补益).any & distance < 30','enemies'},
    {'驱散魔法','buff(积攒电荷).any & distance < 30','enemies'},
    {'驱散魔法','buff(黑影步).any & distance < 30','enemies'},
    {'驱散魔法','buff(流水护甲).any & distance < 30','enemies'},
    {'驱散魔法','buff(大地之盾).any & distance < 30','enemies'},
    --地渊孢林
    {'驱散魔法','buff(戈霍恩之赐).any & distance < 30','enemies'},
    {'驱散魔法','buff(白骨之盾).any & distance < 30','enemies'},
    {'驱散魔法','buff(衰弱意志).any & distance < 30','enemies'},
    --塞塔里斯神庙
    {'驱散魔法','buff(胚胎精华).any & distance < 30','enemies'},
    {'驱散魔法','buff(带电鳞片).any & distance < 30','enemies'},
    {'驱散魔法','buff(积攒电荷).any & distance < 30','enemies'},
    --托尔达戈

    --暴富矿区
    {'驱散魔法','buff(脑部冻结).any & distance < 30','enemies'},
    {'驱散魔法','buff(腐蚀性化合物).any & distance < 30','enemies'},
    {'驱散魔法','buff(转化：粘液).any & distance < 30','enemies'},
    
}

--加速
local boostSpeed =
{
    --羽毛
    {'天堂之羽','UI(key_AF) & talent(2,3) & player.moving & !buff(天堂之羽)','player.ground'},
}

--真言术：耐
local BuffCheck ={
    {'真言术：韧','!buff(真言术：韧)','player'},
    {'真言术：韧','friendly.distance < 40 & !buff(真言术：韧)','friendly'},
}

--队伍模式战斗中治疗策略
local inCombat_Party ={
    
    {'/use 治疗石','player.health < 30 & item(5512).usable & item(5512).count>0'},
    {'/use 海滨治疗药水','spell(绝望祷言).cooldown > 0 & player.health < 30 & item(152494).usable & item(152494).count>0'},
    {'/use 海滨活力药水','spell(绝望祷言).cooldown > 0 & player.health < 30 & item(163082).usable & item(163082).count>0 & item(163082).cooldown == 0'},
    {'/use 海滨法力药水','player.mana < 30 & item(152495).usable & item(152495).count>0'},
    {purfy},
    {dispel},
    --化身条件有问题 莫名其妙开。
    {'神圣化身','area(40,50).heal >= 2 || {tank.health < 30 & tank.distance < 40}','player'}, --增加范围识别
    --当自己血量低于35% 绝望祷言
    {'!绝望祷言','player.health < 30','player'},
    --当自己血量低于15% 翅膀
    {'!守护之魂','player.health < 15','player'},
    --当T血量低于10% 翅膀
    {'!守护之魂','tank.health < 20','tank'},
    --当dps血量低于15% 翅膀
    {'!守护之魂','lowest.health < 10','lowest'},
    --愈合祷言 前提是没人血危
    {'愈合祷言', 'tank.health>30 & tank.alive & !player.moving & lowest.health >55 & !buff(愈合祷言)', {'tank','player','lowest'}},
    -- 治疗祷言 前提是没人血危
    {'治疗祷言','tank.health>30 & tank.alive & lowest.health >35 & lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & lowest.area(40,80).heal > 3 & !player.moving','lowest'},
    -- 圣言术：灵
    --{'光晕','player.area(30,85)>10 & talent(6,3)'},
    {'!圣言术：灵','lowest.distance<40 & lowest.area(10,80).heal > 3','lowest.ground'},
    -- 联结治疗（天赋5,2）
    {'!联结治疗','spell(圣言术：静).cooldown>0 & lowest.distance < 40 & lowest.area(20,80).heal > 0 & spell(圣言术：灵).cooldown>0 & !player.moving & talent(5,2)','lowest'},
   -- 快速治疗 无论有无瞬发buff
   {'快速治疗','spell(圣言术：静).cooldown>0 & distance < 40 & health < 75 & !player.moving','tank'},       
    -- 快速治疗 无论有无瞬发buff
    {'快速治疗','tank.health>30 & tank.alive & spell(圣言术：静).cooldown>0 & lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},    
    -- 快速治疗2 有瞬发buff 
    {'!快速治疗','{player.moving || player.buff(圣光涌动).duration<=3 || lowest.health < 40} & spell(圣言术：静).cooldown>0 & player.buff(圣光涌动) & lowest.distance < 40 & lowest.health < 85','lowest'},  
    -- 圣言术：静
    {'!圣言术：静','lowest.distance < 40 & lowest.health < 70','lowest'},
    --治疗术
    --{'治疗术','distance < 40 & health < 90 & !player.moving','lowest'},
    --恢复
    {'恢复','!buff(恢复) & distance < 40 & health > 70','tank'}


}
--震耳咆哮
local inCombat={
    {boostSpeed},    
    {BuffCheck,'UI(key_CheckBuffInCombat)'},
    {'渐隐术','target(player)','enemies'},
    {'圣言术：罚','casting(震耳咆哮)','enemies'},
    {inCombat_Party},
    
}

--吃食物
local eatFood = {
    --山羊肉干 163052
    --雪莓奶油茶 159878
    --炸黄油曲奇 163107 
    --提拉加德尖奶酪 159874 这个回复量是十五万，其余是十万
    {'/use 山羊肉干','!buff(进食) & health < 80 & item(163052).count > 0'},
    {'/use 雪莓奶油茶','!buff(进食) & health < 80 & item(159878).count > 0'},
    {'/use 炸黄油曲奇','!buff(进食) & health < 80 & item(163107).count > 0'},
    {'/use 提拉加德尖奶酪','!buff(进食) & health < 80 & item(159874).count > 0'},
}

--喝水
local drinkWater = {
    --跃岩矿泉水 159867
    --159868 散养羊奶
    {'/use 散养羊奶','!buff(喝水) & mana < 80 & item(159868).count > 0'},    
    {'/use 跃岩矿泉水','!buff(喝水) & mana < 80 & item(159867).count > 0'},
    {'/use 魔法汉堡','!buff(进食饮水) & mana < 80 & item(159867).count > 0'},
}

--吃喝
local eatAnddrink={
    {eatFood,'UI(key_Food_check) & !buff(进食) & !moving & health<UI(key_Food_spin)'},
    {drinkWater,'UI(key_Drink_check) & !buff(喝水) & !moving & mana<UI(key_Drink_spin)'},
    --{eatCooking,'UI(key_Cooking)'},
    {'/stand','mana > 80 & {buff(喝水) || buff(进食)}'},
   
}

--队伍模式非战斗状态策略
local outCombat_Party ={
    {BuffCheck},
    -- 治疗祷言
    {'治疗祷言','lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & lowest.area(40,85).heal > 2 & !player.moving'},
    -- 圣言术：灵
    {'圣言术：灵','lowest.distance<40 & lowest.area(10,85).heal > 2','lowest.ground'},
    -- 联结治疗（天赋5,2）
    {'联结治疗','lowest.distance < 40 & lowest.area(20,80).heal > 0 & spell(圣言术：灵).cooldown> 0 & !player.moving & talent(5,2)','lowest'},
    -- 快速治疗
    {'快速治疗','lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},       
    -- 圣言术：静
    {'圣言术：静','lowest.distance < 40 & lowest.health<70','lowest'},
   
   
    
}

--非战斗状态策略
local outCombat={
    {BuffCheck},
    {eatAnddrink},
    {boostSpeed},    
    {outCombat_Party},   
    --{'群体复活','area(100).dead'},
}

local blacklist = {
    debuff = {name = "Misery"},
}

local Spell_wow801_Priest_Holy={

}

NeP.CR:Add(257, {
    name = '|cffFACC2E [老日]|r 神牧 - |cffFACC2E五人本|r',
    ic = {{inCombat,'group.type == 2 & !player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    ooc = {{outCombat,'group.type == 2 & !player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    gui = GUI,
    gui_st = {title='老日的牧师助手-神牧', width='512', height='256', color='FACC2E'},
    ids = Spell_wow801_Priest_Holy,
    load = exeOnLoad,    
    blacklist = blacklist
  
  })