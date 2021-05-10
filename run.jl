
const MOTOR_A1 = 4 # PWM
const MOTOR_A2 = 3
const MOTOR_B1 = 6 # PWM
const MOTOR_B2 = 5

using Motors

### TEST ###

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
