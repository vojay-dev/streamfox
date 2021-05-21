extends Spatial

var enemy = preload("res://Enemy.tscn")

func spawn():
	var enemy_instance = enemy.instance()
	get_parent().add_child(enemy_instance)
	
	enemy_instance.transform.origin = transform.origin + Vector3(
		rand_range(-20, 20),
		rand_range(-15, 15),
		0
	)

func _on_Timer_timeout():
	spawn()
