extends RigidBody2D

var velocity

var Arena : Node2D
var SafeZone : Area2D

func _ready():
	Arena = get_node("../../Arena/")
	SafeZone = Arena.get_node("SafeZone")
	
	SafeZone.connect("PredatorChangingVector", self._SafeZoneImpact)
	
	velocity = Vector2(randi_range(-450, 450), randi_range(-450, 450))
	add_to_group("predator")
	set_linear_velocity(velocity)

func _on_body_entered(body):
	velocity = Vector2(randi_range(-450, 450), randi_range(-450, 450))
	set_linear_velocity(velocity)
	
func _SafeZoneImpact(predator):
	if(predator == self):
		velocity = -velocity
		self.set_linear_velocity(velocity)
