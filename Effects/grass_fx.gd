extends Node2D

@onready var grass_animated_sprite = $AnimatedSprite2D

func _ready():
	grass_animated_sprite.play("grass_destroy_animation")


func _on_animated_sprite_2d_animation_finished():
	self.queue_free()
