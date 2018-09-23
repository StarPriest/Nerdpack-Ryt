local _, RYT = ...
local NeP = NeP

local GUI = {
    {type = "texture",
    --texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\holy.blp",
    width = 512, 
    height = 400, 
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
    {type = 'checkspin', text = '启用 守护之魂-TANK', key = 'Key_GT', spin = 20, max=100, size=14,check = true},
    {type = 'checkspin', text = '启用 守护之魂-PLAYER', key = 'Key_GP', spin = 15, size=14,check = true},
    {type = 'ruler'},{type = 'spacer'},


    {type = 'header', text = '团刷技能 设置', size=18,align = 'center'},
    {type = 'checkbox', text = '启用 愈合祷言', key = 'key_PM', width = 55, size=14,default = true},
    {type = 'checkbox', text = '启用 圣言术：灵', key = 'key_Sanctify', width = 55, size=14,default = true},
    {type = 'spinner', text = '-圣言术：灵 使用最低血量', key = 'key_Sanctify_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-圣言术：灵 使用最低人数', key = 'key_Sanctify_Count', size=14,width = 55, max = 40, step = 1, default = 5},

    {type = 'checkbox', text = '启用 治疗之环', key = 'key_HC', width = 55, size=14,default = true},
    {type = 'spinner', text = '-治疗之环 使用最低血量', key = 'key_HC_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-治疗之环 使用最低人数', key = 'key_HC_Count', size=14,width = 55, max = 40, step = 1, default = 3},

    {type = 'checkbox', text = '启用 治疗祷言', key = 'key_PH', width = 55, size=14,default = true},
    {type = 'spinner', text = '-治疗祷言 使用范围', key = 'key_PH_Range', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-治疗祷言 使用最低血量', key = 'key_PH_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-治疗祷言 使用最低人数', key = 'key_PH_Count', size=14,width = 55, max = 40, step = 1, default = 4},

    {type = 'checkbox', text = '启用 光晕', key = 'key_Hola', width = 55, size=14,default = true},
    {type = 'spinner', text = '-光晕 使用最低血量', key = 'key_Hola_Health', size=14,width = 55, max = 100, step = 1, default = 80},
    {type = 'spinner', text = '-光晕 使用最低人数', key = 'key_Hola_Count', size=14,width = 55, max = 40, step = 1, default = 10},

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
    print('|cffFACC2E 神牧团队副本战斗策略已载入|r')
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
  
    NeP.Interface:AddToggle({
      key = 'autoFly',
      name = '仙姿',
      text = '启用高逼格，就是一直保持自己有漂浮术',
      icon = 'Interface\\ICONS\\spell_holy_layonhands', --toggle(autoFly)
    })

    NeP.Interface:AddToggle({
        key = 'autoFly2',
        name = '防摔死',
        text = '自动防摔死',
        icon = 'Interface\\ICONS\\spell_shadow_manafeed', --toggle(autoFly)
      })
     
      NeP.Interface:AddToggle({
        key = 'DPS',
        name = '启用dps',
        text = '打打dps',
        icon = 'Interface\\ICONS\\spell_holy_searinglight', --toggle(autoFly)
      })
      NeP.Interface:AddToggle({
        key = 'speed',
        name = '加速',
        text = '加速',
        icon = 'Interface\\ICONS\\spell_holy_heroism', --toggle(autoFly)
      })    
  end



local autoFly =
{
    {'漂浮术','player.mana > 10 & !buff(漂浮术)','player'},
}  

local autoFly2 =
{
    {'漂浮术','player.falling & player.mana > 10 & !buff(漂浮术)','player'},
}

local purfy =
{   
    --注意 指定buff层数远离人群这种。 可以写出来 利用区域检测
    --指定buff层数 去指定地点写不出来 
    {'纯净术','debuff(死亡之愿).any & distance < 40','friendly'},
}

local dispel =
{

    {'驱散魔法','buff(水之护盾).any & distance < 30','enemies'},
    {'驱散魔法','buff(力量药水).any & distance < 30','enemies'},
    {'驱散魔法','buff(敏捷药剂).any & distance < 30','enemies'},
    {'驱散魔法','buff(健康补益).any & distance < 30','enemies'},
    {'驱散魔法','buff(暗影束缚 ).any & distance < 30 & spell(群体驱散).cooldown > 0','enemies'},
    {'群体驱散','buff(暗影驱散) & area(15).enemies >=3','enemies.ground'},--尝试自动大驱    
}

--加速
local boostSpeed =
{
    --羽毛
    {'天堂之羽','UI(key_AF) & talent(2,3) & player.moving & !buff(天堂之羽)','player.ground'},
}

--真言术：韧
local BuffCheck =
{   
    --{'真言术：韧','distance<40 & !buff(真言术：韧)','player'},
    {'真言术：韧','distance<40 & !buff(真言术：韧)','friendly'},
}


--================================================================================================================================================================
--治疗石

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


local GuardMeOrTank = 
{
    {HealStone},
    {Posion},
    --当自己血量低于35% 绝望祷言
    {'绝望祷言','player.health < UI(Key_DP_spin) & UI(Key_DP_check)','player'},
    --当自己血量低于15% 翅膀
    {'守护之魂','health < UI(Key_GP_spin) & UI(Key_GP_check)','player'},
    --当T血量低于10% 翅膀
    {'守护之魂','tank.health < UI(Key_GT_spin) & UI(Key_GT_check)','tank'},
    {'圣言术：静','player.health < 50','player'},
    {'快速治疗','spell(圣言术：静).cooldown > 0 & player.health < 80','player'},

}

local GuradRaid =
{
    --当dps血量低于10% 翅膀
    {'守护之魂','lowest.health < 10','lowest'},     
}


--团刷，数据怎么好看怎么来
local HealRaid =
{
    --愈合祷言
    {'愈合祷言', 'UI(key_PM) & !player.moving & player.health > 30 & !buff(愈合祷言) & distance < 40', {'tank1','tank2','player','lowest'}},  
    --圣言术：灵 
    {'!圣言术：灵','UI(key_Sanctify) & friendly.distance<40 & friendly.area(10,UI(key_Sanctify_Health)).heal >= UI(key_Sanctify_Count)','friendly.ground'},
    --治疗祷言 目标40码内最近的四个人。
    {'治疗祷言','UI(key_PH) & lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & {spell(治疗之环).cooldown > 0 & talent(5,3)} & lowest.area(UI(key_PH_Range),UI(key_PH_Count)).heal >= UI(key_PH_Count) & !player.moving','lowest'},
    --治疗之环
    {'!治疗之环','UI(key_HC) & talent(5,3) & friendly.distance < 40 & friendly.area(30,UI(key_HC_Health)).heal >= UI(key_HC_Count)','friendly'},
    --光晕
    {'光晕','UI(Key_Halo) & talent(6,3) & player.area(30,UI(Key_Halo_Health)) >= UI(Key_Halo_Count) & !player.moving'},   
    --圣言术：赎
    {'圣言术：赎','UI(key_Salvation) & talent(7,3) & player.area(40,UI(key_Salvation_Health)) >= UI(key_Salvation_Count) & !player.moving'},   

}

--待完善 团刷无法覆盖需要好好斟酌
local HealSingle=
{
    --快速治疗 使用前提:团刷无法覆盖
    {'快速治疗','UI(Key_FlashHeal_check) & lowest.health < UI(Key_FlashHeal_spin) & lowest.distance < 40','lowest'},
    --圣言术：静
    {'!圣言术：静','UI(Key_Serenity_check) & lowest.health < UI(Key_Serenity_spin) & lowest.distance < 40','lowest'},
    --恢复 使用前提:团刷无法覆盖
    {'恢复','UI(Key_Renew_check) & tank.distance < 40 & tank.health < UI(Key_Renew_spin) & !tank.buff(恢复) & player.moving','tank'},
    --治疗术 使用前提:团刷无法覆盖
    {'治疗术','UI(Key_Heal_check) & lowest.health < UI(Key_Heal_spin) & lowest.distance < 40 & lowest.area(40,80).heal < 3','lowest'},
}





local inCombat=
{
    {dispel,'toggle(dispel)'},  
    {purfy,'toggle(purfy)'},  
    {autoFly,'toggle(autoFly)'},
    {autoFly2,'toggle(autoFly2)'},
    {boostSpeed,'toggle(speed)'},     
    {purfy},     
    {BuffCheck,'UI(key_IC_PF)'},
    {GuardMeOrTank},
    {GuradRaid},
    {HealRaid},
    {HealSingle},
    
}




--非战斗状态策略
local outCombat=
{
    {dispel,'toggle(dispel)'},  
    {purfy,'toggle(purfy)'}, 
    {autoFly,'toggle(autoFly)'},
    {autoFly2,'toggle(autoFly2)'},
    {BuffCheck,'UI(key_OOC_PF)'},  
    {boostSpeed,'toggle(speed)'},  

    --圣言术：灵 
    {'圣言术：灵','UI(key_Sanctify) & friendly.distance<40 & friendly.area(10,UI(key_Sanctify_Health)).heal >= UI(key_Sanctify_Count)','friendly.ground'},
    --治疗祷言 目标40码内最近的四个人。
    {'治疗祷言','UI(key_PH) & lowest.distance < 40 & spell(圣言术：灵).cooldown > 0 & {spell(治疗之环).cooldown > 0 & talent(5,3)} & lowest.area(UI(key_PH_Range),UI(key_PH_Count)).heal >= UI(key_PH_Count) & !player.moving','lowest'},
    --治疗之环
    {'治疗之环','UI(key_HC) & talent(5,3) & friendly.distance < 40 & friendly.area(30,UI(key_HC_Health)).heal >= UI(key_HC_Count)','friendly'},
    --快速治疗
    {'快速治疗','spell(圣言术：静).cooldown > 0 & lowest.health < 85 & lowest.distance < 40 & lowest.area(40,80).heal < 3','lowest'},
    --圣言术：静
    {'圣言术：静','lowest.health < 70 & lowest.distance < 40 ','lowest'},
    --全程愈合
    {'愈合祷言','!buff(愈合祷言) & distance < 40','tank1,tank2'},
    
}

local blacklist = {
    debuff = {name = "Misery"},
}
local Spell_wow801_Priest_Holy={

}

NeP.CR:Add(257, {
    name = '|cffFACC2E [老日]|r 神牧 - |cffFACC2E团本|r',
    ic = {{inCombat,'group.type == 3 &!player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    ooc = {{outCombat,'group.type == 3 & !player.channeling(神圣赞美诗) & !player.channeling(希望象征) & !player.channeling(滋养药水) & !player.casting(圣言术：赎)'}},
    gui = GUI,
    gui_st = {title='老日的牧师助手-神牧', width='512', height='256', color='FACC2E'},
    ids = Spell_wow801_Priest_Holy,
    load = exeOnLoad,    
    blacklist = blacklist
  
  })