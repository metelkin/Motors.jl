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
        sleep(duration)
        clear(car)
    end
end

function forward(car::Car, dutycycle::Int; duration = 0)
    forward(car.left, dutycycle)
    forward(car.right, dutycycle)

    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function back(car::Car; duration = 0)
    back(car.left)
    back(car.right)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function back(car::Car, dutycycle::Int; duration = 0)
    back(car.left, dutycycle)
    back(car.right, dutycycle)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function turn_left(car::Car; duration = 0)
    forward(car.left)
    back(car.right)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function turn_left(car::Car, dutycycle::Int; duration = 0)
    forward(car.left, dutycycle)
    back(car.right, dutycycle)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function turn_right(car::Car; duration = 0)
    back(car.left)
    forward(car.right)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function turn_right(car::Car, dutycycle::Int; duration = 0)
    back(car.left, dutycycle)
    forward(car.right, dutycycle)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function stop(car::Car; duration = 0)
    stop(car.left)
    stop(car.right)
    
    if duration > 0
        sleep(duration)
        clear(car)
    end
end

function clear(car::Car)
    clear(car.left)
    clear(car.right)
end
