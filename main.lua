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
	} -- map.world will contain the 2d map
	screen = { w = 640, h = 480 }
	pos = { x = 22, y = 12 } -- x and y start position
	dir = { x = -1, y = 0 } -- initial direction vector
	plane = { x = 0, y = 0.66 } -- the 2d raycaster version of camera plane

	camera = {}
	ray = { dir = {} }

	-- sets display to 640 x 480
	love.window.setMode(screen.w, screen.h)
end

function love.update(dt) end

function love.draw()
	for x = 0, screen.w - 1 do
		point = x
		-- calculate ray position and direction
		-- normalize x between -1, 1
		camera.x = 2 * x / screen.w - 1 -- x-coordinate in camera space
		ray.dir.x = dir.x + plane.x * camera.x
		ray.dir.y = dir.y + plane.y * camera.x

		-- which box of the map we're in
		map.x = round(pos.x) -- forces a number to be an integer
		map.y = round(pos.y)

		-- length of ray from current position to next x or y-side
		sideDistX = nil
		sideDistY = nil

		deltaDistX = ray.dir.x == 0 and 1e30 or math.abs(1 / ray.dir.x)
		deltaDistY = ray.dir.y == 0 and 1e30 or math.abs(1 / ray.dir.y)

		perpWallDist = nil

		-- what direction to step in x or y-direction (either +1 or -1)
		stepX = nil
		stepY = nil

		hit = 0 -- was there a wall hit?
		side = nil -- was a NS or EW wall hit?
		-- calculate step and initial sideDistX
		if ray.dir.x < 0 then
			stepX = -1
			sideDistX = pos.x - map.x * deltaDistX
		else
			stepX = 1
			sideDistX = map.x + 1.0 - pos.x * deltaDistX
		end

		if ray.dir.y < 0 then
			stepY = -1
			sideDistY = pos.y - map.y * deltaDistY
		else
			stepY = 1
			sideDistY = map.y + 1.0 - pos.y * deltaDistY
		end

		while hit == 0 do
			if sideDistX < sideDistY then
				sideDistX = sideDistX + deltaDistY
				map.x = map.x + stepX
				side = 0
			else
				sideDistY = sideDistY + deltaDistY
				map.y = map.y + stepY
				side = 1
			end
			-- check if ray hit a wall
			if map.world[map.x][map.y] > 0 then
				hit = 1
			end
		end

		if side == 0 then
			perpWallDist = sideDistX - deltaDistX
		else
			perpWallDist = sideDistY - deltaDistY
		end

		-- calculate height of line to draw on screen
		lineHeight = round(screen.h / perpWallDist)

		-- calculate lowest and highest pixel to fill in current stripe
		drawStart = round(-lineHeight / 2 + screen.h / 2)
		if drawStart < 0 then
			drawStart = 0
		end
		drawEnd = round(lineHeight / 2 + screen.h / 2)
		if drawEnd >= screen.h then
			drawEnd = screen.h - 1
		end

		if map.world[map.x][map.y] == 1 then
			love.graphics.setColor(255, 0, 0, 1)
		elseif map.world[map.x][map.y] == 2 then
			love.graphics.setColor(0, 128, 0, 1)
		elseif map.world[map.x][map.y] == 3 then
			love.graphics.setColor(0, 0, 255, 1)
		elseif map.world[map.x][map.y] == 4 then
			love.graphics.setColor(255, 255, 255, 1)
		else
			love.graphics.setColor(255, 255, 0, 1)
		end

		if side == 1 then
			-- love.graphics.setColor(0.5, 0.5, 0.5, 1)
		end

		-- draw the pixels of the stripe as a vertical line
		love.graphics.line(x, drawStart, x, drawEnd)
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
