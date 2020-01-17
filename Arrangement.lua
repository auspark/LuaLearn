-- 求数组所有元素的全部排列
--
-- 基本思路
-- ①有1个元素，不变，直接输出
-- ②有2个元素，第2个元素轮换为其中一个元素，另外1个元素与第①步同
-- ③有3个元素，第3个元素轮换为其中一个元素，另外2个元素与第②步同
-- ④有4个元素，第4个元素轮换为其中一个元素，另外3个元素与第③步同
-- 更多元素，以此类推
-- 
-- 实际编程中，可将第①或第②步骤作为终结循环步骤，或者说是查找的开始的步骤
--

function ArrangeArr( a ,n)
	n = n or #a
	if n <= 1 then -- 只有2个元素
		printResult(a) -- 输出对调前的排列
		-- chElement(a,1,2) -- 对调1，2两个位置的元素
		-- printResult(a) -- 输出对调后的排列
		-- chElement(a,1,2) -- 恢复原貌
	else
		for i=1,n do -- 第n个元素轮换为其中一个元素
			chElement(a,i,n) -- 对调i，n两个位置的元素
			ArrangeArr(a,n-1) -- 另外的元素按照上一步的操作进行
			chElement(a,i,n) -- 恢复原貌
		end
	end
end

function chElement( a,n,i )
	a[n],a[i]=a[i],a[n] -- 实现数组a的第i和n两个位置元素的对调
end

function printResult( a ) -- 打印数组
	for i=1,#a do
		io.write(a[i]," ")
		io.flush()
	end
	io.write('\n')
	io.flush()
end

-- local array = {1,2}
-- local array = {1,2,3}
-- local array = {1,2,3,4}
local array = {1,2,3,4,5}
ArrangeArr(array)

