-- 进攻驱散
local dispelTable ={
  水之护盾,
  力量药水,
  敏捷药剂,
  健康补益,
  积攒电荷,
  黑影步,
  流水护甲,
  大地之盾,
  --地渊孢林
  戈霍恩之赐,
  白骨之盾,
  衰弱意志,
  --塞塔里斯神庙
  胚胎精华,
  带电鳞片,
  积攒电荷,
  --托尔达戈
  镀金之爪,
  --暴富矿区
  脑部冻结,
  腐蚀性化合物,
  转化：粘液,
  灵魂防御,
  --PVP
真言术：韧,
天堂之羽,
保护之手,
智慧祝福,
奥术智慧,
回春术,
生命绽放,
愈合,
狂热,
无私治愈,
寒冰护体,
激流,
}
NeP.DSL:Register("needdispel",function(target)    
      for i = 1, #dispelTable do
      local dispelId = _G.GetSpellInfo(dispelTable[i])
      if _G.UnitBuff(target, dispelId) then
      return true end
    end
    end)

    

