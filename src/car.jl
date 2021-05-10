struct Car
    left::Motor
    right::Motor
    function Car(left::Motor, right::Motor)
        gpioInitialise()
        
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

function back(car::Car; duration = 0)
    back(car.left)
    back(car.right)
    
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

function turn_right(car::Car; duration = 0)
    back(car.left)
    forward(car.right)
    
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
