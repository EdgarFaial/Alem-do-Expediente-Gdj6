extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var inventario = player.get_node("Inventario")
@onready var label = $Label
@onready var sprite = $Sprite2D

var player_perto := false

func _ready():
	label.visible = false
	sprite.visible = false
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	inventario.inventario_atualizado.connect(_verificar_estado)
	_verificar_estado()


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_perto = true
		label.visible = true
		_verificar_estado()


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_perto = false
		label.visible = false
		sprite.visible = false


func _verificar_estado():
	if not player_perto:
		sprite.visible = false
		return

	# verifica se tem algum item com quantidade >= 2
	for item_id in inventario.itens:
		var qtd = inventario.itens[item_id]["quantidade"]
		
		if qtd >= 2:
			sprite.visible = true
			return

	sprite.visible = false
