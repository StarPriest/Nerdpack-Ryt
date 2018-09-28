# 戒律牧 Combat Routines
# 最好能做个提醒模块，可工会提醒，可密语，可屏幕中央仿DBM
## 五人本 / 大秘境
## 副本助手
 ### 大秘境相关词缀：火山、死疽、震荡
 ![震荡](https://wow.zamimg.com/images/wow/icons/medium/spell_nature_earthquake.jpg)![火山](https://wow.zamimg.com/images/wow/icons/medium/spell_shaman_lavasurge.jpg)  ![死疽](https://wow.zamimg.com/images/wow/icons/medium/spell_deathknight_necroticplague.jpg)
 > #### 【震荡】 图标名称：spell_nature_earthquake
 > #### 【震荡】震荡周没必要 真言术：韧 治疗的累，做个震荡周的开关，打开时执行震荡周策略
 > #### 【震荡】debuff名称：践踏，2.5秒 ，范围5码，伤害20%！！！！满血五码内五个必死，做类DBM提示 血量低于20% 无减伤必死，治疗优先级
> #### 【震荡】自己的震荡根据震荡debuff(践踏)的剩余时间是否小于GCD来判断是否需要打断自己当前施法。仅读条技能受限。
> #### 【震荡】指定范围内有震荡debuff玩家数量大于 x 且debuff剩余时间大于 Y时候，给技能 如盾/罩/压制/全神贯注盾 来不及，只能给最多2个人 
> #### 【震荡】优先级 无盾lowest且lowest不在放生范围内的最低值逆序1,2盾
> #### 【震荡】放生 (暴击盾吸收量18000 + 玩家当前血量) / 玩家最大血量 < 20%
> #### 【震荡】放生 (全神贯注暴击盾吸收量40000 + 玩家当前血量) / 玩家最大血量 < 20%

> #### 【火山】图标：Spell_shaman_lavasurge
> #### 【火山】任意玩家1码内如果有火山且 火山伤害为最大生命值50% * 火山数量 - 玩家当前血量 > 盾？ 暴击盾？痛苦压制？
> #### 【火山】火山 > 1 拉人。 只能拉一个血量最低的，T优先。
> #### 【火山】任意玩家1码范围内火山数量 > 2 放生

> #### 【死疽】图标:
> #### 【死疽】一层5%吸收治疗,
