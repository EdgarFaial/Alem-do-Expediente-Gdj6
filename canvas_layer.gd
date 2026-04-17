extends CanvasLayer

@onready var panel = $Panel
@onready var label = $Panel/Label

func set_card_text(text: String):
	label.text = text

func show_card():
	panel.visible = true

func hide_card():
	panel.visible = false
