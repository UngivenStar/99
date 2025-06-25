extends Area2D
 
enum type_plat {FIJA, OSCILATORIA, FRAGIL, REBOTE, PINCHOS}
@export var type: type_plat = type_plat.FIJA;
@export var rebote := 2.0 

func _ready():
	act_plat()
	monitorable = true
	monitoring = true
	

func act_plat():
	match type:
		type_plat.FIJA:
			$Sprite2D.modulate = Color.DARK_TURQUOISE
		type_plat.OSCILATORIA:
			$Sprite2D.modulate = Color.CHARTREUSE
			oscilar()
		type_plat.FRAGIL:
			$Sprite2D.modulate = Color.CORNFLOWER_BLUE
			
		type_plat.REBOTE:
			$Sprite2D.modulate = Color.DEEP_PINK
			
		type_plat.PINCHOS:
			$Sprite2D.modulate = Color.MEDIUM_SPRING_GREEN
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		match type:
			type_plat.FRAGIL:
					await get_tree().create_timer(0.25).timeout
					queue_free()
			type_plat.REBOTE:
				if body.has_method("puede_rebotar"):
					body.puede_rebotar(rebote)
				else:
					body.velocity.y = body.brinco * rebote
			type_plat.PINCHOS:
					


func oscilar():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x+100, 2)
	tween.tween_property(self, "position:x", position.x-100, 2)
	tween.set_loops()
