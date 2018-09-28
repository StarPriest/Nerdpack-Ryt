local _, RYT = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    --texture = "Interface\\AddOns\\Nerdpack-RYTPriest\\media\\holy5.blp",
    width = 512, 
    height = 400, 
    offset = 90, 
    y = 42, 
    center = true},

    --设置项
    {type = 'header', text = '通用 设置', size=18,align = 'center'},
    {type = 'spinner', text = '进攻血量阈值', key = 'key_AttackHealth', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'header', text = '加速盾/羽毛 设置', size=18,align = 'center'},
    {type = 'checkbox', text = '启用 加速技能', key = 'key_BS', width = 55, size=14,default = true},
    {type = 'spinner', text = '我的血量为多少时使用', key = 'key_BS_PlayerHp', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '或者 附近多少码内有敌人时使用', key = 'key_BS_Radius', size=14,width = 55, max = 40, step = 1, default = 3},
    {type = 'spinner', text = '并且 附近多少码内敌人数量', key = 'key_BS_EnemiesNum', size=14,width = 55, max = 40, step = 1, default = 3},
    {type = 'spacer'},
}

local exeOnLoad = function()
    print('|cffFACC2E 戒律牧单人战斗策略已载入|r')
    print('|cffff0000 设置项: |r右键主开关可找到|r')    

     NeP.Interface:AddToggle({
      key = 'dispel',
      name = '进攻驱散',
      text = '开关进攻驱散，仅支持驱散列表内现有的法术',
      icon = 'Interface\\ICONS\\spell_holy_nullifydisease', --toggle(disp)
    })

    NeP.Interface:AddToggle({
    key = 'prufy',
    name = '友方驱散',
    text = '开关友方驱散，仅支持驱散列表内现有的法术',
    icon = 'Interface\\ICONS\\spell_holy_dispelmagic', --toggle(disp)
    })   
  end

local purify ={   
    {'纯净术','debuff(烈焰震击).any & distance < 40','friendly'},
    {'纯净术','debuff(冰霜新星).any & distance < 40','friendly'},
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
    {'!纯净术','debuff(诱惑).any & distance < 40','friendly'},
    {'!纯净术','debuff(恶疾排放).any & distance < 40','friendly'},
        --地渊孢林

    {'纯净术','debuff(化学灼烧).any & distance < 30','friendly'},
    {'纯净术','debuff(浸油之刃).any & distance < 30','friendly'},
    {'纯净术','debuff(野火).any & distance < 30','friendly'},
    {'纯净术','debuff(熔化的黄金).any & distance < 30','friendly'},
    {'纯净术','debuff(挥之不去的恶心感).any & distance < 30','friendly'},
    {'纯净术','debuff(瘟疫步).any & distance < 30','friendly'},
    {'纯净术','debuff(冰霜冲击).any & distance < 30','friendly'},
    {'纯净术','debuff(脑部冻结).any & distance < 30','friendly'},
    {'纯净术','debuff(火力压制).any & distance < 30','friendly'},
    {'!纯净术','debuff(腐败之水).any & distance < 30','friendly'},
       --PVP
    {'!纯净术','debuff(冰冻术).any','player'},
    {'!纯净术','debuff(冰霜新星).any','player'}, 
    {'纯净术','debuff(冰冻).any','player'},
    {'纯净术','debuff(冰霜尖刺).any','player'},
    {'纯净术','debuff(点燃).any','player'},
    {'纯净术','debuff(血之疫病).any','player'},
    {'纯净术','debuff(恶性瘟疫).any','player'},
    {'纯净术','debuff(游荡疫病).any ','player'},
    {'纯净术','debuff(暗言术：痛).any','player'},

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
    --PVP
    {'驱散魔法','buff(真言术：韧).any & distance < 30','target'},
    {'驱散魔法','buff(天堂之羽).any & distance < 30','target'},
    {'驱散魔法','buff(保护之手).any & distance < 30 ','target'},
    {'驱散魔法','buff(智慧祝福).any & distance < 30','target'},
    {'驱散魔法','buff(奥术智慧).any & distance < 30 & ','target'},   
    {'驱散魔法','buff(回春术).any & distance < 30 & ','target'},   
    {'驱散魔法','buff(生命绽放).any & distance < 30 & ','target'},   
    {'驱散魔法','buff(愈合).any & distance < 30 & ','target'},   
    {'驱散魔法','buff(狂热).any & distance < 30 & ','target'},   
    {'驱散魔法','buff(无私治愈).any & distance < 30 & ','target'},   
    
}



--羽毛或者加速盾
local boostSpeed ={
    {'天堂之羽','talent(2,3) & player.moving & !buff(天堂之羽)','player.ground'},
    {'天堂之羽','distance < 40 & talent(2,3) & lowest.health < 70 & lowest.area(10).enemies > 0 & lowest.area(10).friednly < 1 & lowest.moving & !buff(天堂之羽)','lowest.ground'},
    {'天堂之羽','distance < 40 &  tank.exists & tank.alive & UI(key_AF) & talent(2,3) & tank.health < 70 & tank.area(10).friednly < 1 & tank.area(10).enemies > 0 & tank.moving & !buff(天堂之羽)','tank.ground'},
}


