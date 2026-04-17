extends Sprite2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var inventario = player.get_node("Inventario")

func _ready():
	visible = false
	
	inventario.inventario_atualizado.connect(_verificar_itens)
	_verificar_itens()


func _verificar_itens():
	for item_id in inventario.itens:
		var qtd = inventario.itens[item_id]["quantidade"]
		
		if qtd >= 2:
			visible = true
			return
	
	visible = false
