extends Resource
class_name ItemBase

@export var id: String = ""
@export var nome: String = "Item"
@export var icone: Texture2D
@export var tipo: String = "consumivel"
@export var empilhavel: bool = true
@export var quantidade_max: int = 99
@export var descricao: String = ""