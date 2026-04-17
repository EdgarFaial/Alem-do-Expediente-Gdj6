extends Sprite2D

func _ready():
	visible = false  # começa invisível
	await get_tree().create_timer(15.0).timeout
	visible = true   # aparece depois de 30 segundos
