extends Node
class_name Inventario

signal inventario_atualizado

var itens: Dictionary = {}

func adicionar_item(item: ItemBase, quantidade: int = 1) -> bool:
	print("📦 Adicionando item: ", item.nome, " x", quantidade)
	
	if item.id in itens:
		itens[item.id].quantidade += quantidade
		print("✅ Item existente. Nova quantidade: ", itens[item.id].quantidade)
	else:
		itens[item.id] = {
			"recurso": item,
			"quantidade": quantidade
		}
		print("✅ Novo item adicionado")
	
	inventario_atualizado.emit()
	print(itens)
	return true

func remover_item(item_id: String, quantidade: int = 1) -> bool:
	if item_id not in itens:
		return false
	
	itens[item_id].quantidade -= quantidade
	
	if itens[item_id].quantidade <= 0:
		itens.erase(item_id)
	
	inventario_atualizado.emit()
	return true

func get_quantidade(item_id: String) -> int:
	if item_id in itens:
		return itens[item_id].quantidade
	return 0

func listar_itens() -> Array:
	var lista = []
	for item_id in itens:
		var slot = itens[item_id]
		lista.append({
			"id": item_id,
			"nome": slot.recurso.nome,
			"icone": slot.recurso.icone,
			"quantidade": slot.quantidade,
			"tipo": slot.recurso.tipo
		})
		print("📋 Item na lista: ", slot.recurso.nome, " x", slot.quantidade)
	return lista

func tem_item(item_id: String, quantidade: int = 1) -> bool:
	return get_quantidade(item_id) >= quantidade

func usar_item(item_id: String) -> bool:
	if not tem_item(item_id, 1):
		return false
	
	var slot = itens[item_id]
	print("Usando item: ", slot.recurso.nome)
	
	# Aqui você adiciona os efeitos
	if slot.recurso.tipo == "consumivel":
		print("💊 Efeito de consumível aplicado")
	
	remover_item(item_id, 1)
	return true

# Remove o teste automático
func _ready():
	print("✅ Sistema de Inventário inicializado")
