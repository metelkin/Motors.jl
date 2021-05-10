module Motors

using PiGPIOC

export Motor, forward, back, stop, clear

export Car, turn_left, turn_right

include("./motor.jl")
include("./car.jl")

end
