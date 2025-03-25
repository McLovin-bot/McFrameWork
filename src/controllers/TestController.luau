local TestController = {
	Signals = {
		test = {},
	},
}

function TestController:Start()
	print("Hello")
end

return TestController
