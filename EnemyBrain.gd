class_name EnemyBrain
extends Node

onready var body = get_child(0)

var time = 0
func _physics_process(delta):
	time += delta
	body.set_input_vector(Vector2(1, sin(time)).normalized())