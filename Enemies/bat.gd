extends CharacterBody2D


var knockback = Vector2.ZERO


func _physics_process(delta):
	velocity = knockback.move_toward(knockback, delta)
	move_and_slide()

		
func _on_hurtbox_area_entered(area):
	print("1 hit")
	var direction = ( position - area.owner.position ).normalized()
	knockback = direction * 100
	#self.queue_free()

	
