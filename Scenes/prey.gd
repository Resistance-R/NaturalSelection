extends RigidBody2D

var velocity

func _ready():
	velocity = Vector2(randf_range(-5, 5), randf_range(-5, 5))
	add_to_group("prey")

func _physics_process(delta):
	move_and_collide(velocity)

func _on_body_entered(body):
	velocity = Vector2(randf_range(-5, 5), randf_range(-5, 5))
