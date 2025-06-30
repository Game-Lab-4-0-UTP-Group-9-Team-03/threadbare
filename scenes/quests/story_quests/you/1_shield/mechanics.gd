extends Node2D

@onready var player = $OnTheGround/Player
@onready var helm = $OnTheGround/Helm
@onready var timer = $OnTheGround/Helm/Timer
@onready var camera = $OnTheGround/Player/Camera2D
@onready var muro_salida = $TileMapLayers/MuroSalida
@onready var claves: Label = $HelmHUD/Claves
@onready var pistas = $OnTheGround/SequencePuzzle/Steps/SequencePuzzleStep1
@onready var camera_solved = $OnTheGround/CameraSolved
@onready var camera_normal = $OnTheGround/Player/Camera2D

var max_distance = 3500.0
var min_distance = 300.0

		
func _process(delta: float) -> void:
	var distance = player.global_position.distance_to(helm.global_position)
	# Interpolar tiempo entre ticks según distancia
	var t = clamp((max_distance - distance) / (max_distance - min_distance), 0.0, 1.0)
	var wait_time = lerp(3.0, 0.5, t) # entre 0.5 y 0.1 segundos entre sonidos
	timer.wait_time = wait_time

func _ready() -> void:
	timer.start()
	claves.text = "123"
	print(pistas.sequence)
	
	
func _on_timer_timeout() -> void:
	helm.play()
	# Palpitar cámara
	var tween = create_tween()
	var random_offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
	tween.tween_property(camera, "offset", random_offset, 0.05)
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.05)
	


func _on_sequence_puzzle_solved() -> void:
	muro_salida.visible = false
	muro_salida.collision_enabled = false
	switch_camera_temporarily(2.0)

func switch_camera_temporarily(duration: float = 2.0) -> void:
	# Cambiamos a la cámara especial
	camera_solved.make_current()
	# Usamos un temporizador "await" para esperar 'duration' segundos
	await get_tree().create_timer(duration).timeout
	# Regresamos a la cámara del jugador
	camera_normal.make_current()
