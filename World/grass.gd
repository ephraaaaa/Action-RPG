extends Node2D

@export var grass_effect_scene: PackedScene
@onready var grass_effect = grass_effect_scene.instantiate()
@onready var world = get_tree().current_scene


func create_grass_effect():
	world.add_child(grass_effect)
	grass_effect.position = self.position


func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	self.queue_free()
