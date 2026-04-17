extends Area2D

@onready var label = $Label

func _ready():
	label.visible = false
	
	# Conectando os sinais por código
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		label.visible = true
		print("Entrou:", body.name)

func _on_body_exited(body):
	if body.is_in_group("player"):
		label.visible = false
		print("Saiu:", body.name)
