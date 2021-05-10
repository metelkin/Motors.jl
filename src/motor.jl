struct Motor
    pin1::Int
    pin2::Int
    reverse::Bool
    function Motor(pin1::Int, pin2::Int; reverse::Bool = false)
        if gpioInitialise() < 0
            @error "pigpio initialisation failed."
        else
            @info "pigpio initialised okay."
        end
        
        gpioSetMode.([pin1, pin2], PiGPIOC.PI_OUTPUT);
        gpioWrite.([pin1, pin2], 0)
        
        new(pin1, pin2, reverse)
    end
end

function forward(motor::Motor)
    gpioWrite(motor.pin1, !motor.reverse ? 1 : 0)
    sleep(0.001)
    gpioWrite(motor.pin2, !motor.reverse ? 0 : 1)
    sleep(0.001)
end

function back(motor::Motor)
    gpioWrite(motor.pin1, !motor.reverse ? 0 : 1)
    sleep(0.001)
    gpioWrite(motor.pin2, !motor.reverse ? 1 : 0)
    sleep(0.001)
end

function stop(motor::Motor)
    gpioWrite(motor.pin1, 1)
    sleep(0.001)
    gpioWrite(motor.pin2, 1)
    sleep(0.001)
end

function clear(motor::Motor)
    gpioWrite(motor.pin1, 0)
    sleep(0.001)
    gpioWrite(motor.pin2, 0)
    sleep(0.001)
end
