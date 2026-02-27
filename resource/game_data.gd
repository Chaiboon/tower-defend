extends Node

var player_health: int = 100
var player_money: int = 100

const ENEMY_DATA = {
	"Slime" : {
				"max_health":70,
				"speed":80.0,
				"gold_value":10,
	},
	"Slime_duplicate" : {
				"max_health":35,
				"speed":60.0,
				"gold_value":10,
	},
	"Orc" : {
				"max_health":60,
				"speed":40.0,
				"gold_value":25,
				"special" : {
					"attack":30
				}
	},
	"Wolf" : {
				"max_health":40,
				"speed":80.0,
				"gold_value":25,
				"special":{
					"attack":20
				}
	},
	"Bee" : {
				"max_health":30,
				"speed":100.0,
				"gold_value":10,
	},
}

const TOWER_DATA ={
	"archer_tower" : {	"purchasing_price":100,
						1 : {
						"max_health":100,
						"cool_down":1.0,
						"damage":5,
						"upgrade_cost":200,
						"selling_price":50},				
						2 : {
						"max_health":150,
						"cool_down":1.0,
						"damage":6,
						"upgrade_cost":250,
						"selling_price":150},
						3 : {
						"max_health":180,
						"cool_down":0.8,
						"damage":8,
						"upgrade_cost":300,
						"selling_price":275},
						4 : {
						"max_health":180,
						"cool_down":0.8,
						"damage":10,
						"upgrade_cost":350,
						"selling_price":450},
						5 : {
						"max_health":210,
						"cool_down":0.5,
						"damage":15,
						"upgrade_cost":400,
						"selling_price":650},
						6 : {
						"max_health":210,
						"cool_down":0.5,
						"damage":20,
						"upgrade_cost":450,
						"selling_price":875},
	}
}
