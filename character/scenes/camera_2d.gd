extends Camera2D

@export var target: Node2D
@export var follow_speed: float = 8.0
@export var zoom_speed: float = 2.0
@export var target_zoom: Vector2 = Vector2.ONE
@export var dead_zone: Vector2 = Vector2(50, 50)

var camera_rect: Rect2
var is_following = false

func _ready():
    update_camera_limits()
    
    # Se o target já existe e está na cena
    if target and target.is_inside_tree():
        set_initial_position()
    else:
        # Aguarda o target ser adicionado
        await get_tree().process_frame
        set_initial_position()

func set_initial_position():
    if target:
        global_position = target.global_position
        reset_smoothing()
        is_following = true
        print("Câmera posicionada em: ", global_position)

func _process(delta):
    if not is_following or not target:
        return
    
    # Seu código original aqui...
    var target_pos = target.global_position
    var current_pos = global_position
    var diff = target_pos - current_pos
    
    if abs(diff.x) > dead_zone.x:
        current_pos.x += diff.x - (dead_zone.x * sign(diff.x))
    
    if abs(diff.y) > dead_zone.y:
        current_pos.y += diff.y - (dead_zone.y * sign(diff.y))
    
    global_position = global_position.lerp(current_pos, follow_speed * delta)
    zoom = zoom.lerp(target_zoom, zoom_speed * delta)

func update_camera_limits():
    var tilemap = get_node("../TileMap")
    if tilemap:
        var used_rect = tilemap.get_used_rect()
        var cell_size = tilemap.cell_size
        var map_size = used_rect.size * cell_size
        limit_left = used_rect.position.x * cell_size.x
        limit_right = limit_left + map_size.x
        limit_top = used_rect.position.y * cell_size.y
        limit_bottom = limit_top + map_size.y