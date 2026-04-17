extends Node

# Sinal que qualquer lugar pode emitir
signal texto_solicitado(texto, duracao)

# Referência para a label (será conectada depois)
var label_referencia: Label

# Função para registrar a label (chame no _ready() da label)
func registrar_label(label: Label):
	label_referencia = label

# Função global para mostrar texto (chame de qualquer lugar)
func mostrar_texto(texto: String, duracao: float = 2.0):
	if label_referencia:
		label_referencia.mostrar_texto(texto, duracao)
	else:
		print("Erro: Label não registrada!")
