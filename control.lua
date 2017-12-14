debug = false

script.on_event(defines.events.on_built_entity, function(event)
	if	(event.created_entity.name == "tree-brush") then 
		onBuildHandler(event) 
	end
end)

function position_from_position_and_radius (position, radius)
	local position = position or {x = 0, y = 0}
	local radius = radius or 8

	local angle = math.random(0, 2*math.pi)
	radius = math.random(0, radius)
	local x = position.x + radius * math.cos(angle)
	local y = position.y + radius * math.sin(angle)
	printAll("x: ".. x .. " y: " .. y)
	local new_position = {x = x, y = y}
	return new_position
end

function random_tree ()
	local trees_list = {"tree-01", "tree-02", "tree-03", "tree-04", "tree-05", "tree-06", "tree-07", "tree-08", "tree-09"}
	return trees_list[math.random(#trees_list)]
end

function onBuildHandler (event)
	local entity = event.created_entity
	local surface = entity.surface
	
	for i = 1, 100 do
		local new_pos = position_from_position_and_radius (entity.position, 5)
		local can_be_placed = surface.can_place_entity{name=random_tree (), position=new_pos, force = "neutral"}
		if can_be_placed then
			printAll("can be placed")
			local tree = surface.create_entity{name="tree-01", position=new_pos, force = "neutral"}
			entity.destroy()
			return
		end
	end
	-- printAll("001 ".. entity.name .. " " .. entity.direction)
	-- local targetEntity = findNearestEntity(entity.position, 5)
	-- printAll("002 ".. entity.name .. " " .. entity.position.x .. " " .. entity.position.y)
	-- initEntity (targetEntity)
	-- if (targetEntity and targetEntity.name) then 
		-- printAll("003 ".. "targetEntity.name " .. targetEntity.name .. " "  .. targetEntity.type .. " "  .. targetEntity.force.name .. " " )
		-- local newPos = directionToPosition(targetEntity.position, entity.direction, 1/32)
		-- printAll("004 ".. "newPos.x " .. newPos.x .. " targetEntity.position.x "  .. targetEntity.position.x )
		-- targetEntity.teleport(newPos) 
		-- local globEntity = tableContains(global.entities, targetEntity)
		-- if globEntity then printAll("globEntity is true! " .. type(globEntity)) end
		-- printAll(globEntity)
		-- local pShift = globEntity.pShift
		-- local firstPos = globEntity.position
		-- local ID = globEntity.ID
		-- local nowPos = targetEntity.position
		-- pShift  = vectorDelta (nowPos, firstPos) 
		-- printAll(pShift)
		-- printAll(global)
		-- global.entities[ID].pShift = pShift
		-- printAll("shift = {x=" .. pShift.x .. ", y=" .. pShift.y.."}", true)
	-- end
	entity.destroy()
	game.players[event.player_index].insert{name="tree-brush", count=1}
end

function vectorDelta (p1, p2)
	return {x=p1.x-p2.x, y=p1.y-p2.y}
end

--  init 
function initEntity (entity)
	if not entity then return end
	if not global.entities then global.entities = {} end
	if not global.ID then global.ID = 1 else global.ID = global.ID + 1 end
	printAll("101 ".. entity.name .. " start init: " .. #global.entities)
	local taCo = tableContains(global.entities, entity)
	if taCo then return end
	local NewEntity = {
		name = entity.name,
		position = entity.position,
		pShift = {x=0, y=0},
		entity = entity,
		ID = global.ID
		}
	global.entities[global.ID] = NewEntity
	-- table.insert(global.entities, NewEntity)
	printAll("102 ".. entity.name .. " end init: " .. #global.entities)
end


function tableContains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return value
    end
	 if type(value) == "table" then
		local valueOrFalse = tableContains(value, element)
		if valueOrFalse then return value end
	 end
  end
  return false
end


function printAll(text, bool)
	if (debug or bool) then
		local text2 = ""
		if type(text) == "table" then text2 = serpent.block(text, {comment=false})
			for i in pairs (game.players) do
				game.players[i].print(text2)
			end
		else
			for i in pairs (game.players) do
				game.players[i].print(text)
			end
		end
	end
end

function findNearestEntity(position, radius)
	local radius = radius or 5
	local entities = game.surfaces["nauvis"].find_entities({{position.x-radius, position.y-radius}, {position.x + radius,  position.y + radius}})
	local minRad = 20
	local nearestEntity = nil
	local mustBeAdded = false
	for i, entity in pairs(entities) do
		local mustBeAdded = false
		local nextRad = lenght(position, entity.position)
		--printAll(i .. " " .. entity.name .. " " .. nextRad)
		if not (minRad) then 
			mustBeAdded = true 
			minRad = nextRad 
		end
		if (minRad > nextRad) then mustBeAdded = true end
		if (entity.name == "tree-brush") or (entity.type == "player") then mustBeAdded = false end
		if (entity.force.name == "neutral") or (entity.force.name == "enemy") then mustBeAdded = false end
		if  mustBeAdded  then 
			minRad = nextRad 
			nearestEntity = entity
		end
	end
	if nearestEntity then printAll(nearestEntity.name .. " " .. minRad) end
	return nearestEntity
end

function lenght(position1, position2)
	local position1 = {x = position1.x, y = position1.y} or {x = 0, y = 0}
	local position2 = {x = position2.x, y = position2.y} or {x = 0, y = 0}
	
	return math.sqrt((position1.x - position2.x)^2 + (position1.y - position2.y)^2)
end

function directionToPosition(position, direction, radius)
	-- makes position from direction, absolute or relative
	local x = position.x or 0
	local y = position.y or 0
	local radius = radius or 5
	if 		direction == 0 then return {	x=x, 	y=y-radius}
	elseif 	direction == 2 then return {	x=x+radius, 	y=y}
	elseif 	direction == 4 then return {	x=x, 	y=y+radius}
	elseif 	direction == 6 then return {	x=x-radius, 	y=y}
	else return {x=x, y=y} 
	end
end