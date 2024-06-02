extends RigidBody2D

@export var velocity = Vector2(randf_range(-10, 10), randf_range(-10, 10))

func _ready():
	add_to_group("predator")

func _process(delta):
	move_and_collide(velocity)
	
