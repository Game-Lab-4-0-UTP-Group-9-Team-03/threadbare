extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var spawn_point_path: String
@export_file("*.tscn") var next_scene: String

func _ready() -> void:
	switch_scene()
	
func switch_scene():
	animation_player.play("switch_scene")
	await animation_player.animation_finished
	SceneSwitcher.change_to_file_with_transition(
				next_scene,
				spawn_point_path,
				Transition.Effect.FADE,
				Transition.Effect.FADE,
			)
