extends CharacterBody2D

@export var move_speed: float = 225.0
@export var acceleration: float = 0.2
@export var friction: float = 0.2

var last_direction: String = "down"
var is_moving: bool = false

# Referências para os sistemas
@onready var inventario: Inventario = $Inventario
@onready var crafting: Crafting = $Crafting
var ferramenta_ativa: String = ""

func _ready() -> void:
	# Seu código existente
	var animated_sprite = $AnimatedSprite2D
	
	print("=== ANIMAÇÕES ENCONTRADAS ===")
	if animated_sprite.sprite_frames:
		for anim in animated_sprite.sprite_frames.get_animation_names():
			print("-> ", anim)
	else:
		print("Nenhum SpriteFrames encontrado!")
	
	# Se o inventário não existir, cria (fallback)
	if not inventario:
		inventario = Inventario.new()
		add_child(inventario)
		print("Inventário criado automaticamente")

func _physics_process(delta: float) -> void:
	# Seu código de movimento existente (sem alterações)
	var direction_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if direction_input != Vector2.ZERO:
		is_moving = true
		velocity = velocity.lerp(direction_input * move_speed, acceleration)
		
		var direction_name = ""
		if abs(direction_input.x) > abs(direction_input.y):
			direction_name = "right" if direction_input.x > 0 else "left"
		else:
			direction_name = "down" if direction_input.y > 0 else "up"
		
		last_direction = direction_name
		
		var anim_name = "walk_" + direction_name
		if $AnimatedSprite2D.sprite_frames and $AnimatedSprite2D.sprite_frames.has_animation(anim_name):
			if $AnimatedSprite2D.animation != anim_name:
				$AnimatedSprite2D.play(anim_name)
		else:
			print("Animação não encontrada: ", anim_name)
	else:
		is_moving = false
		velocity = velocity.lerp(Vector2.ZERO, friction)
		
		var anim_name = "idle_" + last_direction
		if $AnimatedSprite2D.sprite_frames and $AnimatedSprite2D.sprite_frames.has_animation(anim_name):
			if $AnimatedSprite2D.animation != anim_name:
				$AnimatedSprite2D.play(anim_name)
	
	move_and_slide()
	
	# NOVO: Input para usar ferramenta
	if Input.is_action_just_pressed("usar_ferramenta"):
		usar_ferramenta_ativa()

# NOVOS MÉTODOS para o inventário
func usar_ferramenta_ativa():
	if ferramenta_ativa == "machado":
		var arvore = detectar_arvore()
		if arvore and arvore.has_method("cortar"):
			arvore.cortar(self)
	else:
		print("Nenhuma ferramenta equipada")

func detectar_arvore():
	# Precisa de um Area2D chamado "AreaDeteccao" no seu player
	if has_node("AreaDeteccao"):
		var area = $AreaDeteccao
		for body in area.get_overlapping_bodies():
			if body.has_method("cortar"):
				return body
	return null

func equipar_ferramenta(ferramenta: String):
	ferramenta_ativa = ferramenta
	print("Ferramenta equipada: ", ferramenta)


func _input(event):
	if event.is_action_pressed("ui_accept"):  # Tecla Enter/Space
		criar_item_teste_no_chao()

func criar_item_teste_no_chao():
	# Cria um item de teste na frente do player
	var coletavel = preload("res://coletavel.tscn").instantiate()
	
	# Cria o item na hora
	var novo_item = ItemBase.new()
	novo_item.id = "maca_teste"
	novo_item.nome = "Maçã Teste"
	novo_item.tipo = "consumivel"
	
	coletavel.item = novo_item
	coletavel.quantidade = 1
	coletavel.position = position + Vector2(50, 0)
	get_parent().add_child(coletavel)
	
	print("Item de teste criado na posição: ", coletavel.position)
func add_coletavel(coletavel):
	print("addicionando coletavel: ")
