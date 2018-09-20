local _, RYT = ...
local NeP = NeP

--开关：见怪就干
--开关：防摔死

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
    {'真言术：盾','!buff(救赎)','player'},
    {'暗影愈合','health < 65 & !moving','player'},
    {'苦修','health < 50','player'},
}

local buffCheck ={
    {'真言术：韧','!buff(真言术：韧)','player'},
}

--加速
local boostSpeed =
{
    --羽毛
    {'天堂之羽','talent(2,3) & moving & !buff(天堂之羽)','player.ground'},
}

local saveMe={
    --10码内怪物数量超过8且血量低于30 群恐/闪光力场
    {'痛苦压制','health <= 30','player'},
    {'微光屏障','health <=30 & spell(痛苦压制).cooldown > 0 & talent(7,2)','player'},
    {'心灵尖啸','area(10).enemies.count >= 8 & health<=30','player'},
    {'闪光力场','area(10).enemies.count >= 8 & health<=30 & spell(心灵尖啸).cooldown >0','player'},
}

local inCombat ={
    {boostSpeed},
    {saveMe},
    {healMe},
    {'!真言术：盾','health < 80 & !buff(救赎) & distance < 40','friendly'},
    {'!纯净术','debuff(腐败之水).any & distance < 30','friendly'},
    {'!真言术：盾','!buff(真言术：盾) & debuff(腐败之水).any & distance < 40','friendly'},
    {'真言术：慰','infront & talent(3,3) & infront','target'},
    {'暗言术：痛','!talent(6,1) & !debuff(暗言术：痛)','target'},
    {'暗言术：痛','!talent(6,1) & !debuff(暗言术：痛) & target(player)','enemies'},
    {'净化邪恶','talent(6,1) & !debuff(净化邪恶)','target'},
    {'净化邪恶','talent(6,1) & !debuff(净化邪恶) & target(player)','enemies'},
    {'教派分歧','infront & talent(1,3) & health > 90 & !player.moving','target'},
    {'惩击','infront & {{talent(1,3) & debuff(教派分歧)} || !talent(1,3)} & !player.moving & spell(苦修).cooldown > 0','target'},
    {'惩击','infront & !player.moving & spell(苦修).cooldown > 0','target'},
    {'苦修','infront & player.health > 50 & {{talent(1,3) & debuff(教派分歧)} || !talent(1,3)}','target'},
    {'苦修','infront & player.health > 50','target'},
    {shadowFriend},
    --渐隐术未做
    
   

}

local outCombat ={
{boostSpeed},
{buffCheck},
--血量不满，毒奶几口完事儿
{'暗影愈合','health < 90 & mana > 5 & !moving','player'},

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