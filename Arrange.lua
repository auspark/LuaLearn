function chElement( a,n,i )
	a[n],a[i]=a[i],a[n] -- 实现数组a的第i和n两个位置元素的对调
end
function ArrangeArr( a ,n)
	n = n or #a
	if n <= 1 then -- 只有1个元素
		coroutine.yield(a) -- 每次都停留在yield处，下一次resume时，进行下一次循环,yield的参数就是其返回值
	else
		for i=1,n do -- 第n个元素轮换为其中一个元素
			chElement(a,i,n) -- 对调i，n两个位置的元素
			ArrangeArr(a,n-1) -- 另外的元素按照上一步的操作进行
			chElement(a,i,n) -- 恢复原貌
		end
	end
end
-- 用coroutine(协程)做的一个迭代器
function permutations( a )
	local co = coroutine.create(function ( )
		ArrangeArr(a)
	end)
	return function (  )
		local code,res = coroutine.resume(co)
		return res
	end
end

--
-- 函数permutations使用了Lua语言中一种常见模式，就是将唤醒对应协程的调用包装在一个函数中
-- 由于这种模式比较常见，所以Lua语言专门提供了一个特殊函数coroutine.wrap()来完成这个功能
--
-- coroutine.wrap()与create()的比较
-- 相同点：函数wrap也用来创建一个新的协程。
-- 不同点：1、函数wrap返回的不是协程本身而是一个函数，当这个函数被调用时会唤醒协程。
--        2、该函数的第一个返回值不是错误代码，当遇到错误时该函数会抛出异常
--
function permutations_wrap( a )
	return coroutine.wrap(function() ArrangeArr(a)	end)
end



-- local array = {1,2}
local array = {1,2,3}
-- local array = {'a','b','c'}
-- local array = {1,2,3,4}
-- local array = {1,2,3,4,5}
-- ArrangeArr(array)
for p in permutations_wrap(array) do -- 迭代获取每一种排列, 每次迭代运行一次resume，到yield停住并返回yield的值
	for i=1,#p do
		io.write(p[i]," ") -- 排列是数组，使用循环打印出来
	end
	io.write("\n")
end
