extends Node

var player_hp = 100
var player_gold = 500

var wave_data = [   ##### VAGUE 1  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 2,
		"delay": 0.3
	},
	{
		"enemy_type": "Wolf",
		"quantity": 3,
		"delay": 0.7
	},
	{
		"enemy_type": "Goblin",
		"quantity": 7,
		"delay": 1
	}],     ##### VAGUE 2  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.5
	},
	{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.3
	},
	{
		"enemy_type": "Goblin",
		"quantity": 20,
		"delay": 0.6
	},
	{
		"enemy_type": "Wolf",
		"quantity": 5,
		"delay": 0.6
	}],   ##### VAGUE 3  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.3
	},
	{
		"enemy_type": "Blob",
		"quantity": 50,
		"delay": 0.1
	},
	{
		"enemy_type": "Wolf",
		"quantity": 10,
		"delay": 1
	}],  ##### VAGUE 4  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.1
	},
	{
		"enemy_type": "wolf",
		"quantity": 10,
		"delay": 0.2
	},
	{
		"enemy_type": "Goblin",
		"quantity": 15,
		"delay": 0.5
	},
	{
		"enemy_type": "Wolf",
		"quantity": 10,
		"delay": 0.3
	}],   ##### VAGUE 5  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 5,
		"delay": 0.1
	},
	{
		"enemy_type": "Golem",
		"quantity": 2,
		"delay": 0.1
	},
	{
		"enemy_type": "Goblin",
		"quantity": 5,
		"delay": 0.1
	},
	{
		"enemy_type": "Wolf",
		"quantity": 20,
		"delay": 0.3
	}
	]
]

var enemy_data = {
	"Goblin" : {
		"hp": 30,
		"speed": 75,
		"damage": 10,
		"gold": 10
	},
	"Wolf" : {
		"hp": 20,
		"speed": 150,
		"damage": 5,
		"gold": 10
	},
	"Blob" : {
		"hp": 10,
		"speed": 20,
		"damage": 5,
		"gold": 5
	},
	"Big Blob" : {
		"hp": 10,
		"speed": 100,
		"damage": 5,
		"gold": 5
	},
	"Golem" : {
		"hp": 300,
		"speed": 20,
		"damage": 20,
		"gold": 50
	},
	"phelma" : {
		"hp": 100,
		"speed": 40,
		"damage": 15,
		"gold": 50
	}
}



var tower_data = {
	"Turret_Bow_1" : {
		"price": 100,
		"damage": 20,
		"rof": 1,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true,
	},
	"Turret_Bow_2" : {
		"price": 100,
		"damage": 20,
		"rof": 1,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true
	},
	"Turret_Bow_3" : {
		"price": 100,
		"damage": 20,
		"rof": 1,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true
	},
	"Turret_Mage_1" : {
		"price": 150,
		"damage": 40,
		"rof": 2,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Mage_2" : {
		"price": 100,
		"damage": 40,
		"rof": 2,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Mage_3" : {
		"price": 100,
		"damage": 40,
		"rof": 2,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Recyclage_1" : {
		"price": 70,
		"range": 350,
		"ressource_multiplier": 1,
	},
	"Turret_Recyclage_2" : {
		"price": 70,
		"range": 350,
		"ressource_multiplier": 1,
	},
	"Turret_Recyclage_3" : {
		"price": 70,
		"range": 350,
		"ressource_multiplier": 1,
	}
}
