# SPDX-FileCopyrightText: The Threadbare Authors
# SPDX-License-Identifier: MPL-2.0
## Shows a dialogue, then transitions to another scene.
## Intended for use in non-interactive cutscenes, such as the intro and outro to a quest
class_name Cinematic_Intro
extends Node2D

## Dialogue for cinematic scene
@export var dialogue: DialogueResource = preload("uid://b7ad8nar1hmfs")

## Animation player, to be used from [member dialogue] (if needed)
@export var animation_player: AnimationPlayer


## Scene to switch to once [member dialogue] is complete
@export_file("*.tscn") var next_scene: String

## Optional path inside [member next_scene] where the player should appear.
## If blank, player appears at default position in the scene. If in doubt,
## leave this blank.
@export var spawn_point_path: String

@onready var dialogo_1 = $"../dialogo_1"
@onready var dialogo_2 = $"../dialogo_2"
@onready var dialogo_3 = $"../dialogo_3"
@onready var dialogo_4 = $"../dialogo_4"
@onready var dialogo_5 = $"../dialogo_5"

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "", [self])
	await DialogueManager.dialogue_ended

	if next_scene:
		(
			SceneSwitcher
			. change_to_file_with_transition(
				next_scene,
				spawn_point_path,
				Transition.Effect.FADE,
				Transition.Effect.FADE,
			)
		)
