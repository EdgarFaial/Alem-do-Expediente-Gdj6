extends Area2D

var pode_morrer := true

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		if not pode_morrer:
			return
		
		pode_morrer = false
		
		# Troca para a cena de Game Over
		get_tree().change_scene_to_file("res://menu.tscn")