extends Area2D

@export var item: ItemBase
@export var quantidade: int = 1

func _ready():
	if item == null:
		print("⚠️ Coletável sem item! Criando item de emergência...")
		item = ItemBase.new()
		item.id = "item_emergencia"
		item.nome = "Item de Emergência"
		item.tipo = "coletavel"
	
	
	
	# Configura o collision layer para detectar o player
	collision_layer = 1
	collision_mask = 1		

func _on_body_entered(player):
	print("🎁 Coletando item: ", item.nome, " x", quantidade)
	
	# Verifica se o player tem inventário
	if player.has_node("Inventario"):
		var inventario = player.get_node("Inventario")
		if inventario.adicionar_item(item, quantidade):
			print("✅ Coletou: ", item.nome, " x", quantidade)
			queue_free()  # Remove o item do chão
		else:
			print("❌ Falha ao coletar ", item.nome)
	else:
		print("❌ Player não tem inventário!")
