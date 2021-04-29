
local bench = require"bench"
local zmq = require"zmq"

local N = tonumber(arg[1] or 1000000)

local test = bench.method_call()

local function run_bench(action_name, N, func)

	local timer = zmq.stopwatch_start()
	
	for i=1,N do
		func()
	end
	
	local elapsed = timer:stop()
	if elapsed == 0 then elapsed = 1 end
	
	local throughput = N / (elapsed / 1000000)
	
	print(string.format("finished in %i sec, %i millisec and %i microsec, %i '%s'/s",
	(elapsed / 1000000), (elapsed / 1000) % 1000, (elapsed % 1000), throughput, action_name
	))
end

run_bench('C API method calls', N, function()
	test:simple()
end)

run_bench('null method calls', N, function()
	test:null()
end)


