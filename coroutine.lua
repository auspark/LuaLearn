-- 线程与协程主要区别：
-- 一个多线程程序可以并行运行多个线程
-- 协程需要彼此协作地运行，即在任意指定的时刻只能有1个协程运行，且只有当正在运行的协程显式地要求被挂起（suspend)时，其执行才会暂停

-- Lua语言中协程相关的所有函数都被放在表coroutine中
-- 函数create用于创建新协程
-- coroutine.create(函数)
-- create函数返回一个thread类型的值

-- 通常create的参数时一个匿名函数，但也可以是一个单独定义的非匿名函数

co = coroutine.create(function () print('hi') end)
print(type(co))
-- 返回值类型为thread

-- 一个协程有4中状态： 挂起（suspended），运行（running），正常（normal），死亡（dead）
-- 使用 coroutime.status(co)来检查
-- 当一个协程被创建时，它处于被挂起状态，即协程不会在被创建时自动运行
print(coroutine.status(co)) -- 协程桩体为suspended

-- coroutine.resume(co)
-- 启动或再次启动一个协程的执行，并将其状态由挂起改为运行
coroutine.resume(co) -- 执行函数，输出’hi‘

print(coroutine.status(co)) -- 协程状态为dead

-- coroutine.yield()
-- 该函数可以让一个运行中的协程挂起自己，然后在后续恢复运行
co = coroutine.create(function (  )
	for i=1,10 do
		print("co",i)
		coroutine.yield()
	end
end)

coroutine.resume(co) -- 1 
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 2  
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 3
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 4
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 5
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 6
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 7
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 8
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 9
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 10
print(coroutine.status(co)) -- 在yield（）处挂起自己，协程状态为suspended
coroutine.resume(co) -- 11
print(coroutine.status(co)) -- 经过以上10次的循环执行，循环完毕，协程进入dead状态

-- 以上过程说明每使用resume()执行一次，都会遇到yield()挂起一次，

print(coroutine.resume(co)) -- false	cannot resume dead coroutine, 当试图启动一个dead状态的协程时，会返回false及错误信息
-- 像函数pcall一样，函数resume也运行在保护模式中
-- 因此，如果协程在执行中出错，Lua语言不会显示错误信息，而是将错误信息返回给函数resume

-- 正常状态（normal）
-- 协程A唤醒协程B时，协程A既不是挂起状态（因为不能唤醒协程A），也不是运行状态（因为正在运行的协程是B），
-- 协程A此时的状态就被称为正常状态


-- Lua语言一个非常有用的机制是通过一对resume-yield来交换数据
co = coroutine.create(function ( a,b,c )
	print("co",a,b,c+2)
end)
coroutine.resume(co,1,2,3) -- co	1	2	5

co = coroutine.create(function ( a,b )
	coroutine.yield(a+b, a-b)
end)
print(coroutine.resume(co,20,10)) -- true	30	10
-- 函数resume()的返回值中，第一个返回值为true时表示没有错误，之后的返回值对应函数yield的参数

-- 与以上对应的是，函数yield的返回值是对应的resume的参数
co = coroutine.create(function ( x )
	print("co1",x)
	print("co2",coroutine.yield())
end)
coroutine.resume(co,"hi") -- 只有第一个resume时，只有co1这一个输出co1	hi
coroutine.resume(co,4,5) -- 第二次执行resume时，会有co2这第二个输出co2	4	5


-- create coroutine function 





