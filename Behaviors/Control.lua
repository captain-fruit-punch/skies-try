require "ItemAttributes/Default"

Control = {}
Control.__index = Control

function Control.new(entity, speed)
  local o = {}
  o.type = "Control"
  o.isControl = true
  o.entity = entity
  o.speed = speed
  setmetatable(o, Control)
  return o
end

function Control:update(dt)
  local vx, vy = 0,0
  if love.keyboard.isDown("d", "right") then
    vx = (self.speed * dt)
  end
  if love.keyboard.isDown("a", "left") then
    vx = -(self.speed * dt)
  end
  if love.keyboard.isDown("w", "up") then
    vy = -(self.speed * dt)
  end
  if love.keyboard.isDown("s", "down") then
    vy = (self.speed * dt)
  end
  if(vx ~= 0 and vy ~= 0)then
    vx = vx / 1.414213562373095 -- square root of two
    vy = vy / 1.414213562373095
  end
  if(vx or vy)then
    self.entity.currently["Controlling"] = true
  end
  self.entity.x, self.entity.y = self.entity.world.world:move(self.entity, self.entity.x + vx, self.entity.y + vy, Default.filter)
end
