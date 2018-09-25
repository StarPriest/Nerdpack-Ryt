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
  end

local purify ={   
    {'纯净术','debuff(烈焰震击).any & distance < 40','player'},
    {'纯净术','debuff(冰霜新星).any & distance < 40','player'},
    {'纯净术','debuff(毒蛇诱惑).any & distance < 40','player'},
    {'纯净术','debuff(瘟疫).any & distance < 40','player'},
    {'纯净术','debuff(感染之伤).any & distance < 40','player'},
    {'纯净术','debuff(火把攻击).any & distance < 40','player'},
    {'纯净术','debuff(衰弱怒吼).any & distance < 40','player'},
    {'纯净术','debuff(火力压制).any & distance < 40','player'},
    {'纯净术','debuff(点火器).any & distance < 40','player'},
    {'纯净术','debuff(正义烈焰).any & distance < 40','player'},
    {'纯净术','debuff(冰霜震击).any & distance < 40','player'},
    {'纯净术','debuff(腐败之血).any & distance < 40','player'},
    {'!纯净术','debuff(诱惑).any & distance < 40','player'},
    {'!纯净术','debuff(恶疾排放).any & distance < 40','player'},
        --地渊孢林

    {'纯净术','debuff(化学灼烧).any & distance < 30','player'},
    {'纯净术','debuff(浸油之刃).any & distance < 30','player'},
    {'纯净术','debuff(野火).any & distance < 30','player'},
    {'纯净术','debuff(熔化的黄金).any & distance < 30','player'},
    {'纯净术','debuff(挥之不去的恶心感).any & distance < 30','player'},
    {'纯净术','debuff(瘟疫步).any & distance < 30','player'},
    {'纯净术','debuff(冰霜冲击).any & distance < 30','player'},
    {'纯净术','debuff(脑部冻结).any & distance < 30','player'},
    {'!纯净术','debuff(腐败之水).any & distance < 30','friendly'},
    {'!纯净术','debuff(冰冻术).any & distance < 30','friendly'},
    {'!纯净术','debuff(冰霜新星).any & distance < 30','friendly'},
}
local dispel ={    
    {'驱散魔法','buff(水之护盾).any & distance < 30','target'},
    {'驱散魔法','buff(力量药水).any & distance < 30','target'},
    {'驱散魔法','buff(敏捷药剂).any & distance < 30','target'},
    {'驱散魔法','buff(健康补益).any & distance < 30','target'},
    {'驱散魔法','buff(积攒电荷).any & distance < 30','target'},
    {'驱散魔法','buff(黑影步).any & distance < 30','target'},
    {'驱散魔法','buff(流水护甲).any & distance < 30','target'},
    {'驱散魔法','buff(大地之盾).any & distance < 30','target'},
    --地渊孢林
    {'驱散魔法','buff(戈霍恩之赐).any & distance < 30','target'},
    {'驱散魔法','buff(白骨之盾).any & distance < 30','target'},
    {'驱散魔法','buff(衰弱意志).any & distance < 30','target'},
    --塞塔里斯神庙
    {'驱散魔法','buff(胚胎精华).any & distance < 30','target'},
    {'驱散魔法','buff(带电鳞片).any & distance < 30','target'},
    {'驱散魔法','buff(积攒电荷).any & distance < 30','target'},
    --托尔达戈
    {'驱散魔法','buff(镀金之爪).any & distance < 30','target'},
    --暴富矿区
    {'驱散魔法','buff(脑部冻结).any & distance < 30','target'},
    {'驱散魔法','buff(腐蚀性化合物).any & distance < 30','target'},
    {'驱散魔法','buff(转化：粘液).any & distance < 30','target'},
    {'驱散魔法','buff(灵魂防御).any & distance < 30','target'},
    
}

--羽毛或者加速盾
local BoostSpeed = {
    --当我多少码内有几个敌人我的血量是多少的时候给自己加速技能
    {'!天堂之羽','UI(key_BS) & spell(天堂之羽).usable & talent(1,3) & player.moving & player.area(10).enemies > UI() & ','player.ground'}
}














local inCombat={
    
}