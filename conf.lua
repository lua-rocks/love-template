function love.conf(t)
  t.identity =        'love.template'
  t.version =                  '11.3'
  t.appendidentity =            false
  t.accelerometerjoystick =     false
  t.externalstorage =           false
  t.gammacorrect =              false
  t.console =                   false

  t.modules.thread =             true
  t.modules.event =              true
  t.modules.math =               true
  t.modules.system =             true
  t.modules.timer =              true

  t.modules.window =             true
  t.modules.graphics =           true
  t.modules.image =              true
  t.modules.keyboard =           true
  t.modules.mouse =              true

  t.modules.sound =             false
  t.modules.audio =             false
  t.modules.video =             false
  t.modules.physics =           false
  t.modules.joystick =          false
  t.modules.touch =             false

  t.window.title =      'Application'
  t.window.icon =                 nil
  t.window.width =                720
  t.window.height =               480
  t.window.minwidth =             240
  t.window.minheight =            160
  t.window.borderless =         false
  t.window.resizable =           true
  t.window.fullscreen =         false
  t.window.fullscreentype = 'desktop'
  t.window.vsync =                  0
  t.window.msaa =                   0
  t.window.display =                1
  t.window.highdpi =            false
  t.window.x =                    nil
  t.window.y =                    nil
end
