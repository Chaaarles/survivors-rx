local Config = {
  window = {
    width  = 800,
    height = 600,
    title  = "SurvivorsRX",
  },

  player = {
    radius       = 24,
    speed        = 300,
    acceleration = 200,
    friction     = 0.15,
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
    speed         = 150,
    acceleration  = 20,
    friction      = 0.1,
    health        = 3,
    spawnInterval = 2.5,
    spawnCount    = 2,
  },
}

return Config
