extends Node2D

@onready var player = $OnTheGround/Player
@onready var helm = $OnTheGround/Helm
@onready var timer = $OnTheGround/Helm/Timer
@onready var camera = $OnTheGround/Player/Camera2D
@onready var muro_salida = $TileMapLayers/MuroSalida

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
