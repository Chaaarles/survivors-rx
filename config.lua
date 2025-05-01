local Config = {
  window = {
    width  = 800,
    height = 600,
    title  = "SurvivorsRX",
  },

  player = {
    radius       = 12,
    speed        = 300,
    acceleration = 200,
    friction     = 0.15,
    cooldownTime = 0.4,
  },

  gun = {
    cooldownTime = 0.33,
  },

  bullet = {
    radius = 5,
    speed  = 400,
    life   = 1,
  },

  enemy = {
    radius        = 8,
    speed         = 150,
    acceleration  = 20,
    friction      = 0.1,
    health        = 3,
    spawnInterval = 2.5,
    spawnCount    = 2,
  },
}

return Config
