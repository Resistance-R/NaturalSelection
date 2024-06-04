extends RigidBody2D

var velocity

func _ready():
	velocity = Vector2(randi_range(-400, 400), randi_range(-400, 400))
	add_to_group("predator")
	set_linear_velocity(velocity)

func _on_body_entered(body):
	velocity = Vector2(randi_range(-400, 400), randi_range(-400, 400))
	set_linear_velocity(velocity)
