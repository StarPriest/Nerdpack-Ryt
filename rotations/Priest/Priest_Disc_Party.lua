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

local baohu={
    {'!渐隐术','target(player) & distance < 20','enemies'},
    {'!痛苦压制','health < 30 & distance < 40','lowest'},
    {'!微光屏障','area(40,40).heal > 4'},
}

local jingong={
    {'教派分歧','distance < 40','Boss'},
    {'教派分歧','distance < 40','target'},
    {'暗言术：痛','!talent(6,1) & !debuff(暗言术：痛)','target'},
    {'暗言术：痛','!talent(6,1) & !debuff(暗言术：痛) & {target(tank) & target(friendly) || target(player)}','enemies'},
    {'净化邪恶','talent(6,1) & !debuff(净化邪恶)','target'},
    {'净化邪恶','talent(6,1) & !debuff(净化邪恶) & {target(tank) & target(friendly) || target(player)}','enemies'},    
    {'苦修','lowest.health > 50 & debuff(教派分歧) & distance < 40','enemies'},
    {'苦修','lowest.health > 50 & distance < 40','target'},
}


local jiushu = {
    {'真言术：耀','area(30,70).heal > 2 & distance < 40 & friendly.buff(救赎).count <=2','lowest'},
    {'真言术：盾','!buff(救赎) & health < 80 & distance < 40','friendly'},

}

local zhiliao ={
    {'苦修','health < 50 & player.buff(阴暗面之力) & distance < 40','tank'},
    {'苦修','health < 50 & player.buff(阴暗面之力) & distance < 40','lowest'},
    {'暗影愈合','health < 40 & distance < 40 & !player.moving','tank'},   
    {'暗影愈合','health < 40 & distance < 40 & !player.moving','lowest'},   
    {'!摧心魔','lowest.area(30,60).heal > 2 & friendly.buff(救赎).count > 2','target'}, 
}

local shadowFriend={
    --当我的天赋是暗影魔的时候，怪物数量>5 或者 怪物是精英 或者我血量低于70% 或者蓝量低于30%
    {'暗影魔','talent(3,2)','target'},
    --当我的天赋是摧心魔的时候，怪物数量>2 或者 怪物是精英 或者我血量低于70% 或者蓝量低于30%
    {'摧心魔','!talent(3,2)','target'},
}

local healMe ={
    --当我没有救赎buff的时候上个盾
    {'真言术：盾','!buff(救赎) & health < 80','player'},
    {'暗影愈合','health < 65 & !moving','player'},
    {'苦修','health < 50 & buff(阴暗面之力)','player'},
}

local buffCheck ={
    {'真言术：韧','!buff(真言术：韧)','player'},
    {'真言术：韧','!buff(真言术：韧) & distance < 30','friendly'},
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

local HealStone ={
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

local inCombat ={
    {boostSpeed},
    {saveMe},
    {healMe},
    {baohu},
    {jiushu},
    {jingong},
    {zhiliao},
   
    
   

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
    name = '|cffFACC2E [老日]|r 戒律牧 - |cffFACC2E五人本|r',
    ic = inCombat,
    ooc =outCombat,
    gui = GUI,
    gui_st = {title='老日的牧师助手-戒律牧单人模式', width='512', height='256', color='FACC2E'},
    ids = Spell_wow801_Priest_Disc,
    load = exeOnLoad,    
    blacklist = blacklist
  
  })