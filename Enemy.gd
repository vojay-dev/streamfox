extends KinematicBody

var velocity = Vector3(0, 0, rand_range(40, 100))
var r = Vector3(rand_range(0, 10), rand_range(0, 10), rand_range(0, 10))
var exploded = false

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	rotation_degrees += r
	if transform.origin.z > 100:
		queue_free()

func explode():
	if not exploded:
		remove_child($CollisionShape)

		$Explosion.play()
		$Model.visible = false
		$Particles.emitting = true
		exploded = true

		var remove_timer = Timer.new()
		remove_timer.wait_time = 4
		remove_timer.one_shot = true

		remove_timer.connect("timeout", self, "_remove")
		remove_timer.start()

func _remove():
	queue_free()
