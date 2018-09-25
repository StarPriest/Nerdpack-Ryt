    --[[
        未完成：
        1.战斗中自动下马
        2.
    ]]
local _, yobleed = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    texture = "Interface\\AddOns\\NerdPack-Ryt\\media\\holy.blp",
    width = 512, 
    height = 240, 
    offset = 260, 
    y = 42, 
    center = true},
    {type = 'header', text = '食物管理 设置', size=18,align = 'left'},
    {type = 'checkspin', text = '低于多少法力值时喝水', key = 'Key_Drink', spin = 80, max =100, size=14,check = true},
    {type = 'checkspin', text = '低于多少血量时吃面包', key = 'Key_Food', spin = 90, max =100, size=14,check = true},
    {type = 'spacer'},{type = 'ruler'},{type = 'spacer'},

    {type = 'header', text = '增益管理 设置', size=18,align = 'center'},
    {type = 'checkbox', text = '天堂之羽', key = 'key_AF', width = 55, size=14,default = true},
    {type = 'checkbox', text = '非战斗状态-真言术：韧', key = 'key_OOC_PF', width = 55, size=14,default = true},
    {type = 'checkbox', text = '战斗状态-真言术：韧', key = 'key_IC_PF', width = 55, size=14,default = true},
    {type = 'spacer'},{type = 'ruler'},{type = 'spacer'},
    
    {type = 'header', text = '物品使用 设置', size=18,align = 'center'},
    {type = 'checkspin', text = '启用 海滨法力药水', key = 'Key_UseMP', spin = 30, max =100, size=14,check = true},
    {type = 'checkspin', text = '启用 海滨治疗药水', key = 'Key_UseHP', spin = 20, max =100,size=14,check = true},
    {type = 'checkspin', text = '启用 海滨活力药水', key = 'Key_UseMHP', spin = 20, max =100,size=14,check = true},
    {type = 'checkspin', text = '启用 治疗石', key = 'Key_UseHS', spin = 30, max =100,size=14,check = true},
    {type = 'ruler'},{type = 'spacer'},

    {type = 'header', text = '救急 设置', size=18,align = 'center'},
    {type = 'checkspin', text = '启用 绝望祷言', key = 'Key_DP', spin = 30, size=14,check = true},
    {type = 'checkspin', text = '启用 守护之魂-T', key = 'Key_GT', spin = 20, max=100, size=14,check = true},
    {type = 'checkspin', text = '启用 守护之魂-自己', key = 'Key_GP', spin = 15, size=14,check = true},
    {type = 'checkspin', text = '启用 守护之魂-DPS', key = 'Key_GO', spin = 10, size=14,check = true},
    {type = 'ruler'},{type = 'spacer'},

    {type = 'header', text = '团刷技能 设置', size=18,align = 'center'},
    {type = 'checkbox', text = '启用 愈合祷言', key = 'key_PM', width = 55, size=14,default = true},
    {type = 'checkbox', text = '启用 圣言术：灵', key = 'key_Sanctify', width = 55, size=14,default = true},
    {type = 'spinner', text = '-圣言术：灵 使用最低血量', key = 'key_Sanctify_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-圣言术：灵 使用最低人数', key = 'key_Sanctify_Count', size=14,width = 55, max = 40, step = 1, default = 5},
    {type = 'spacer'},
    {type = 'checkbox', text = '启用 治疗之环', key = 'key_HC', width = 55, size=14,default = true},
    {type = 'spinner', text = '-治疗之环 使用最低血量', key = 'key_HC_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-治疗之环 使用最低人数', key = 'key_HC_Count', size=14,width = 55, max = 40, step = 1, default = 3},
    {type = 'spacer'},
    {type = 'checkbox', text = '启用 治疗祷言', key = 'key_PH', width = 55, size=14,default = true},
    {type = 'spinner', text = '-治疗祷言 使用范围', key = 'key_PH_Range', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-治疗祷言 使用最低血量', key = 'key_PH_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-治疗祷言 使用最低人数', key = 'key_PH_Count', size=14,width = 55, max = 40, step = 1, default = 4},
    {type = 'spacer'},
    {type = 'checkbox', text = '启用 光晕', key = 'key_Hola', width = 55, size=14,default = true},
    {type = 'spinner', text = '-光晕 使用最低血量', key = 'key_Hola_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-光晕 使用最低人数', key = 'key_Hola_Count', size=14,width = 55, max = 40, step = 1, default = 10},
    {type = 'spacer'},
    {type = 'checkbox', text = '启用 圣言术：赎', key = 'key_Salvation', width = 55, size=14,default = true},
    {type = 'spinner', text = '-圣言术：赎 使用最低血量', key = 'key_Salvation_Health', size=14,width = 55, max = 100, step = 1, default = 40},
    {type = 'spinner', text = '-圣言术：赎 使用最低人数', key = 'key_Salvation_Count', size=14,width = 55, max = 40, step = 1, default = 20},
    {type = 'ruler'},{type = 'spacer'},

    {type = 'header', text = '单刷技能 设置', size=18,align = 'center'},
    {type = 'checkspin', text = '启用 恢复(仅用于T)', key = 'Key_Renew', spin = 50, size=14,check = true},
    {type = 'checkspin', text = '治疗术', key = 'Key_Heal', spin = 80, size=14,check = true},
    {type = 'checkspin', text = '快速治疗', key = 'Key_FlashHeal', size=14,spin = 60, max=100,size=14,check = true},
    {type = 'checkspin', text = '真言术：静', key = 'Key_Serenity', size=14,spin = 50, max=100,size=14,check = true},
    {type = 'ruler'},{type = 'spacer'},

}
--yuanali
local exeOnLoad = function()
    print('|cffF0EBE0 神牧 |r|cffff0000 >>五人本<<|r|cffFACC2E 战斗策略已载入|r')
    print('|cffF0EBE0 神牧 |r|cffff0000 >>五人本<<|r|cffFACC2E 战斗策略已载入|r')
    print('|cffF0EBE0 神牧 |r|cffff0000 >>五人本<<|r|cffFACC2E 战斗策略已载入|r')
    print('|cffF0EBE0 神牧 |r|cffff0000 >>五人本<<|r|cffFACC2E 战斗策略已载入|r')
    print('|cffF0EBE0 神牧 |r|cffff0000 >>五人本<<|r|cffFACC2E 战斗策略已载入|r')
    print('|cffff0000 设置项: |r右键主开关可找到|r')
  end

