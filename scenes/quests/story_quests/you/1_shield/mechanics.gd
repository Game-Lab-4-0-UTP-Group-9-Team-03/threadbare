extends Node2D

@onready var player: CharacterBody2D = $OnTheGround/Player
@onready var helm = $OnTheGround/Helm
@onready var timer = $OnTheGround/Helm/Timer
@onready var camera = $OnTheGround/Player/Camera2D
@onready var muro_salida = $TileMapLayers/MuroSalida
@onready var camera_solved = $OnTheGround/CameraSolved
@onready var music_solved = $Shield_collectible/Puzzle_Solved_Sound
@onready var camera_normal = $OnTheGround/Player/Camera2D
@onready var muro_salida_animation = $TileMapLayers/MuroSalida_Animation
@onready var puzzle = $OnTheGround/SequencePuzzle
@onready var shield_collectible: Node2D = $Shield_collectible
@onready var blue: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Blue
@onready var pink: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Pink
@onready var yellow: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Yellow
@onready var green: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Green
@onready var purple: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Purple
@onready var red: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Red
@onready var jamaica: SequencePuzzleObject = $OnTheGround/SequencePuzzle/Objects/Jamaica




var max_distance = 3500.0
var min_distance = 300.0

		
func _process(delta: float) -> void:
	var distance = player.global_position.distance_to(helm.global_position)
	# Interpolar tiempo entre ticks según distancia
	var t = clamp((max_distance - distance) / (max_distance - min_distance), 0.0, 1.0)
	var wait_time = lerp(3.0, 0.5, t) # entre 0.5 y 0.1 segundos entre sonidos
	timer.wait_time = wait_time
	if (puzzle.steps.size() > puzzle._current_step):
		var sequence = puzzle.steps[puzzle._current_step].sequence
		var current_soul: SequencePuzzleObject = sequence[puzzle._position]
		if (helm.global_position != current_soul.global_position):
			helm.global_position = current_soul.global_position
		if(current_soul.visible == false):
			current_soul.process_mode = Node.PROCESS_MODE_INHERIT
			current_soul.visible = true
	else:
		helm.global_position = shield_collectible.global_position
	

func _ready() -> void:
	timer.start()
	
func _on_timer_timeout() -> void:
	helm.play()
	# Palpitar cámara
	var tween = create_tween()
	var random_offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
	tween.tween_property(camera, "offset", random_offset, 0.05)
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.05)
	


func _on_sequence_puzzle_solved() -> void:
	switch_camera_temporarily(2.41)
	

func switch_camera_temporarily(duration: float = 2.0) -> void:
	# Cambiamos a la cámara especial
	camera_solved.make_current()
	muro_salida_animation.play("desbloquear_salida")
	music_solved.play()
	# Usamos un temporizador "await" para esperar 'duration' segundos
	await get_tree().create_timer(duration).timeout
	# Regresamos a la cámara del jugador
	camera_normal.make_current()
	muro_salida.visible = false
	muro_salida.collision_enabled = false
	


func _on_blue_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(blue, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	blue.process_mode = Node.PROCESS_MODE_DISABLED
	blue.visible = false


func _on_pink_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(pink, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	pink.process_mode = Node.PROCESS_MODE_DISABLED
	pink.visible = false


func _on_yellow_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(yellow, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	yellow.process_mode = Node.PROCESS_MODE_DISABLED
	yellow.visible = false

func _on_green_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(green, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	green.process_mode = Node.PROCESS_MODE_DISABLED
	green.visible = false

func _on_purple_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(purple, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	purple.process_mode = Node.PROCESS_MODE_DISABLED
	purple.visible = false

func _on_red_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(red, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	red.process_mode = Node.PROCESS_MODE_DISABLED
	red.visible = false


func _on_jamaica_kicked() -> void:
	var tween = create_tween()
	tween.tween_property(jamaica, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2).timeout
	jamaica.process_mode = Node.PROCESS_MODE_DISABLED
	jamaica.visible = false
