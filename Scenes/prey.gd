extends RigidBody2D

var velocity

var Arena : Node2D
var Outside : Area2D
var SafeZone : Area2D

var original_size = Vector2(self.global_scale.x, self.global_scale.y)
var changedXY = original_size - Vector2(randf_range(-0.5, 0.5), randf_range(-0.5, 0.5))

func _ready():
	Arena = get_node("../../Arena/")
	SafeZone = Arena.get_node("SafeZone")
	Outside = Arena.get_node("Outside")

	SafeZone.connect("PreyChangingVector", self._VectorChanged)
	Outside.connect("DeletPrey", self._DeletingPrey)

	velocity = Vector2(randi_range(-250, 250), randi_range(-250, 250))
	add_to_group("prey")
	set_linear_velocity(velocity)
	
	while true:
		var preysNode = get_node("../")
		var prey = get_node(".")
		var anotherPrey = prey.duplicate()
		
		await get_tree().create_timer(2.0).timeout
		
		anotherPrey.global_scale = changedXY
		
		preysNode.add_child(anotherPrey)

func _on_body_entered(body):
	velocity = Vector2(randi_range(-250, 250), randi_range(-250, 250))
	set_linear_velocity(velocity)

	if body.is_in_group("predator"):
		self.queue_free()
		
func _DeletingPrey(prey):
	if(prey == self):
		self.queue_free()
		
func _VectorChanged(prey):
	if(prey == self):
		velocity = -velocity
		self.set_linear_velocity(velocity)
