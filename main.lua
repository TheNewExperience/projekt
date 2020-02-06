local name = require "game"
function love.load()


  love.window.setPosition(500, 50, 1)
  interval = 20
  add_bonus()

end

function love.draw()
  game_draw()
  if state  == States.game_over then
    love.graphics.print("Koniec Gry", 330, 350, 0, 4 ,4, 0, 0, 0, 0)
    love.graphics.print("Naciśnij Space aby zrestartować", 270, 450, 0, 3 ,3, 0, 0, 0, 0)
    end

end

function love.update()
  if state == States.running then

  interval = interval - 1
    if interval < 0 then
      game_update()
      if snake_tail_length <= 5 then
        interval = 20
      elseif snake_tail_length > 5 and snake_tail_length <= 10 then
        interval = 15
      elseif snake_tail_length >10 and snake_tail_length <= 15 then
        interval = 10
      elseif snake_tail_length > 15 then
        interval = 5
      end
    end
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'left' and state == States.running then
    left, right, up, down = true, false, false, false
  elseif key == 'up' and state == States.running then
    left, right, up, down = false, false, true, false
  elseif key == 'down' and state == States.running then
    left, right, up, down = false, false, false, true
  elseif key == 'right' and state == States.running then
    left, right, up, down = false, true, false, false
  elseif key == 'space' and state == States.game_over then
    game_restart()
  elseif key == 'p' then
    if state == States.running then
      state = States.pause
    else
      state = States.running
    end
  end
end
