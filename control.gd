extends Control

# Caminho da cena do jogo
const LEVEL_PATH = "res://terrain/scenes/level.tscn"

func _ready():
	# Conectar botões automaticamente
	$VBoxContainer/Button.text = "Jogar"
	$VBoxContainer/Button.pressed.connect(_on_jogar_pressed)

	$VBoxContainer/Button2.text = "Sair"
	$VBoxContainer/Button2.pressed.connect(_on_sair_pressed)


func _on_jogar_pressed():
	get_tree().change_scene_to_file(LEVEL_PATH)


func _on_sair_pressed():
	get_tree().quit()
