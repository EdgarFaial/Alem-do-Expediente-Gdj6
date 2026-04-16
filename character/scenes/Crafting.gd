extends Node
class_name Crafting  # <-- IMPORTANTE!

# Receitas: { "resultado_id": {"requer": {"item_id": quantidade}, "resultado_qtd": int} }
var receitas = {
    "machado_melhor": {
        "requer": {"madeira": 5, "pedra": 3},
        "resultado_qtd": 1
    },
    "pocao_vida": {
        "requer": {"ervas": 2, "agua": 1},
        "resultado_qtd": 1
    }
}

func craftar(inventario: Inventario, receita_id: String) -> bool:
    if receita_id not in receitas:
        print("Receita não encontrada: ", receita_id)
        return false
    
    var receita = receitas[receita_id]
    var requerimentos = receita.requer
    
    # Verifica se tem todos os itens
    for item_id in requerimentos:
        if not inventario.tem_item(item_id, requerimentos[item_id]):
            print("Falta: ", item_id)
            return false
    
    # Remove materiais
    for item_id in requerimentos:
        inventario.remover_item(item_id, requerimentos[item_id])
    
    # Adiciona resultado
    var item_resultado = carregar_item_recurso(receita_id)
    if item_resultado:
        inventario.adicionar_item(item_resultado, receita.resultado_qtd)
        print("Craftou: ", receita_id)
        return true
    
    return false

func carregar_item_recurso(item_id: String) -> ItemBase:
    var caminho = "res://itens/%s.tres" % item_id
    if ResourceLoader.exists(caminho):
        return load(caminho)
    return null

func _ready():
    print("Sistema de Crafting inicializado")