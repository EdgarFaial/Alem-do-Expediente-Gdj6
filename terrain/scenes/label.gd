extends Label

var timer: Timer

func _ready():
	# Cria o timer
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_esconder_texto)
	
	# Começa escondido
	visible = false

# Função para mostrar texto
func mostrar_texto(novo_texto: String, duracao: float = 2.0):
	text = novo_texto
	visible = true
	
	if timer.is_stopped() == false:
		timer.stop()
	
	timer.start(duracao)

# Função para esconder
func esconder_texto():
	visible = false
	timer.stop()

func _esconder_texto():
	visible = false
