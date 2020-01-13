t = {10, print, x = 12, k = 'hi'}
for k,v in pairs(t) do
	print(k,v)
end

-- 1	10
-- 2	function: 0x7ff52bc04180
-- k	hi
-- x	12

--[[
5.4 遍历表 pairs
pairs
元素出现顺序可能是随机的

唯一可以确定的是：
每个元素会且只会出现1次

]]


t = {10, print, 12, 'hi'}
for k,v in ipairs(t) do
	print(k,v)
end

-- 1	10
-- 2	function: 0x7fcc70c04180
-- 3	12
-- 4	hi
--[[
ipairs: Lua会确保遍历是按照顺序进行的
]]


for i=1,#t do
	print(i,t[i])
end
-- 数值型for循环，也能保证是按照循序进行的







