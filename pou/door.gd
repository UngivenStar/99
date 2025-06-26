extends Node2D


@export var next_scene_path : String

	
func _ready():
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("has_key") and body.has_key:
		unlock_and_go()

func unlock_and_go():
	get_tree().change_scene_to_file("")
