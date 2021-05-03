
const MOTOR_A1 = 4 # PWM
const MOTOR_A2 = 3
const MOTOR_B1 = 6 # PWM
const MOTOR_B2 = 5

module Engine

using BaremetalPi
export Motor, Car
export forward, back, stop, clear, turn_left, turn_right

struct Motor
    pin1::Int
    pin2::Int
    reverse::Bool
    function Motor(pin1::Int, pin2::Int; reverse::Bool = false)
        gpio_set_mode([pin1, pin2], :out)
        gpio_clear([pin1, pin2])        
        
        new(pin1, pin2, reverse)
    end
end

function forward(motor::Motor)
    !motor.reverse ? gpio_set(motor.pin1) : gpio_clear(motor.pin1)
    sleep(0.001)
    !motor.reverse ? gpio_clear(motor.pin2) : gpio_set(motor.pin2)
    sleep(0.001)
end

function back(motor::Motor)
    !motor.reverse ? gpio_clear(motor.pin1) : gpio_set(motor.pin1)
    sleep(0.001)
    !motor.reverse ? gpio_set(motor.pin2) : gpio_clear(motor.pin2)
    sleep(0.001)
end

function stop(motor::Motor)
    gpio_set(motor.pin1)
    sleep(0.001)
    gpio_set(motor.pin2)
    sleep(0.001)
end

function clear(motor::Motor)
    gpio_clear(motor.pin1)
    sleep(0.001)
    gpio_clear(motor.pin2)
    sleep(0.001)
end

init_gpio()
struct Car
    left::Motor
    right::Motor
    function Car(left::Motor, right::Motor)
        
        new(left, right)
    end
end

function forward(car::Car; duration = 0)
    forward(car.left)
    forward(car.right)

    if duration > 0
        wait(duration)
        clear(car)
    end
end

function back(car::Carr; duration = 0)
    back(car.left)
    back(car.right)
    
    if duration > 0
        wait(duration)
        clear(car)
    end
end

function turn_left(car::Carr; duration = 0)
    forward(car.left)
    back(car.right)
    
    if duration > 0
        wait(duration)
        clear(car)
    end
end

function turn_right(car::Carr; duration = 0)
    back(car.left)
    forward(car.right)
    
    if duration > 0
        wait(duration)
        clear(car)
    end
end

function stop(car::Carr; duration = 0)
    stop(car.left)
    stop(car.right)
    
    if duration > 0
        wait(duration)
        clear(car)
    end
end

function clear(car::Car)
    clear(car.left)
    clear(car.right)
end

end

### TEST ###

using .Engine

car = Car(
    Motor(MOTOR_A1, MOTOR_A2),
    Motor(MOTOR_B1, MOTOR_B2; reverse = true)
)

println("Forward 3 sec...")
forward(car; duration = 3)
sleep(1)

println("Backward 3 sec...")
back(car; duration = 3)
sleep(1)

println("right 3 sec...")
turn_right(car; duration = 3)
sleep(1)

println("left 3 sec...")
turn_left(car; duration = 3)
sleep(1)

clear(car)
println("STOP ALL.")
