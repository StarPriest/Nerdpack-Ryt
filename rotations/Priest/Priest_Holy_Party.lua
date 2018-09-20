local _, yobleed = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    --texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\holy5.blp",
    width = 512, 
    height = 240, 
    offset = 90, 
    y = 42, 
    center = true},


    {type = 'header', text = '增益管理 设置', size=18,align = 'center'},
    {type = 'checkbox', text = '天堂之羽', key = 'key_AF', width = 55, size=14,default = true},
    {type = 'checkbox', text = '非战斗状态-真言术：韧', key = 'key_OOC_PF', width = 55, size=14,default = true},
    {type = 'checkbox', text = '战斗状态-真言术：韧', key = 'key_IC_PF', width = 55, size=14,default = true},
    {type = 'ruler'},{type = 'spacer'},
    
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

local exeOnLoad = function()
    print('|cffFACC2E 神牧战斗策略已载入|r')
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

--加速
local boostSpeed =
{
    --羽毛
    {'天堂之羽','UI(key_AF) & talent(2,3) & player.moving & !buff(天堂之羽)','player.ground'},
}

--真言术：耐
local BuffCheck ={    
    {'真言术：韧','distance < 40 & !buff(真言术：韧)','friendly'},
}

local interrupt={
    {'圣言术：罚','casting(震耳咆哮).percent < 10','enemies'},
}

local HealStone =
{
    --当绝望祷言CD且我血量低于20%时使用
    {'/use 治疗石','UI(Key_UseHS_check) & spell(绝望祷言).cooldown > 0 & player.health < UI(Key_UseHS_spin) & item(5512).usable & item(5512).count>0'},
}


--药水
local Posion =
{
    --使用优先级：绝望祷言 糖 治疗药水 活力药水
    {'/use 海滨治疗药水', 'UI(Key_UseHP_check) & {spell(绝望祷言).cooldown > 0 || !UI(Key_DP)} & player.health < UI(Key_UseHP_spin) & item(152494).usable & item(152494).count > 0'},
    {'/use 海滨活力药水','UI(Key_UseMHP_check) & {spell(绝望祷言).cooldown > 0 || !UI(Key_DP)} & player.health < UI(Key_UseMHP_spin) & item(163082).usable & item(163082).count >0 & item(152494).cooldown > 0'},
    {'/use 海滨法力药水','UI(Key_UseMP_check) & player.mana < UI(Key_UseMP_spin) & item(152495).usable & item(152495).count > 0'},
}

local testStopCasting={
    {'!/stopcasting','buff(圣光回响).duration.any <= gcd & buff(圣光回响).any','player'},  
    {'治疗术','health>90','player'},
    
}

