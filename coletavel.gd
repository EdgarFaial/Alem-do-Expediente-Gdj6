extends Area2D

@export var item: ItemBase
@export var quantidade: int = 1

func _ready():
    # Verificação de segurança
    if item == null:
        print("⚠️ Coletável sem item! Criando item de emergência...")
        item = ItemBase.new()
        item.id = "item_emergencia"
        item.nome = "Item de Emergência"
        item.tipo = "coletavel"
    
    # Configura o sprite se existir
    if has_node("Sprite2D") and item.icone:
        $Sprite2D.texture = item.icone
    elif has_node("Sprite2D"):
        # Cria um sprite placeholder se não tiver ícone
        var placeholder = RectangleShape2D.new()
        print("⚠️ Item sem ícone: ", item.nome)
    
    # Conecta o sinal
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    print("🚀 Coletável detectou colisão com: ", body.name)
    
    # Procura o inventário no player
    var inventario = null
    
    # Tenta diferentes formas de encontrar o inventário
    if body.has_node("Inventario"):
        inventario = body.get_node("Inventario")
    elif body.has_method("get_node"):
        inventario = body.get_node("Inventario")
    else:
        # Procura em todos os filhos
        for child in body.get_children():
            if child.name == "Inventario":
                inventario = child
                break
    
    if inventario == null:
        print("❌ Não encontrou Inventario no player!")
        return
    
    print("✅ Inventario encontrado!")
    
    # Verifica se o item existe
    if item == null:
        print("❌ Item é null! Isso não deveria acontecer...")
        return
    
    print("📦 Tentando coletar: ", item.nome, " x", quantidade)
    
    # Tenta adicionar
    if inventario.adicionar_item(item, quantidade):
        print("✅ Coletou: ", item.nome, " x", quantidade)
        queue_free()
    else:
        print("❌ Falha ao coletar ", item.nome)