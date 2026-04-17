extends Area2D

@export var carta_texto: String = "Texto da carta..."
@export var texto_ui: Control

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		texto_ui.show_text("Ah, finalmente eu consegui sair daquela cidade grotesca \n foram infinitas horas repondo caixas nas prateleiras do supermercado, eu não podia continuar \n não podia terminar como todos da minha fámilia terminaram... \n Talvez aqui eu possa encontrar um pouco de sossego.")
		queue_free()
