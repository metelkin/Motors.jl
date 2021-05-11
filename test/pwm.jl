
const MOTOR_A1 = 4 # PWM
const MOTOR_A2 = 3
const MOTOR_B1 = 6 # PWM
const MOTOR_B2 = 5

using Motors
car = Car(
    Motor(MOTOR_A1, MOTOR_A2),
    Motor(MOTOR_B1, MOTOR_B2; reverse = true)
)

println("Left forward 100% ...")

println(100)
forward(car, 100; duration = 2)
back(car, 100; duration = 2)

println(75)
forward(car, 75; duration = 2)
back(car, 75; duration = 2)

println(50)
forward(car, 50; duration = 2)
back(car, 50; duration = 2)

println(25)
forward(car, 25; duration = 2)
back(car, 25; duration = 2)

clear(car)
