extends RigidBody2D

var velocity

func _ready():
	velocity = Vector2(randi_range(-5, 5), randi_range(-5, 5))
	add_to_group("prey")

func _physics_process(delta):
	move_and_collide(velocity)

func _on_body_entered(body):
	print("entered")
	velocity = Vector2(randi_range(-5, 5), randi_range(-5, 5))
	print("vetor changed")

	if(body.is_in_group("predator")):
		queue_free()
