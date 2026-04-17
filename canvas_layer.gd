extends CanvasLayer

@onready var label = $Panel/Label
@onready var panel = $Panel
@onready var timer = $Timer

func _ready():
	panel.visible = false

func show_text(text: String):
	label.text = text
	panel.visible = true
	timer.start(3.0)  # some após 3 segundos

func _on_timer_timeout():
	panel.visible = false
