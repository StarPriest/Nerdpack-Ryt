--友方驱散（纯净术）
local PurifyTable ={
    烈焰震击,
    毒蛇诱惑,
    瘟疫,
    感染之伤,
    火把攻击,
    衰弱怒吼,
    火力压制,
    点火器,
    正义烈焰,
    冰霜震击,
    腐败之血,
    腐败之水,
        --地渊孢林

    化学灼烧,
    浸油之刃,
    野火,
    熔化的黄金,
    挥之不去的恶心感,
    瘟疫步,
    冰霜冲击,
    脑部冻结,
    --庄园
    碎裂灵魂,
    定身,  
    --PVP
    阳炎术,
    月火术,
    冰霜新星,
    冰冻术,
    腐蚀术,
    原始暴怒
  }


NeP.DSL:Register("needpurify",function(target)
    for i = 1, #PurifyTable do
      local PurifyId = _G.GetSpellInfo(PurifyTable[i])
      if _G.UnitDebuff(target, PurifyId) then
      return true end
    end
    end)