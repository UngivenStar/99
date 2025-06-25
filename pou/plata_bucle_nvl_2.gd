extends AnimatableBody2D


func _process(delta: float) -> void:
	global_position = get_parent().global_position
	
	


func _on_reset_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
