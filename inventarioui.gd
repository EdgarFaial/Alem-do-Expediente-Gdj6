extends CanvasLayer

@onready var panel = $Panel
@onready var container = $Panel/GridContainer
var inventario_ref: Inventario

func _ready():
    print("🎨 UI do Inventário inicializada")
    
    # Esconde o painel no início
    if panel:
        panel.visible = false
    
    # Procura o player e o inventário
    await get_tree().process_frame
    var player = get_tree().get_first_node_in_group("player")
    
    if player:
        print("✅ Player encontrado: ", player.name)
        if player.has_node("Inventario"):
            inventario_ref = player.get_node("Inventario")
            print("✅ Inventário encontrado!")
            # Conecta o sinal
            inventario_ref.inventario_atualizado.connect(_atualizar_ui)
        else:
            print("❌ Player não tem nó 'Inventario'")
    else:
        print("❌ Player não encontrado no grupo 'player'")
        # Tenta encontrar por nome
        player = get_tree().root.find_child("Player", true, false)
        if player:
            print("✅ Player encontrado por nome: ", player.name)
            inventario_ref = player.get_node("Inventario")
            if inventario_ref:
                inventario_ref.inventario_atualizado.connect(_atualizar_ui)

func _input(event):
    if event is InputEventKey and event.keycode == KEY_E and event.pressed:
        if panel:
            panel.visible = !panel.visible
            print("🎮 Tecla E - Painel visível: ", panel.visible)
            if panel.visible:
                _atualizar_ui()

func _atualizar_ui():
    print("🔄 Atualizando UI...")
    
    if not inventario_ref:
        print("❌ Sem referência do inventário")
        return
    
    if not container:
        print("❌ Container não encontrado")
        return
    
    # Limpa o container
    for child in container.get_children():
        child.queue_free()
    
    # Pega os itens
    var itens = inventario_ref.listar_itens()
    print("📊 Total de itens no inventário: ", itens.size())
    
    if itens.size() == 0:
        var label = Label.new()
        label.text = "Inventário Vazio"
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        container.add_child(label)
        return
    
    # Cria um slot para cada item
    for item_data in itens:
        var slot = criar_slot(item_data)
        container.add_child(slot)
    
    print("✅ UI atualizada com ", itens.size(), " itens")

func criar_slot(item_data: Dictionary) -> Panel:
    var slot = Panel.new()
    slot.custom_minimum_size = Vector2(80, 80)
    slot.size = Vector2(80, 80)
    
    # Cor de fundo do slot
    var style = StyleBoxFlat.new()
    style.bg_color = Color(0.2, 0.2, 0.2, 0.8)
    style.set_border_width_all(2)
    style.border_color = Color(0.5, 0.5, 0.5)
    slot.add_theme_stylebox_override("panel", style)
    
    # Nome do item
    var nome_label = Label.new()
    nome_label.text = item_data.nome
    nome_label.position = Vector2(5, 5)
    nome_label.size = Vector2(70, 20)
    nome_label.add_theme_font_size_override("font_size", 10)
    slot.add_child(nome_label)
    
    # Quantidade
    var qtd_label = Label.new()
    qtd_label.text = "x" + str(item_data.quantidade)
    qtd_label.position = Vector2(5, 55)
    qtd_label.size = Vector2(70, 20)
    qtd_label.add_theme_font_size_override("font_size", 12)
    qtd_label.add_theme_color_override("font_color", Color.YELLOW)
    slot.add_child(qtd_label)
    
    # Botão de usar (clique direito)
    slot.gui_input.connect(_on_slot_click.bind(item_data.id))
    
    return slot

func _on_slot_click(event: InputEvent, item_id: String):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        print("🔧 Usando item: ", item_id)
        if inventario_ref:
            inventario_ref.usar_item(item_id)   