extends KinematicBody

const SPEED = 40
const ACCELERATION = 0.9

var laser = preload("res://Laser.tscn")

var velocity = Vector3()
var input = Vector3()

var cooldown_init = 0.2
var cooldown = cooldown_init

func _physics_process(delta):
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("up") - Input.get_action_strength("down")

	input = input.normalized()

	velocity.x = move_toward(velocity.x, input.x * SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, input.y * SPEED, ACCELERATION)

	rotation_degrees.z = -velocity.x * 1.5
	rotation_degrees.x = velocity.y / 2

	velocity = move_and_slide(velocity)

	transform.origin.x = clamp(transform.origin.x, -18, 18)
	transform.origin.y = clamp(transform.origin.y, -10, 10)

	cooldown -= delta
	if Input.is_action_pressed("shoot") and cooldown <= 0:
		$Pew.play()
		for l in [$LaserLeft, $LaserRight]:
			var laser_instance = laser.instance()
			get_parent().add_child(laser_instance)

			laser_instance.transform = l.global_transform
			laser_instance.velocity.z = -300
			cooldown = cooldown_init

func _on_Hitbox_body_entered(body):
	if body.is_in_group("enemy"):
		get_tree().reload_current_scene()
