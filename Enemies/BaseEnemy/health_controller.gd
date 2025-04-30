extends Node3D

var value: int = 100

func addHealth(healValue: int) -> void:
	value += healValue

func loseHealth(damage: int) -> void:
	value -= damage
