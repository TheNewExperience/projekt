States = {pause = 'pause', running = 'running', gmae_over = 'game_over'}
state = States.running
local snakeXPos = 15
local snakeYPos = 15
local size = 30

local directionX  = 0
local directionY = 0

up = false
down = false
left = false
right = false

local bonusX = 0
local bonusY = 0

snake_tail_length = 0

local tail = {}

function add_bonus()
math.randomseed((os.time()))
bonusX = math.random(size - 1)
bonusY = math.random(size -1)
end

function game_draw()
  love.graphics.setColor(1.0, 0.35, 0.4, 1.0)
  love.graphics.rectangle('fill', snakeXPos*30, snakeYPos*30, size, size,10,10)

  love.graphics.setColor(0.7, 0.35, 0.4, 1.0)

  for _, v in ipairs(tail) do
    love.graphics.rectangle('fill', size * v[1], v[2]*size, size, size, 15, 15)
  end

  love.graphics.setColor(0.7, 0.8, 0.0, 1.0)
  love.graphics.rectangle('fill', bonusX*size, bonusY*size, size, size, 10, 10)

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Zebrane jabłka: ".. snake_tail_length, 10, 10, 0 , 1.5, 1.5, 0, 0 , 0 , 0)
end

function game_update()
  if up and directionY == 0 then
    directionX,directionY = 0, -1
  elseif down  and directionY == 0 then
    directionX,directionY = 0, 1
  elseif left and directionX == 0 then
    directionX,directionY = -1, 0
  elseif right and directionX == 0 then
    directionX, directionY = 1, 0
  end

  local oldXSposition = snakeXPos
  local oldYSposstion = snakeYPos


  snakeXPos = snakeXPos + directionX
  snakeYPos = snakeYPos + directionY



  if snakeXPos == bonusX and snakeYPos == bonusY then

    add_bonus()

    snake_tail_length = snake_tail_length + 1
    table.insert(tail,{0,0})
  end

  if snakeXPos < 0 then
    snakeXPos = size - 1
  elseif snakeXPos > size - 1 then
    snakeXPos = 0
  elseif snakeYPos < 0 then
    snakeYPos = size - 1
  elseif snakeYPos > size - 1 then
    snakeYPos = 0
  end

  if snake_tail_length > 0 then
    for _, v in ipairs(tail) do
      local x, y = v[1], v[2]
      v[1], v[2] = oldXSposition,oldYSposstion
      oldXSposition,oldYSposstion = x, y
    end
end

for _, v in ipairs(tail) do
  if snakeXPos == v[1] and snakeYPos == v[2] then
    state = States.game_over
  end
end


end

function game_restart ()

  snakeXPos, snakeYPos = 15,15
  directionX, directionY = 0, 0
  tail = {}
  snake_tail_length = 0
  left,right,up,down = false, false, false, false
  state = State.running
  add_bonus()


end
