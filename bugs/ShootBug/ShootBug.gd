extends Body

export var bullet_spawn_speed = 10
export var bullet_spawn_spread_degrees = 5

var bullet_scene = preload("res://bullets/Bullet.tscn")


func action():
	print("shootbot shoots!!")
	var bullet = bullet_scene.instance()
	get_tree().current_scene.add_child(bullet)
	bullet.velocity = look_at * bullet_spawn_speed
	bullet.velocity = bullet.velocity.rotated(deg2rad(bullet_spawn_spread_degrees))
	bullet.global_position = global_position

func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)