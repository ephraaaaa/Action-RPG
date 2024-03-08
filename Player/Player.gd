extends CharacterBody2D

var character_velocity = Vector2.ZERO
var character_speed = 100
var character_acceleration = 50
var character_friction = 500
var character_roll_vector
var roll_speed = 100
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree

enum {
	MOVE,
	ATTACK,
	ROLL,
}

var state = MOVE

@onready var animation_state = animation_tree.get("parameters/playback")
func _physics_process(delta):
	match state:
		MOVE:
			move_character(delta)
		ATTACK:
			attack_state(delta)
		ROLL:
			roll_state(delta)





func move_character(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	input_vector = input_vector.normalized()	

	if input_vector != Vector2.ZERO:
		character_roll_vector = input_vector
		animation_tree.set("parameters/idle_character/blend_position", input_vector)
		animation_tree.set("parameters/moving_character/blend_position", input_vector)
		animation_tree.set("parameters/attack/blend_position", input_vector)
		animation_tree.set("parameters/roll_character/blend_position", input_vector)
		animation_state.travel("moving_character")

		character_velocity = character_velocity.move_toward((input_vector*character_speed), (character_speed))
	
	else:  
		animation_state.travel("idle_character")
		#animation_player.play("idle_right")
		character_velocity = character_velocity.move_toward(Vector2.ZERO, (character_friction * delta))
	
	move(delta)

	
	if Input.is_action_just_pressed("attack"):
		state=ATTACK
	elif Input.is_action_just_pressed("roll"):
		state=ROLL

func move(delta):
	move_and_collide(character_velocity*delta)

func roll_state(delta):
	character_velocity = character_roll_vector * roll_speed
	animation_state.travel("roll_character")
	move(delta)
	
	
func attack_state(delta):
	character_velocity = Vector2.ZERO * delta
	animation_state.travel("attack")
	
func attack_finished():
	state = MOVE
func roll_finished():
	state = MOVE
