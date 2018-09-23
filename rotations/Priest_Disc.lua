local _, RYT = ...
local NeP = NeP

--开关：见怪就干
--开关：防摔死

-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！
-- 好好搞搞戒律牧 好玩啊！！

local GUI = {
    {type = "texture",
    --texture = "Interface\\AddOns\\Nerdpack-RYTPriest\\media\\holy5.blp",
    width = 512, 
    height = 400, 
    offset = 90, 
    y = 42, 
    center = true},
}

local exeOnLoad = function()
    print('|cffFACC2E 戒律牧单人战斗策略已载入|r')
    print('|cffff0000 设置项: |r右键主开关可找到|r')    
  end

local shadowFriend={
    --当我的天赋是暗影魔的时候，怪物数量>5 或者 怪物是精英 或者我血量低于70% 或者蓝量低于30%
    {'暗影魔','talent(3,2)','target'},
    --当我的天赋是摧心魔的时候，怪物数量>2 或者 怪物是精英 或者我血量低于70% 或者蓝量低于30%
    {'摧心魔','!talent(3,2)','target'},
}

local healMe ={
    --当我没有救赎buff的时候上个盾
    {'真言术：盾','health < 80 & !buff(救赎)','lowest'},
    {'暗影愈合','health < 65 & !moving','lowest'},
    {'苦修','health < 50','lowest'},
}

local buffCheck ={
    {'真言术：韧','!buff(真言术：韧)','lowest'},
}

--加速
local boostSpeed =
{
    --羽毛
    {'天堂之羽','talent(2,3) & moving & !buff(天堂之羽)','lowest.ground'},
}

local saveMe={
    --10码内怪物数量超过8且血量低于30 群恐/闪光力场
    {'痛苦压制','health <= 30','lowest'},
    --{'微光屏障','health <=30 & spell(痛苦压制).cooldown > 0 & talent(7,2)','lowest'},
    {'心灵尖啸','area(10).enemies.count >= 8 & health<=30','lowest'},
    {'闪光力场','area(10).enemies.count >= 8 & health<=30 & spell(心灵尖啸).cooldown >0','lowest'},
}
local purfy ={   
    --注意 指定buff层数远离人群这种。 可以写出来 利用区域检测 暗影束缚
    --指定buff层数 去指定地点写不出来 
    --远离人群多少码驱散 如：area(10).lowest == 0  意思就是10码内没人
    --{'纯净术','debuff(debuff名称).any & distance < 40 & area(10).lowest == 0','lowest'},
    {'纯净术','debuff(烈焰震击).any & distance < 40','lowest'},
    {'纯净术','debuff(冰霜新星).any & distance < 40','lowest'},
    {'纯净术','debuff(毒蛇诱惑).any & distance < 40','lowest'},
    {'纯净术','debuff(瘟疫).any & distance < 40','lowest'},
    {'纯净术','debuff(感染之伤).any & distance < 40','lowest'},
    {'纯净术','debuff(火把攻击).any & distance < 40','lowest'},
    {'纯净术','debuff(衰弱怒吼).any & distance < 40','lowest'},
    {'纯净术','debuff(火力压制).any & distance < 40','lowest'},
    {'纯净术','debuff(点火器).any & distance < 40','lowest'},
    {'纯净术','debuff(正义烈焰).any & distance < 40','lowest'},
    {'纯净术','debuff(冰霜震击).any & distance < 40','lowest'},
    {'纯净术','debuff(腐败之血).any & distance < 40','lowest'},
    {'!纯净术','debuff(诱惑).any & distance < 40','lowest'},
    {'!纯净术','debuff(恶疾排放).any & distance < 40','lowest'},
        --地渊孢林

    {'纯净术','debuff(化学灼烧).any & distance < 30','lowest'},
    {'纯净术','debuff(浸油之刃).any & distance < 30','lowest'},
    {'纯净术','debuff(野火).any & distance < 30','lowest'},
    {'纯净术','debuff(熔化的黄金).any & distance < 30','lowest'},
    {'纯净术','debuff(挥之不去的恶心感).any & distance < 30','lowest'},
    {'纯净术','debuff(瘟疫步).any & distance < 30','lowest'},
    {'纯净术','debuff(冰霜冲击).any & distance < 30','lowest'},
    {'纯净术','debuff(脑部冻结).any & distance < 30','lowest'},
    {'!纯净术','debuff(腐败之水).any & distance < 30','friendly'},
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

local inCombat ={
    {dispel,'player.mana > 30 & lowest.health > 30'},
    {purfy,'player.mana > 40 & lowest.health > 40'},
    {boostSpeed},
    {saveMe},
    {healMe},
    {'!真言术：盾','tank.alive & !buff(救赎) & distance < 40 & group.type ~= 1','tank'},
    {'!真言术：盾','health < 80 & !buff(救赎) & distance < 40','lowest'}, 
    {'真言术：慰','infront & talent(3,3) & infront & combat','enemies'},    
    {'暗言术：痛','!talent(6,1) & !debuff(暗言术：痛) & combat','enemies'},   
    {'净化邪恶','talent(6,1) & !debuff(净化邪恶) & combat','enemies'},
    {'!教派分歧','!debuff(教派分歧) & infront & talent(1,3) & combat & !player.moving','enemies'},
    {'惩击','infront & {{talent(1,3) & debuff(教派分歧)} || !talent(1,3)} & !player.moving & spell(苦修).cooldown > 0','target'},
    {'惩击','infront & !player.moving & spell(苦修).cooldown > 0','target'},
    {'苦修','infront & lowest.health > 50 & {{talent(1,3) & debuff(教派分歧)} || !talent(1,3) || spell(教派分歧).cooldown > 0} & combat','enemies'},
    {'苦修','infront & lowest.health > 50','target'},
    {'!苦修','infront & health < 50 ','lowest'},
    {'!真言术：耀','lowest.area(30,60) >= 3 || !player.moving & count(救赎).buffs < 3'，'lowest'},
    
  
    {shadowFriend},
    --渐隐术未做
    
   

}

local outCombat ={
{boostSpeed},
{buffCheck},
--血量不满，毒奶几口完事儿
{'暗影愈合','health < 90 & mana > 5 & !player.moving','lowest'},

}

local blacklist = {
    debuff = {name = "Misery"},
}

local Spell_wow801_Priest_Disc=
{

}

NeP.CR:Add(256, {
    name = '|cffFACC2E [老日]|r 老年人助手 - |cffFACC2E戒律牧单人模式|r',
    ic = inCombat,
    ooc =outCombat,
    gui = GUI,
    gui_st = {title='老日的牧师助手-戒律牧单人模式', width='512', height='256', color='FACC2E'},
    ids = Spell_wow801_Priest_Disc,
    load = exeOnLoad,    
    blacklist = blacklist
  
  })