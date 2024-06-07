extends RigidBody2D

var velocity

var Arena : Node2D
var Outside : Area2D
var SafeZone : Area2D

func _ready():
	Arena = get_node("../../Arena/")
	SafeZone = Arena.get_node("SafeZone")
	Outside = Arena.get_node("Outside")
	
	var preysNode = get_node("../")
	var prey = get_node("./")
	var prey_sprite = get_node("./Sprite2D")
	var prey_collision = get_node("./CollisionShape2D")
	
	var changedXY = Vector2(randf_range(-15, 10), randf_range(-15, 10))
	
	var original_sprite_size = Vector2(prey_sprite.global_transform.get_scale().x, prey_sprite.global_transform.get_scale().y)
	var original_collision_size = Vector2(prey_collision.global_transform.get_scale().x, prey_collision.global_transform.get_scale().y)
	var sprite_changedXY = original_sprite_size + changedXY
	var collision_changedXY = original_collision_size + changedXY

	SafeZone.connect("PreyChangingVector", self._VectorChanged)
	Outside.connect("DeletPrey", self._DeletingPrey)

	velocity = Vector2(randi_range(-250, 250), randi_range(-250, 250))
	
	prey_sprite.global_scale = original_sprite_size
	prey_collision.global_scale = original_collision_size
	
	add_to_group("prey")
	set_linear_velocity(velocity)
	
	while true:
		await get_tree().create_timer(2.0).timeout

		var anotherPrey = prey.duplicate()
		remove_all_children(anotherPrey)
		
		var anotherPrey_sprite = prey_sprite.duplicate()
		var anotherPrey_collision = prey_collision.duplicate()
		
		anotherPrey_sprite.global_scale = sprite_changedXY
		anotherPrey_collision.global_scale = collision_changedXY
		
		anotherPrey.add_child(anotherPrey_sprite)
		anotherPrey.add_child(anotherPrey_collision)
		
		preysNode.add_child(anotherPrey)

func _on_body_entered(body):
	velocity = Vector2(randi_range(-250, 250), randi_range(-250, 250))
	set_linear_velocity(velocity)

	if body.is_in_group("predator"):
		self.queue_free()
		
func _DeletingPrey(prey):
	if prey == self:
		self.queue_free()
		
func _VectorChanged(prey):
	if prey == self:
		velocity = -velocity
		self.set_linear_velocity(velocity)

func remove_all_children(node: Node):
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()
