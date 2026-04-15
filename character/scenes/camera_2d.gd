extends Camera2D

@export var target: Node2D
@export var follow_speed: float = 8.0
@export var zoom_speed: float = 2.0
@export var target_zoom: Vector2 = Vector2.ONE
@export var dead_zone: Vector2 = Vector2(50, 50)  # Zona morta

var camera_rect: Rect2

func _ready():
	# Configurar limites baseados na sala atual (opcional)
	update_camera_limits()

func _process(delta):
	if not target:
		return
	
	# Cálculo da posição com zona morta
	var target_pos = target.global_position
	var current_pos = global_position
	var diff = target_pos - current_pos
	
	if abs(diff.x) > dead_zone.x:
		current_pos.x += diff.x - (dead_zone.x * sign(diff.x))
	
	if abs(diff.y) > dead_zone.y:
		current_pos.y += diff.y - (dead_zone.y * sign(diff.y))
	
	global_position = global_position.lerp(current_pos, follow_speed * delta)
	
	# Zoom suave
	zoom = zoom.lerp(target_zoom, zoom_speed * delta)

func update_camera_limits():
	# Exemplo: definir limites baseados no tilemap
	var tilemap = get_node("../TileMap")
	if tilemap:
		var used_rect = tilemap.get_used_rect()
		var cell_size = tilemap.cell_size
		var map_size = used_rect.size * cell_size
		limit_left = used_rect.position.x * cell_size.x
		limit_right = limit_left + map_size.x
		limit_top = used_rect.position.y * cell_size.y
		limit_bottom = limit_top + map_size.y
