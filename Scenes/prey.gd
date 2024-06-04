extends RigidBody2D

var velocity

func _ready():
	velocity = Vector2(randi_range(-250, 250), randi_range(-250, 250))
	add_to_group("prey")
	set_linear_velocity(velocity)
	
	var preysNode = get_node("../")
	var prey = get_node(".")
	var anotherPrey = prey.duplicate()
	
	while true:
		await get_tree().create_timer(2.5).timeout
		preysNode.add_child(anotherPrey.duplicate())

func _on_body_entered(body):
	velocity = Vector2(randi_range(-250, 250), randi_range(-250, 250))
	set_linear_velocity(velocity)

	if body.is_in_group("predator"):
		queue_free()
