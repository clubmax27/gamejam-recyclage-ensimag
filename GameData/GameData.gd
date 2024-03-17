extends Node

var wave_data = [
	[{
		"enemy_type": "Goblin",
		"quantity": 2,
		"delay": 0.3
	},
	{
		"enemy_type": "Goblin",
		"quantity": 3,
		"delay": 0.7
	}],
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.3
	}]
]

var enemy_data = {
	"Goblin" : {
		"hp": 5,
		"speed": 150,
		"gold": 10
	}
}

var tower_data = {
	"Turret_Bow_1" : {
		"damage": 20,
		"rof": 1,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true,
	},
	"Turret_Bow_2" : {
		"damage": 20,
		"rof": 1,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true
	},
	"Turret_Bow_3" : {
		"damage": 20,
		"rof": 1,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true
	},
	"Turret_Mage_1" : {
		"damage": 40,
		"rof": 2,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Mage_2" : {
		"damage": 40,
		"rof": 2,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Mage_3" : {
		"damage": 40,
		"rof": 2,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Recyclage_1" : {
		"range": 350,
		"ressource_multiplier": 1,
	},
	"Turret_Recyclage_2" : {
		"range": 350,
		"ressource_multiplier": 1,
	},
	"Turret_Recyclage_3" : {
		"range": 350,
		"ressource_multiplier": 1,
	}
}
