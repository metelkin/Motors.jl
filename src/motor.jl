abstract type AbstractMotor end

struct Motor <: AbstractMotor
    pin1::Int
    pin2::Int
    reverse::Bool
    function Motor(pin1::Int, pin2::Int; reverse::Bool = false, range::Int = 100, frequency::Int = 160)
        if PiGPIOC.gpioInitialise() < 0
            throw("pigpio initialisation failed.")
        else
            @info "pigpio initialised okay."
        end
        
        PiGPIOC.gpioSetMode.([pin1, pin2], PiGPIOC.PI_OUTPUT);
        PiGPIOC.gpioWrite.([pin1, pin2], 0)

        real_range = PiGPIOC.gpioSetPWMrange(pin1, range)
        real_frequency = PiGPIOC.gpioSetPWMfrequency(pin1, frequency)
        
        #@info "REAL" real_range real_frequency
        new(pin1, pin2, reverse)
    end
end

function forward(motor::Motor)
    PiGPIOC.gpioWrite(motor.pin1, !motor.reverse ? 1 : 0)
    sleep(0.001)
    PiGPIOC.gpioWrite(motor.pin2, !motor.reverse ? 0 : 1)
    sleep(0.001)
end

function forward(motor::Motor, dutycycle::Int)
    real_range = PiGPIOC.gpioGetPWMrange(motor.pin1)
    PiGPIOC.gpioPWM(motor.pin1, !motor.reverse ? dutycycle : (real_range - dutycycle))
    sleep(0.001)
    PiGPIOC.gpioWrite(motor.pin2, !motor.reverse ? 0 : 1)
    sleep(0.001)
end

function back(motor::Motor)
    PiGPIOC.gpioWrite(motor.pin1, !motor.reverse ? 0 : 1)
    sleep(0.001)
    PiGPIOC.gpioWrite(motor.pin2, !motor.reverse ? 1 : 0)
    sleep(0.001)
end

function back(motor::Motor, dutycycle::Int)
    real_range = PiGPIOC.gpioGetPWMrange(motor.pin1)
    PiGPIOC.gpioPWM(motor.pin1, !motor.reverse ? (real_range - dutycycle) : dutycycle)
    sleep(0.001)
    PiGPIOC.gpioWrite(motor.pin2, !motor.reverse ? 1 : 0)
    sleep(0.001)
end

function stop(motor::Motor)
    PiGPIOC.gpioWrite(motor.pin1, 1)
    sleep(0.001)
    PiGPIOC.gpioWrite(motor.pin2, 1)
    sleep(0.001)
end

function clear(motor::Motor)
    PiGPIOC.gpioWrite(motor.pin1, 0)
    sleep(0.001)
    PiGPIOC.gpioWrite(motor.pin2, 0)
    sleep(0.001)
end
