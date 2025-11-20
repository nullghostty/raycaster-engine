-- NOTES
-- ===========
-- VSync caps frames to 60 FPS, to uncap:
--   love.window.setVSync(0) in love.load()
--   set { vsync = 0 } in love.window.setMode()

function love.load()
    map = {
        world = {
            { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 3, 0, 3, 0, 3, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 3, 0, 3, 0, 3, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 0, 4, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 0, 0, 0, 0, 5, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 0, 4, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
            { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
        },
    }                        -- map.world will contain the 2d map
    screen = { w = 640, h = 480, dt = 0 }
    pos = { x = 22, y = 12 } -- x and y start position
    dir = { x = -1, y = 0 }  -- initial direction vector
    plane = { x = 0, y = 0.66 } -- the 2d raycaster version of camera plane

    camera = {}
    ray = { dir = {} }

    -- sets display to 640 x 480
    love.window.setMode(screen.w, screen.h)
    love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.update(dt)
    screen.dt = dt

    -- speed modifiers
    moveSpeed = screen.dt * 5.0 -- the constant value is in squares/second
    rotSpeed = screen.dt * 0.00001 -- the constant value is in radians/second

    if love.keyboard.isDown("up") then
        if map.world[round(pos.x + dir.x * moveSpeed)][round(pos.y)] == 0 then
            pos.x = pos.x + dir.x * moveSpeed
        end

        if map.world[round(pos.x)][round(pos.y + dir.y * moveSpeed)] == 0 then
            pos.y = pos.y + dir.y * moveSpeed
        end
    end

    if love.keyboard.isDown("down") then
        if map.world[round(pos.x - dir.x * moveSpeed)][round(pos.y)] == 0 then
            pos.x = pos.x - dir.x * moveSpeed
        end

        if map.world[round(pos.x)][round(pos.y - dir.y * moveSpeed)] == 0 then
            pos.y = pos.y - dir.y * moveSpeed
        end
    end

    if love.keyboard.isDown("right") then
        rot = -0.01 -- fixed radians per frame; adjust for speed
        oldDirX = dir.x
        dir.x = dir.x * math.cos(rot) - dir.y * math.sin(rot)
        dir.y = oldDirX * math.sin(rot) + dir.y * math.cos(rot)
        oldPlaneX = plane.x
        plane.x = plane.x * math.cos(rot) - plane.y * math.sin(rot)
        plane.y = oldPlaneX * math.sin(rot) - plane.y * math.cos(rot)
        local len = math.sqrt(dir.x^2 + dir.y^2)
        if len > 0 then
            dir.x = dir.x / len
            dir.y = dir.y / len
        end
        len = math.sqrt(plane.x^2 + plane.y^2)
        if len > 0 then
            plane.x = plane.x / len
            plane.y = plane.y / len
        end
    end

    if love.keyboard.isDown("left") then
        rot = 0.01 -- fixed radians per frame; adjust for speed
        oldDirX = dir.x
        dir.x = dir.x * math.cos(rot) - dir.y * math.sin(rot)
        dir.y = oldDirX * math.sin(rot) + dir.y * math.cos(rot)
        oldPlaneX = plane.x
        plane.x = plane.x * math.cos(rot) - plane.y * math.sin(rot)
        plane.y = oldPlaneX * math.sin(rot) - plane.y * math.cos(rot)
        local len = math.sqrt(dir.x^2 + dir.y^2)
        if len > 0 then
            dir.x = dir.x / len
            dir.y = dir.y / len
        end
        len = math.sqrt(plane.x^2 + plane.y^2)
        if len > 0 then
            plane.x = plane.x / len
            plane.y = plane.y / len
        end
    end
end

function love.draw()
    -- clears previous frame
    love.graphics.clear()

    for x = 0, screen.w - 1 do
        -- calculate ray position and direction
        -- normalize x between -1, 1
        camera.x = 2 * x / screen.w - 1 -- x-coordinate in camera space
        ray.dir.x = dir.x + plane.x * camera.x
        ray.dir.y = dir.y + plane.y * camera.x

        -- which box of the map we're in
        map.x = round(pos.x) -- forces a number to be an integer
        map.y = round(pos.y)

        -- length of ray from current position to next x or y-side
        sideDistX = 0.0
        sideDistY = 0.0

        deltaDistX = ray.dir.x == 0 and 1e30 or math.abs(1 / ray.dir.x)
        deltaDistY = ray.dir.y == 0 and 1e30 or math.abs(1 / ray.dir.y)

        perpWallDist = 0.0

        -- what direction to step in x or y-direction (either +1 or -1)
        stepX = 0
        stepY = 0

        hit = 0 -- was there a wall hit?
        side = 0 -- was a NS or EW wall hit?
        -- calculate step and initial sideDistX
        if ray.dir.x < 0 then
            stepX = -1
            sideDistX = (pos.x - map.x) * deltaDistX
        else
            stepX = 1
            sideDistX = (map.x + 1.0 - pos.x) * deltaDistX
        end

        if ray.dir.y < 0 then
            stepY = -1
            sideDistY = (pos.y - map.y) * deltaDistY
        else
            stepY = 1
            sideDistY = (map.y + 1.0 - pos.y) * deltaDistY
        end

        local maxIter = 50
        local iter = 0
        while hit == 0 and iter < maxIter do
            iter = iter + 1
            if sideDistX < sideDistY then
                sideDistX = sideDistX + deltaDistX
                map.x = map.x + stepX
                side = 0
            else
                sideDistY = sideDistY + deltaDistY
                map.y = map.y + stepY
                side = 1
            end
            -- check if ray hit a wall
            if map.x >= 1 and map.x <= 24 and map.y >= 1 and map.y <= 24 and map.world[map.x][map.y] > 0 then
                hit = 1
            end
        end

        if side == 0 then
            perpWallDist = (map.x - pos.x + (1 - stepX) / 2) / ray.dir.x
        else
            perpWallDist = (map.y - pos.y + (1 - stepY) / 2) / ray.dir.y
        end
        perpWallDist = math.abs(perpWallDist)

        -- calculate height of line to draw on screen
        lineHeight = math.floor(screen.h / perpWallDist)

        -- calculate lowest and highest pixel to fill in current stripe
        drawStart = round(-lineHeight / 2 + screen.h / 2)
        if drawStart < 0 then
            drawStart = 0
        end
        drawEnd = round(lineHeight / 2 + screen.h / 2)
        if drawEnd >= screen.h then
            drawEnd = screen.h - 1
        end

        color = nil
        if map.world[map.x][map.y] == 1 then
            -- red
            color = { r = 255, g = 0, b = 0, a = 255 }
        elseif map.world[map.x][map.y] == 2 then
            -- green
            color = { r = 0, g = 128, b = 0, a = 255 }
        elseif map.world[map.x][map.y] == 3 then
            -- blue
            color = { r = 0, g = 0, b = 255, a = 255 }
        elseif map.world[map.x][map.y] == 4 then
            -- white
            color = { r = 255, g = 255, b = 255, a = 255 }
        else
            -- yellow
            color = { r = 255, g = 255, b = 0, a = 255 }
        end

        if side == 1 then
            color.r = color.r / 2
            color.g = color.g / 2
            color.b = color.b / 2
            color.a = 128
        end

        love.graphics.setColor(color.r, color.g, color.b, color.a)

        -- draw the pixels of the stripe as a vertical line
        love.graphics.rectangle("fill", x, drawStart, 1, drawEnd - drawStart + 1)

        love.graphics.print("FPS: " .. 1 / screen.dt, 10, 10)
    end
end

function round(x)
    local f = math.floor(x)
    if (x == f) or (x % 2.0 == 0.5) then
        return f
    else
        return math.floor(x + 0.5)
    end
end
