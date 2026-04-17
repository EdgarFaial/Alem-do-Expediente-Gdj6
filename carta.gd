extends Area2D

@onready var label = $CanvasLayer/Label   # Certifique-se que o caminho está correto

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if label:  # Previne erro caso label seja null
		label.visible = false
	else:
		print("Erro: Label não encontrado! Verifique o caminho.")

func _on_body_entered(body):
	# Verifica se o corpo que entrou está no grupo "CharacterBody2D"
	if body.is_in_group("CharacterBody2D"):
		if label:
			label.visible = true

func _on_body_exited(body):
	if body.is_in_group("CharacterBody2D"):
		if label:
			label.visible = false
