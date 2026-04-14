extends CharacterBody2D

# Variáveis exportadas
@export var move_speed: float = 64.0
@export var acceleration: float = 0.2
@export var friction: float = 0.2

func _physics_process(delta: float) -> void:
	# Captura a direção do input do jogador
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Aplica aceleração ou fricção baseado no movimento
	if direction != Vector2.ZERO:
		# Personagem está se movendo - aplica aceleração
		velocity = velocity.lerp(direction * move_speed, acceleration)
	else:
		# Personagem está parado - aplica fricção
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	# Executa o movimento
	move_and_slide()