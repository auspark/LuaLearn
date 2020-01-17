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

-- local array = {1,2}
local array = {'a',2,'d'}
-- local array = {1,2,3,4}
-- local array = {1,2,3,4,5}
-- ArrangeArr(array)
for p in permutations(array) do -- 迭代获取每一种排列, 每次迭代运行一次resume，到yield停住并返回yield的值
	for i=1,#p do
		io.write(p[i]," ") -- 排列是数组，使用循环打印出来
	end
	io.write("\n")
end
