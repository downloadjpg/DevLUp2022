class_name Bug
extends KinematicBody2D

# General class for enemy movement and attack(s). Overriden by individual enemies.

signal died

export(int) var move_speed = 20
export(int) var health = 5 setget set_health
export(Script) var defaultBrain
export(Script) var playerBrain

var explosionDeathScene = preload("res://components/ExplosionDeath.tscn")

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
var look_at = Vector2.RIGHT


func set_health(value):
	health = value
	if health <= 0:
		die()

func _ready():
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")

func activate_as_ai():
	var brain = Node.new()
	brain.set_script(defaultBrain)
	add_child(brain)
	add_to_group("Enemies")
	$BugSelector.queue_free()
	$AnimationPlayer.play("walk")

func activate_as_player():
	var brain = Node.new()
	brain.set_script(playerBrain)
	add_child(brain)
	add_to_group("Player")
	$AnimationPlayer.play("walk")
	


func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)
	if sign(velocity.x) != 0:
		$Sprite.scale.x = sign(velocity.x)

func hit(damage):
	set_health(health - damage)
	$DamageFlashPlayer.play("damage_flash")
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	camera.small_shake()
	

#func damage_flash():
#	var tween = Tween.new()
#	tween.interpolate_property(get_node("Sprite"), "modulate", Color(1,0.5,0.5,1), Color(1,1,1,1),  0.5)
#	tween.start()

func die():
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	camera.medium_shake()
	
	var explosion = explosionDeathScene.instance()
	get_tree().get_root().get_child(0).add_child(explosion)
	explosion.global_position = global_position
	
	emit_signal("died")
	queue_free()

func set_input_vector(vec: Vector2) -> void:
	input_vector = vec

func set_look_at(vec: Vector2) -> void:
	look_at = vec.normalized()

func action() -> void:
	pass