--震耳咆哮
local inCombat={
    {'!/stopcasting','debuff(践踏).duration.any <= gcd & debuff(践踏).any','player'},  
    {boostSpeed},    
    {BuffCheck,'UI(key_IC_PF)'},        
    {HealStone},
    {Posion},
    {purfy},
    {dispel}, 

    {'!渐隐术','target(player)','enemies'},    
    {'神圣化身',' area(40,50).heal >= 2 || {tank.health < 30 & tank.distance < 40}','player'}, 
    --当自己血量低于35% 绝望祷言
    {'!绝望祷言','UI(Key_DP_check) & health < UI(Key_DP_spin)','player'},
    --当自己血量低于15% 翅膀
    {'!守护之魂','distance < 40 & health < UI(Key_GP_spin) & UI(Key_GP_check)','player'},
    --当T血量低于10% 翅膀
    {'!守护之魂','distance < 40 & health < UI(Key_GT_spin) & UI(Key_GT_check)','tank'},
    --当dps血量低于15% 翅膀
    {'!守护之魂','distance < 40 & health < UI(Key_GO_spin) & UI(Key_GO_check)','lowest'},
    --愈合祷言 前提是没人血危
    {'愈合祷言', 'tank.health > 30 & tank.alive & !player.moving & lowest.health >55 & !buff(愈合祷言)', {'tank','player','lowest'}},
    -- 治疗祷言 前提是没人血危
    --{'治疗祷言','tank.health > 30 & tank.alive & lowest.health >35 & lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & lowest.area(40,80).heal > 3 & !player.moving','lowest'},
    --治疗祷言 目标40码内最近的四个人。
    {'治疗祷言','UI(key_PH) & lowest.distance  <  40  &  player.spell(圣言术：灵).cooldown  >  0 & {player.spell(治疗之环).cooldown  >  0  &  talent(5,3)} &  lowest.area(UI(key_PH_Range),UI(key_PH_Count)).heal >= UI(key_PH_Count) & !player.moving','lowest'},  
    -- 圣言术：灵
    --{'光晕','player.area(30,85)>10 & talent(6,3)'},
    --{'!圣言术：灵','lowest.distance<40 & lowest.area(10,80).heal >= 3','lowest.ground'},
    {'!圣言术：灵','UI(key_Sanctify) & distance < 40 & area(10,UI(key_Sanctify_Health)).heal >= UI(key_Sanctify_Count)','lowest.ground'},
    -- 联结治疗（天赋5,2）
    {'!联结治疗','friendly.health < 80 & spell(圣言术：静).cooldown> 0 & friendly.distance < 40 & friendly.area(20,80).heal > 0 & spell(圣言术：灵).cooldown>0 & !player.moving & talent(5,2)','friendly'},
      -- 快速治疗 无论有无瞬发buff
    {'快速治疗','tank.health>30 & tank.alive & spell(圣言术：静).cooldown>0 & lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},    
    -- 快速治疗 无论有无瞬发buff
    {'快速治疗','tank.alive & lowest.health > 30 & spell(圣言术：静).cooldown > 0 & distance < 40 & health < 75 & !player.moving','tank'},       

    -- 快速治疗2 有瞬发buff 
    {'!快速治疗','{player.moving || player.buff(圣光涌动).duration<=3 || lowest.health < 40} & spell(圣言术：静).cooldown>0 & player.buff(圣光涌动) & lowest.distance < 40 & lowest.health < 85','lowest'},  
    -- 圣言术：静
    {'!圣言术：静','lowest.distance < 40 & lowest.health < 65','lowest'},
    {'!圣言术：静','tank.alive & distance < 40 & health < 70','tank'},   
    --治疗术
    {'治疗术','lowest.health > 50 & distance < 40 & health < 90 & !player.moving','lowest'},
    --恢复
    {'恢复','!buff(恢复) & distance < 40 & health < 90','tank'},
    
}

--吃食物
local eatFood = {
    --山羊肉干 163052
    --雪莓奶油茶 159878
    --炸黄油曲奇 163107 
    --提拉加德尖奶酪 159874 这个回复量是十五万，其余是十万
    {'/use 山羊肉干','!buff(进食饮水) & !buff(进食) & health < 80 & item(163052).count > 0'},
    {'/use 雪莓奶油茶','!buff(进食饮水) & !buff(进食) & health < 80 & item(159878).count > 0'},
    {'/use 炸黄油曲奇','!buff(进食饮水) & !buff(进食) & health < 80 & item(163107).count > 0'},
    {'/use 提拉加德尖奶酪','!buff(进食饮水) & !buff(进食) & health < 80 & item(159874).count > 0'},
}

--喝水 恐惧之面
local drinkWater = {
    --跃岩矿泉水 159867
    --159868 散养羊奶
    {'/use 散养羊奶','!buff(喝水) & !buff(进食饮水) & mana < 80 & item(159868).count > 0'},    
    {'/use 跃岩矿泉水','!buff(喝水) & !buff(进食饮水) & mana < 80 & item(跃岩矿泉水).count > 0'},
    {'/use 魔法汉堡','!buff(进食饮水) & !buff(喝水) &mana < 80 & item(魔法汉堡).count > 0'},
}

--吃喝
local eatAnddrink={
    {eatFood,'UI(key_Food_check) & !buff(进食) & !moving & health<UI(key_Food_spin)'},
    {drinkWater,'UI(key_Drink_check) & !buff(喝水) & !moving & mana<UI(key_Drink_spin)'},
    --{eatCooking,'UI(key_Cooking)'},
    {'/stand','mana > 80 & {buff(喝水) || buff(进食) || buff(进食饮水)}'},
   
}

--非战斗状态策略
local outCombat={
    {'!/stopcasting','debuff(践踏).duration.any <= gcd & debuff(践踏).any','player'},    
    {BuffCheck,'UI(key_OOC_PF)'},
    --{eatAnddrink},
    {boostSpeed},    
    -- 治疗祷言
    {'治疗祷言','lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & lowest.area(40,85).heal > 2 & !player.moving'},
    -- 圣言术：灵
    {'圣言术：灵','lowest.distance < 40 & lowest.area(10,85).heal > 2','lowest.ground'},
    -- 联结治疗（天赋5,2）
    {'联结治疗','lowest.distance < 40 & lowest.area(20,80).heal > 0 & spell(圣言术：灵).cooldown> 0 & !player.moving & talent(5,2)','lowest'},
    -- 快速治疗
    {'快速治疗','lowest.distance < 40 & lowest.health < 75 & !player.moving','lowest'},       
    -- 圣言术：静
    {'圣言术：静','lowest.distance < 40 & lowest.health<70','lowest'},

    {'恢复','!buff(恢复) & distance < 40 & health < 90','lowest'},
}

local blacklist = {
    debuff = {name = "Misery"},
}

local Spell_wow801_Priest_Holy={

}

NeP.CR:Add(257, {
    name = '|cffFACC2E [老日]|r 神牧 - |cffFACC2E五人本|r',
    ic = {{inCombat,'group.type == 2 & !player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    ooc = {{outCombat,'!player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    gui = GUI,
    gui_st = {title='老日的牧师助手-神牧', width='512', height='800', color='FACC2E'},
    ids = Spell_wow801_Priest_Holy,
    load = exeOnLoad,    
    blacklist = blacklist
  
  })