local purfy ={   
    --注意 指定buff层数远离人群这种。 可以写出来 利用区域检测 暗影束缚
    --指定buff层数 去指定地点写不出来 
    --远离人群多少码驱散 如：area(10).friendly == 0  意思就是10码内没人
    --{'纯净术','debuff(debuff名称).any & distance < 40 & area(10).friendly == 0','friendly'},
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
    {'纯净术','debuff(腐败之水).any & distance < 40','friendly'},
        --地渊孢林

    {'纯净术','debuff(化学灼烧).any & distance < 30','friendly'},
    {'纯净术','debuff(浸油之刃).any & distance < 30','friendly'},
    {'纯净术','debuff(野火).any & distance < 30','friendly'},
    {'纯净术','debuff(熔化的黄金).any & distance < 30','friendly'},
    {'纯净术','debuff(挥之不去的恶心感).any & distance < 30','friendly'},
    {'纯净术','debuff(瘟疫步).any & distance < 30','friendly'},
    {'纯净术','debuff(冰霜冲击).any & distance < 30','friendly'},
    {'纯净术','debuff(脑部冻结).any & distance < 30','friendly'},
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
    {'驱散魔法','buff(镀金之爪).any & distance < 30','enemies'},
    --暴富矿区
    {'驱散魔法','buff(脑部冻结).any & distance < 30','enemies'},
    {'驱散魔法','buff(腐蚀性化合物).any & distance < 30','enemies'},
    {'驱散魔法','buff(转化：粘液).any & distance < 30','enemies'},
    {'驱散魔法','buff(灵魂防御).any & distance < 30','enemies'},
    
}

