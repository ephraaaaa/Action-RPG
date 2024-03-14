extends CharacterBody2D


var knockback = Vector2.ZERO
var knockback_speed = 100

func _physics_process(delta):
	velocity = knockback.move_toward(knockback, delta)
	move_and_slide()

		
func _on_hurtbox_area_entered(area):
	print("1 hit")
	var direction = ( position - area.owner.position ).normalized()
	knockback = direction * 250
	await get_tree().create_timer(.15).timeout
	knockback = Vector2.ZERO
	move_and_slide()
	self.queue_free()
