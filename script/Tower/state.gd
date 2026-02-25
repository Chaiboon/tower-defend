extends Node
class_name State

signal Transitioned(current_state:State,next_state:String,enemy:Enemy)
var target_enemy:CharacterBody2D

func enter(enemy):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
