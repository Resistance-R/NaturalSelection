extends RigidBody2D

var velocity

func _ready():
	velocity = Vector2(randi_range(-10, 10), randi_range(-10, 10))
	add_to_group("predator")

func _process(delta):
	move_and_collide(velocity)

func _on_body_entered(body):
	print("entered")
	velocity = Vector2(randi_range(-10, 10), randi_range(-10, 10))
	print("vetor changed")
