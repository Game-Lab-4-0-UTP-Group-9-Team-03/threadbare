extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_2: Label = $AspectRatioContainer/MarginContainer/Label2
@onready var continue_sound: AudioStreamPlayer = $continue_sound
@export var spawn_point_path: String
@export_file("*.tscn") var next_scene: String

func _ready() -> void:
	label_2.modulate.a = 0.0
	switch_scene()
	
func switch_scene():
	animation_player.play("switch_scene_final")
	await animation_player.animation_finished
	create_tween().tween_property(label_2, "modulate:a", 1.0, 3.9)
	#tween.tween_property(label_2, "perce", 0.0, 2.0)
	continue_sound.play()
	await continue_sound.finished
	SceneSwitcher.change_to_file_with_transition(
				next_scene,
				spawn_point_path,
				Transition.Effect.FADE,
				Transition.Effect.FADE,
			)
	
	
	
