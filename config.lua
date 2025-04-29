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

  bullet = {
    radius = 4,
    speed  = 300,
    life   = 1,
  },

  enemy = {
    radius        = 8,
    speed         = 50,
    health        = 5,
    spawnInterval = 1.5,
    spawnCount    = 5,
  },
}

return Config