local shadowFiendParty ={
    {'摧心魔','talent(3,2) & player.area(40,75) >= 3 & count.friendly.buffs(救赎) >=3 & distance < 40 & ttd > 9 & {debuff(教派分歧) || spell.cooldown(教派分歧) > 0}','enemies'},
    {'暗影魔','!talent(3,2) & player.area(40,75) >= 3 & count.friendly.buffs(救赎) >=3 & distance < 40 & ttd > 9 & {debuff(教派分歧) || spell.cooldown(教派分歧) > 0}','enemies'},

    --PVP 删除
    --{'!摧心魔','talent(3,2) & health < 5 & distance < 40 & combat & infront & {debuff(教派分歧) || spell.cooldown(教派分歧) > 0}','lowestenemy'},
    --{'!暗影魔','!talent(3,2) & health < 5 & distance < 40 & combat & infront & {debuff(教派分歧) || spell.cooldown(教派分歧) > 0}','lowestenemy'},
   
}
--快捷键设定
-- 指定快捷键拉T帮助他风筝
-- 指定快捷键拉掉落的人
-- 指定快捷键一键铺常规盾
-- 指定快捷键一键全神贯注盾
-- 指定快捷键单刷目标/焦点（用开关？）



-- 开关设定
-- 自动补控


--大秘境受影响词缀：
-- 1. 震荡 自动打断，已完善 查看自己的debuff 践踏 ，多少码内有践踏debuff的玩家数量 > x ，给群体减伤：障/全神贯注盾
-- 2. 死疽 层数20 就0治疗了，如何取舍 任意友方单位查看debuff 死疽 以及层数 超过 x 层，无脑盾
-- 3. 火山 该单位与玩家的距离 < 1 任意单位1码内火山的数量 ==1 盾 >1 痛苦压制 >2且我附近1码无火山 拉人
--队伍模式以治疗为主，所以可以无脑盾
--当T的预判受到伤害低于盾伤害，无脑给盾
--[[
    队伍治疗逻辑
    脱战状态：当Tank 40码内有敌人时，给tank盾与预吸收 ，坦克开怪，进入战斗
    战斗状态：
    当所有玩家血量高于50%时，T的预判受到伤害低于普通盾伤害时，无脑盾穿插dps技能
    当所有玩家血量高于50%时，T的预判受到伤害高于普通盾伤害时，全神贯注盾穿插dps技能
    若五秒内T的预判受到伤害高于T当前血量，痛苦压制/全神贯注无脑盾
    若T的血量低于xxx且T在风筝的时候，给T加速羽毛
    记录队伍内所有玩家的CD技能，如打断，如救急
    记录变态debuff / buff 并作出相应提示以及应对
]]
local healparty = {
    {'苦修','distance < 40 & exist & tank.alive & tank.health < UI(key_AttackHealth)','tank'},
    {'苦修','distance < 40 & player.alive & player.health < UI(key_AttackHealth)','player'},
    {'苦修','distance < 40 & lowest.alive & lowest.health < UI(key_AttackHealth)','lowest'},
    {'暗影愈合','distance < 40 & spell(苦修).cooldown > 0 & !player.moving & tank.exist & tank.alive & health < UI(key_AttackHealth)','tank'},
    {'暗影愈合','distance < 40 & spell(苦修).cooldown > 0 & !player.moving & player.healthalive & player.health < UI(key_AttackHealth)','player'},
    {'暗影愈合','distance < 40 & spell(苦修).cooldown > 0 & !player.moving & lowest.alive & lowest.health < UI(key_AttackHealth)','lowest'},
}

local jiushu = {
    --{'真言术：盾','distance < 40 & incdmg(5) < 10000 & !buff(真言术：盾) & !player.moving & exist & alive & health < 50','tank'},
    --做个开关，切换T的盾破盾 / 救赎盾
    {'真言术：盾','toggle(Cooldowns) & {!buff(真言术：盾) || !buff(救赎) || buff(救赎).duration < 3} & distance < 40 & tank.exist & tank.alive' ,'tank'},
    {'真言术：盾','!toggle(Cooldowns) & {!buff(救赎) || buff(救赎).duration < 3} & distance < 40 & tank.exist & tank.alive ','tank'},
    {'真言术：盾','{!buff(救赎) || buff(救赎).duration < 3} & health < 85','player'},
    {'真言术：盾','distance < 40 & !buff(救赎) & health < 85 & area(40,75).heal <= 2','friendly'},
    --{'真言术：耀','!player.moving & distance < 40 & area(30,85).heal >= 3 & count.friendly.buffs(救赎) < 3 ','lowest'},
    {'!真言术：耀','distance < 40 & area(30,85).heal >= 3 & count.friendly.buffs(救赎) < 3 ','lowest'},
}
--治疗石
local HealStone ={
    {'#5512','spell(绝望祷言).cooldown > 0 & player.health < 30 & item(5512).usable & item(5512).count > 0','player'},
}

