extends Spatial

func _on_StartDelay_timeout():
	$InterpolatedCamera.target = $Player/CameraPosition.get_path()