--羽毛加速
local boostSpeed ={
    {'天堂之羽','UI(key_AF) & talent(2,3) & player.moving & !buff(天堂之羽)','player.ground'},
    {'天堂之羽','distance < 40 & UI(key_AF) & talent(2,3) & lowest.health < 70 & lowest.area(10).enemies > 0 & lowest.moving & !buff(天堂之羽)','lowest.ground'},
    {'天堂之羽','distance < 40 & tank.exists & tank.alive & UI(key_AF) & talent(2,3) & tank.health < 70 & tank.area(10).enemies > 0 & tank.moving & !buff(天堂之羽)','tank.ground'},
}

--真言术：耐
local BuffCheck ={    
    {'真言术：韧','distance < 40 & !buff(真言术：韧)','friendly'},
}

--利用圣言术：罚 来打断指定读条技能
local interrupt={
    {'!圣言术：罚','casting(震耳咆哮).percent < 10','enemies'},
}

--治疗石
local HealStone ={
    {'!#5512','UI(Key_UseHS_check) & spell(绝望祷言).cooldown > 0 & player.health < UI(Key_UseHS_spin) & item(5512).usable & item(5512).count>0'},
}

--各种药水
local Posion ={
    --使用优先级：绝望祷言 糖 治疗药水 活力药水
    {'#152494', 'UI(Key_UseHP_check) & {spell(绝望祷言).cooldown > 0 || !UI(Key_DP)} & player.health < UI(Key_UseHP_spin) & item(152494).usable & item(152494).count > 0','player'},
    {'#163082','UI(Key_UseMHP_check) & {spell(绝望祷言).cooldown > 0 || !UI(Key_DP)} & player.health < UI(Key_UseMHP_spin) & item(163082).usable & item(163082).count >0 & item(152494).cooldown > 0','player'},
    {'#152495','UI(Key_UseMP_check) & player.mana < UI(Key_UseMP_spin) & item(152495).usable & item(152495).count > 0','player'},
}

--吃食物
local eatFood = {
    --山羊肉干 163052
    --雪莓奶油茶 159878
    --炸黄油曲奇 163107 
    --提拉加德尖奶酪 159874 这个回复量是十五万，其余是十万
    {'#163052','!buff(进食饮水) & !buff(进食) & health < 80 & item(163052).count > 0','player'},
    {'#159878','!buff(进食饮水) & !buff(进食) & health < 80 & item(159878).count > 0','player'},
    {'#163107','!buff(进食饮水) & !buff(进食) & health < 80 & item(163107).count > 0','player'},
    {'#159874','!buff(进食饮水) & !buff(进食) & health < 80 & item(159874).count > 0','player'},
}

--喝水 
local drinkWater = {
    --跃岩矿泉水 159867    
    --159868 散养羊奶
    {'#159868','!buff(喝水) & !buff(进食饮水) & mana < 80 & item(159868).count > 0'},    
    {'#159867','!buff(喝水) & !buff(进食饮水) & mana < 80 & item(159867).count > 0'},
    {'#113509','!buff(进食饮水) & !buff(喝水) &  & !buff(进食) & mana < 80 & item(113509).count > 0'},
}

--吃喝
local eatAnddrink={
    {eatFood,'UI(key_Food_check) & !moving & health<UI(key_Food_spin)'},
    {drinkWater,'UI(key_Drink_check) !moving & mana<UI(key_Drink_spin)'},    
    {'/stand','mana > 90 & {buff(喝水) || buff(进食) || buff(进食饮水)}'},
   
}

