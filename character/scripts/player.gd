extends CharacterBody2D

@export var move_speed: float = 150.0
@export var acceleration: float = 0.2
@export var friction: float = 0.2



var last_direction: String = "down"
var is_moving: bool = false

func _ready() -> void:
	# Lista todas as animações para debug
	print("=== ANIMAÇÕES ENCONTRADAS ===")
	for anim in $AnimationPlayer.get_animation_list():
		print("-> ", anim)

func _physics_process(delta: float) -> void:
	var direction_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	# Movimento
	if direction_input != Vector2.ZERO:
		is_moving = true
		velocity = velocity.lerp(direction_input * move_speed, acceleration)
		
		# Determina direção (prioriza eixo com maior intensidade)
		var direction_name = ""
		if abs(direction_input.x) > abs(direction_input.y):
			# Movimento horizontal
			direction_name = "right" if direction_input.x > 0 else "left"
		else:
			# Movimento vertical
			direction_name = "down" if direction_input.y > 0 else "up"
		
		last_direction = direction_name
		
		# Toca animação de walk
		var anim_name = "walk_" + direction_name
		if $AnimationPlayer.has_animation(anim_name):
			print(anim_name)
			$AnimationPlayer.play_backwards(anim_name)
		else:
			print("Animação não encontrada: ", anim_name)
			
	else:
		is_moving = false
		velocity = velocity.lerp(Vector2.ZERO, friction)
		
		# Toca animação de idle
		var anim_name = "idle_" + last_direction
		if  $AnimationPlayer.has_animation(anim_name):
			$AnimationPlayer.play(anim_name)
	
	move_and_slide()
