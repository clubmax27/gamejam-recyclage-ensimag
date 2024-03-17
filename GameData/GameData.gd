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
		"enemy_type": "Goblin",
		"quantity": 3,
		"delay": 0.7
	},
	{
		"enemy_type": "Goblin",
		"quantity": 4,
		"delay": 0.5
	},
	{
		"enemy_type": "Goblin",
		"quantity": 6,
		"delay": 0.1
	},
	{
		"enemy_type": "Goblin",
		"quantity": 1,
		"delay": 1
	},
	{
		"enemy_type": "Goblin",
		"quantity": 1,
		"delay": 1
	}],  ##### VAGUE 2  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.3
	},
	{
		"enemy_type": "Wolf",
		"quantity": 20,
		"delay": 0.5
	},
	{
		"enemy_type": "Goblin",
		"quantity": 7,
		"delay": 0.5
	},
	{
		"enemy_type": "Wolf",
		"quantity": 3,
		"delay": 0.5
	},
	],     ##### VAGUE 3  #####
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
	}],   ##### VAGUE 4  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.3
	},
	{
		"enemy_type": "Small Blob",
		"quantity": 50,
		"delay": 0.1
	},
	{
		"enemy_type": "Wolf",
		"quantity": 10,
		"delay": 0.5
	}],  ##### VAGUE 5  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 10,
		"delay": 0.2
	},
	{
		"enemy_type": "Wolf",
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
	},
	{
		"enemy_type": "Golem",
		"quantity": 2,
		"delay": 2
	}
	],   ##### VAGUE 6  #####
	[{
		"enemy_type": "Goblin",
		"quantity": 5,
		"delay": 0.15
	},
	{
		"enemy_type": "Big Blob",
		"quantity": 25,
		"delay": 0.2
	},
	{
		"enemy_type": "Goblin",
		"quantity": 25,
		"delay": 0.5
	},
	{
		"enemy_type": "Wolf",
		"quantity": 20,
		"delay": 0.3
	},{
		"enemy_type": "Goblin",
		"quantity": 25,
		"delay": 0.5
	}
	],[  ##### VAGUE 7  #####
	{
		"enemy_type": "Small Blob",
		"quantity": 50,
		"delay": 0.2
	},
	{
		"enemy_type": "Bee",
		"quantity": 50,
		"delay": 0.3
	},
	{
		"enemy_type": "Small Blob",
		"quantity": 100,
		"delay": 0.3
	},
	],[     #### VAGUE 8 #####
	{
		"enemy_type": "Golem",
		"quantity": 3,
		"delay": 6
	},
	{
		"enemy_type": "Goblin",
		"quantity": 20,
		"delay": 0.5
	},
	{
		"enemy_type": "Wolf",
		"quantity": 5,
		"delay": 2
	},
	],[  #### VAGUE 9 #####
	{
		"enemy_type": "Small Blob",
		"quantity": 50,
		"delay": 0.3
	},	
	{
		"enemy_type": "Bee",
		"quantity": 5,
		"delay": 0.2
	},
	{
		"enemy_type": "Goblin",
		"quantity": 50,
		"delay": 0.3
	},
	{
		"enemy_type": "Wolf",
		"quantity": 100,
		"delay": 0.2
	}
	],[  #### VAGUE 10 #####
	{
		"enemy_type": "Wolf",
		"quantity": 50,
		"delay": 0.2
	},
	{
		"enemy_type": "Golem",
		"quantity": 1,
		"delay": 5
	},
	{
		"enemy_type": "Bee",
		"quantity": 30,
		"delay": 0.2
	},
	{
		"enemy_type": "Golem",
		"quantity": 2,
		"delay": 2
	},
	{
		"enemy_type": "Goblin",
		"quantity": 2,
		"delay": 10
	},
	{
		"enemy_type": "Golem",
		"quantity": 4,
		"delay": 3
	},	
	{
		"enemy_type": "Golem",
		"quantity": 1,
		"delay": 10
	},
	{
		"enemy_type": "Minotaur",
		"quantity": 1,
		"delay": 3
	},
	] 
]

var enemy_data = {
	"Goblin" : {
		"hp": 30,
		"speed": 50,
		"damage": 10,
		"gold": 10
	},
	"Wolf" : {
		"hp": 20,
		"speed": 150,
		"damage": 5,
		"gold": 10
	},
	"Small Blob" : {
		"hp": 50,
		"speed": 40,
		"damage": 5,
		"gold": 2
	},
	"Big Blob" : {
		"hp": 10,
		"speed": 75,
		"damage": 5,
		"gold": 5
	},
	"Bee" : {
		"hp": 10,
		"speed": 200,
		"damage": 5,
		"gold": 3
	},
	"Golem" : {
		"hp": 3000,
		"speed": 40,
		"damage": 20,
		"gold": 100
	},
		"Minotaur" : {
		"hp": 6000,
		"speed": 120,
		"damage": 30,
		"gold": 1000
	}
}



var tower_data = {
	"Turret_Bow_1" : {
		"price": 100,
		"damage": 15,
		"rof": 0.75,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true,
	},
	"Turret_Bow_2" : {
		"price": 100,
		"damage": 20,
		"rof": 0.65,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": true
	},
	"Turret_Bow_3" : {
		"price": 100,
		"damage": 20,
		"rof": 0.5,
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
		"damage": 100,
		"rof": 3,
		"range": 350,
		"fire_delay": 0.1,
		"has_projectile": false
	},
	"Turret_Mage_3" : {
		"price": 100,
		"damage": 40,
		"rof": 3,
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
	},
	"Turret_Upgrade_Arc_1" : {
		"price": 500,
		"damage": 30,
		"rof": 0.5,
		"range": 600,
		"fire_delay": 0.1,
		"has_projectile": true,
	},
		"Turret_Upgrade_Mage_1" : {
		"price": 60,
		"damage": 200,
		"rof": 5,
		"range": 200,
		"fire_delay": 0.1,
		"has_projectile": true
	},
}
