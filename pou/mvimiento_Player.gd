extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

var jumps = 0

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D



func _ready():
	add_to_group("personaje")

func _physics_process(delta: float) -> void:
	# Agregar gravedad si no estamos en el suelo
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reiniciar los saltos al tocar el suelo
		jumps = 0

	# Manejo de salto (hasta dos saltos)
	if Input.is_action_just_pressed("ui_accept") and jumps < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumps += 1

	# Movimiento horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Animaciones
	animations(direction)

	# Flip del sprite
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true


func animations(direction):
	if is_on_floor():
		if direction == 0:
			animationPlayer.play("idle")
		else:
			animationPlayer.play("run")
	else:
		if velocity.y < 0:
			animationPlayer.play("jump")
		elif velocity.y > 0:
			animationPlayer.play("fall")





func _on_reser_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_reset_area_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()
	