--战斗中 战斗策略
local inCombat={
    {'!/stopcasting','debuff(践踏).duration.any < gcd & debuff(践踏).any','player'},  -- 应对大秘境词缀 震荡
    {'!/stopcasting','casting(震耳咆哮) & interruptAt(10)','enemies'},--应对自由镇 震耳咆哮打断施法
    {boostSpeed},    
    {BuffCheck,'UI(key_IC_PF)'},        
    {HealStone},
    {Posion},
    {dispel,'player.mana > 30 & lowest.health > 30'},
    {purfy,'player.mana > 40 & lowest.health > 40'},
    {'!渐隐术','target(player)','enemies'},    
    {'!神圣化身',' area(40,50).heal >= 2 || {tank.exists & tank.alive & tank.health < 30 & tank.distance < 40}','player'}, 
    {'!绝望祷言','UI(Key_DP_check) & health < UI(Key_DP_spin)','player'},
    {'!守护之魂','distance < 40 & health < UI(Key_GP_spin) & UI(Key_GP_check)','player'},
    {'!守护之魂','tank.exists & distance < 40 & health < UI(Key_GT_spin) & UI(Key_GT_check)','tank'},
    {'!守护之魂','distance < 40 & health < UI(Key_GO_spin) & UI(Key_GO_check)','lowest'},
    {'愈合祷言', 'tank.exists & UI(key_PM) & tank.health > 30 & tank.alive & !player.moving & lowest.health >55 & !buff(愈合祷言)', 'tank'}, 
    {'治疗祷言','UI(key_PH) & lowest.distance  <  40  &  player.spell(圣言术：灵).cooldown  >  0 & {player.spell(治疗之环).cooldown  >  0  &  talent(5,3)} &  lowest.area(UI(key_PH_Range),UI(key_PH_Count)).heal >= UI(key_PH_Count) & !player.moving','lowest'},  
    {'!圣言术：灵','UI(key_Sanctify) & distance < 40 & lowest.area(10,UI(key_Sanctify_Health)).heal  >=  UI(key_Sanctify_Count)','lowest.ground'},
    {'!联结治疗','friendly.health < 80 & spell(圣言术：静).cooldown> 0 & friendly.distance < 40 & friendly.area(20,80).heal > 0 & spell(圣言术：灵).cooldown>0 & !player.moving & talent(5,2)','friendly'},
    {'快速治疗','spell(圣言术：静).cooldown > 0 & lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},   
    {'快速治疗','{player.moving || player.buff(圣光涌动).duration<=3 || lowest.health < 40} & spell(圣言术：静).cooldown > 0 & player.buff(圣光涌动) & lowest.distance < 40 & lowest.health < 85','lowest'},  
    {'圣言术：静','lowest.distance < 40 & lowest.health < 65','lowest'},
    {'圣言术：静','tank.exists & .alive & distance < 40 & health < 70','tank'},   
    {'治疗术','lowest.health > 70 & distance < 40 & lowest.health < 90 & !player.moving','lowest'},
    {'恢复','tank.exists & !buff(恢复) & distance < 40 & health < 90','tank'},
    {'恢复','!buff(恢复) & distance < 40 & health < 80 & player.moving','lowest'},    
}

local outCombat = {
    {'#159867','!buff(喝水) & !buff(进食饮水) & mana < 80 & item(跃岩矿泉水).count > 0'},
    {inCombat,'!player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎) & !{buff(喝水) || buff(进食) || buff(进食饮水)}'},
    {eatAnddrink,'health > 50','player'},
}

local blacklist = {
    debuff = {name = "Misery"},
}

local Spell_wow801_Priest_Holy={

}

NeP.CR:Add(257, {
    name = '|cffFACC2E [老日]|r 神牧 - |cffFACC2E五人本|r',
    ic = {{inCombat,'group.type == 2 & !player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    ooc = outCombat,
    gui = GUI,
    gui_st = {title='老日的牧师助手-神牧', width='512', height='800', color='FACC2E'},
    ids = Spell_wow801_Priest_Holy,
    load = exeOnLoad,    
    blacklist = blacklist
  
  })