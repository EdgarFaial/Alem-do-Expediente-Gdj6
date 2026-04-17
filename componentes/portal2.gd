extends Area2D

var pode_teleportar := true

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		if not pode_teleportar:
			return
		pode_teleportar = false
		body.global_position = Vector2(-9731.0, 600)
		await get_tree().create_timer(0.5).timeout
		pode_teleportar = true
