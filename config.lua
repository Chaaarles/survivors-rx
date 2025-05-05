local Config = {
  window = {
    width  = 640,
    height = 360,
    title  = "SurvivorsRX",
  },

  player = {
    radius       = 8,
    speed        = 200,
    acceleration = 6000,
    friction     = 8,
  },

  gun = {
    cooldownTime = 0.33,
  },

  bullet = {
    radius = 4,
    speed  = 400,
    life   = 1,
  },

  enemy = {
    radius        = 8,
    speed         = 180,
    acceleration  = 800,
    friction      = 5,
    health        = 3,
    spawnInterval = 2.5,
    spawnCount    = 2,
  },

  combat = {
    knockback = 300,
  }
}

return Config
