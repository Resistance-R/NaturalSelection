extends Area2D

signal PredatorChangingVector
signal PreyChangingVector

func _ready():
	add_to_group("safe_zone")


func _process(delta):
	pass

func _on_body_entered(body):
	if(body.is_in_group("predator")):	
		emit_signal("PredatorChangingVector", body)
	


func _on_body_exited(body):
	if(body.is_in_group("prey")):	
		emit_signal("PreyChangingVector", body)
