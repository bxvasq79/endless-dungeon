
local Map = require 'core/map'
local Util = require 'core/util'
local gamera = require 'core/gamera'
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
  cam = gamera.new(0, 0, 960, 625)
  weapon = love.graphics.newImage('assets-1/player/hand_right/long_sword_slant.png')
  shield = love.graphics.newImage('assets-1/player/hand_left/shield_goblin.png')
  playerImg = love.graphics.newImage('assets-1/monster/human.png')
  x = 100
  y = 250
  enemy = love.graphics.newImage('assets-1/monster/ironheart_preserver.png')
  x2 = 260
  y2 = 250
  enemy2 = love.graphics.newImage('assets-1/monster/ironbrand_convoker.png')
  c = 300
  d = 300
  enemy3 = love.graphics.newImage('assets-1/monster/ironbrand_convoker.png')
  e = 300
  f = 200
  questItem = love.graphics.newImage('assets-1/item/amulet/artefact/urand_vitality.png')
  g = 375
  b = 250
  tile = love.graphics.newImage('assets-1/dungeon/floor/sand_6.png')
  path = love.graphics.newImage('assets-1/dungeon/wall/lab-stone_0.png')
  w = 36   -- The player's width is 64
  h = 36   -- The player's height is 64
  hp = 100 -- Set the player's HP to 100 at the start of the game


  template = { --a 3 x 3 map with the altar texture in the middle
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
                 {tile, tile, tile, tile, path, tile, tile, tile, tile},
               }
  map = Map:new(template)


  wall = love.graphics.newImage('assets-1/dungeon/wall/shoals_wall_1.png')
  walls = {
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                  {wall, 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', 'nil', wall},
                }
    collision = Map:new(walls)

end




function love.update(dt)
  if x < 0 then
    x = 0
  end
  if y < 0 then
    y = 0
  end
  if x > 960 then
    x = 960
  end
  if y > 960 then
    y = 960
  end
  if love.keyboard.isDown('right') then
    if collision:cc(x + 1, y, 36, 36) == false then
     x = x + 1
   end
  end
  if love.keyboard.isDown('left') then
    if collision:cc(x - 1, y, 36, 36) == false then
     x = x - 1
   end
  end
  if love.keyboard.isDown('down') then
    if collision:cc(x, y + 1, 36, 36) == false then
     y = y + 1
   end
  end
  if love.keyboard.isDown('up') then
    if collision:cc(x, y - 1, 36, 36) == false then
     y = y - 1
   end
  end

  cam:setPosition(x, y)
  -- x, y, w, h all represent the player's rectangle. The other values are a rectangle in the upper corner
  if cc(x, y, w, h,   x2, y2, 36, 36) then
    -- if true, decrease HP:
    hp = hp - 25
    x2 = x2 + 25
  end
  if cc(x, y, w, h,   c, d, 36, 36) then
    -- if true, decrease HP:
    hp = hp - 25
  end
  if cc(x, y, w, h,   e, f, 36, 36) then
    -- if true, decrease HP:
    hp = hp - 25
  end
end





function love.draw()
  cam:draw(function(l, t, w, h)
  map:draw()
  collision:draw()
  love.graphics.draw(weapon, x, y)
  love.graphics.draw(playerImg, x, y)
  love.graphics.draw(shield, x + 2, y)
  love.graphics.draw(enemy, x2, y2)
  love.graphics.draw(enemy2, c, d)
  love.graphics.draw(enemy3, e, f)
  love.graphics.draw(questItem, g, b)
  if hp < 0 then
    love.graphics.print('GAME OVER', x + 50, y + -50)
  end
  -- Print the player's HP in the top left corner
  love.graphics.print(hp, x, y + -18)
    --Draw everything here. For example:
  end)
end
