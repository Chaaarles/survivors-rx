local Config = {
  window = {
    width  = 800,
    height = 600,
    title  = "SurvivorsRX",
  },

  player = {
    radius       = 24,
    speed        = 400,
    acceleration = 6000,
    friction     = 8,
  },

  gun = {
    cooldownTime = 0.33,
  },

  bullet = {
    radius = 10,
    speed  = 400,
    life   = 1,
  },

  enemy = {
    radius        = 16,
    speed         = 200,
    acceleration  = 800,
    friction      = 5,
    health        = 3,
    spawnInterval = 2.5,
    spawnCount    = 2,
  },
}

return Config
