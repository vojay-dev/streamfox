extends KinematicBody

var velocity = Vector3.ZERO

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	if transform.origin.z < -200:
		queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("enemy"):
		body.explode()
		queue_free()
