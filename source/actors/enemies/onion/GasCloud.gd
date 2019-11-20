extends Area2D


func _ready():
	call_deferred("set_monitorable", false)
	set_physics_process(false)
	$LifeTime.start()


func _physics_process(delta):
#	slow_down()
	pass


func slow_down():
	translate(Vector2.ZERO)
	for body in get_overlapping_bodies():
		if not body.is_in_group("player"):
			continue
		if not body.has_method("set_velocity"):
			continue
		body.velocity.x *= 0.5


func _on_area_entered(area):
	$AnimationPlayer.play("damage")
#	set_physics_process(true)


func _on_area_exited(area):
	$AnimationPlayer.stop()
	$HitBox.disable()
#	set_physics_process(false)