--各种药水
local Posion ={
    --使用优先级：绝望祷言 糖 治疗药水 活力药水
    {'#152494','item(152494).cooldown == 0 & spell(绝望祷言).cooldown > 0 & player.health < 30 & item(152494).usable & item(152494).count > 0','player'},
    {'#163082','item(163082).cooldown == 0 & spell(绝望祷言).cooldown > 0 & player.health < 30 & item(163082).usable & item(163082).count >0 & item(152494).cooldown > 0','player'},
    {'#152495','player.mana < 30 & item(152495).usable & item(152495).cooldown == 0 & item(152495).count > 0','player'},
}

local AttackEnemies = {
    --死亡时间大于18秒且场内血量最高
    {'教派分歧','!player.moving & ttd > 18 & distance < 40 & infront','target'},
    {'教派分歧','!player.moving & ttd > 18 & distance < 40 & infront','enemies'},
    --此处净化邪恶，我嫌他释放频率太低转到不受友方血量控制的区域了
    {'!净化邪恶','distance < 40 & combat & !debuff(净化邪恶) ','target'},
    {'!净化邪恶','distance < 40 & combat & !debuff(净化邪恶) ','enemies'},
    --PVP 删除    
    --{'苦修','health < 5 & distance < 40 & combat & {debuff(教派分歧) || spell.cooldown(教派分歧) > 0}','lowestenemy'},
    {'苦修','distance < 40 & combat & {debuff(教派分歧) || spell.cooldown(教派分歧) > 0}','target'},
    {'惩击','!player.moving & distance < 40 & spell(苦修).cooldown > 0 & combat & infront','target'},
    {'惩击','!player.moving & distance < 40 & spell(苦修).cooldown > 0 & combat & infront','enemies'},
   
}
local inCombatPartyNormal = {
     {'痛苦压制','distance < 40 & health < 30','lowest'},
     {'真言术：障','area(10,50).heal >=3 & distance < 40','lowest.ground'},
     {'!绝望祷言','health <= 35','player'},
    {purify,'toggle(prufy)'},
    {dispel,'toggle(dispel)'},
    {HealStone},
    {Posion},
    {healparty},
    {shadowFiendParty},
    {jiushu},
    {AttackEnemies,'lowest.health >= UI(key_AttackHealth)'},   
    {boostSpeed},
    
}

local inCombatParty = {   
    {inCombatPartyNormal,'!player.buff(全神贯注)'},
    {'真言术：盾','player.buff(全神贯注) & !buff(真言术：盾)','friendly'},
}

local outCombatParty = {
    {AttackEnemies},
    {boostSpeed},
    {'真言术：韧','!buff(真言术：韧) || buff(真言术：韧).duration < 600 & !player.buff(喝水) & !player.buff(进食喝水)','friendly'},
    {'真言术：盾','!buff(真言术：盾) & tank.area(40).enemies > 0 & distance < 40 & tank.exist & tank.alive','tank'},
    {'真言术：耀','distance < 40 & !player.moving & area(40,85).heal >= 5','lowest'},
    {'苦修','distance < 40 & !player.moving & health < 85','lowest'},
    {'暗影愈合','distance < 40 & !player.moving & spell(苦修).cooldown > 0 & health < 85','lowest'},
   
}

local shadowFiendSolo = {
    --当遇到 2 个怪 或者 遇到血量大于多少的怪， 或者遇到玩家且玩家血量低于多少，或者我血量低于多少且场上累计怪物数量大于暗影魔dps*暗影哦存活时间的70%且我有救赎
    --摧心魔dps 2000-2500
}


local inCombatSoloNormal = {
    {'真言术：盾','!buff(救赎) & health <= 85','player'},
    {'暗影愈合','!player.moving & health <= 60','player'},
    {'痛苦压制','health <= 35','player'},

}

--设置个快捷键一键铺盾，设置第二个快捷键一键T强化盾
--单人模式以dps为主，血量保持在70以上即可。
local inCombatSolo = {
    {inCombatSoloNormal,'!player.buff(全神贯注)'},
    {'全神贯注','spell(痛苦压制).cooldown > 0 & health <= 35','player'},
    {'真言术：盾','buff(全神贯注).duration > 2','player'},
    

}

local inCombat = {
    --{inCombatSolo,'group.type == 1'},
    {inCombatParty,'group.type == 2'},
}
--锯齿鲨 锤头鲨
local outCombat={
    {outCombatParty,'group.type == 2'},
  
}

local blacklist= {
    {}
}
NeP.CR:Add(256, {
    name = '|cffFACC2E [老日]|r 神级 - |cffFACC2E戒律牧|r',
    ic = {{inCombat,'!player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    ooc = outCombat,
    gui = GUI,
    gui_st = {title='老日的牧师助手-戒律牧', width='512', height='800', color='FACC2E'},  
    load = exeOnLoad,    
    blacklist = blacklist
  
  })