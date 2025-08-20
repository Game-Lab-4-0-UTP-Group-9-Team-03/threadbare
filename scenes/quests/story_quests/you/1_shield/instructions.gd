extends Node2D
const SHIELD = preload("res://scenes/quests/story_quests/you/1_shield/shield.dialogue")
@onready var interact_area: InteractArea = $InteractArea
@onready var puzzle_1 = $"../Puzzle_dialogo/puzzle_1"
@onready var puzzle_2 = $"../Puzzle_dialogo/puzzle_2"
@onready var puzzle_3 = $"../Puzzle_dialogo/puzzle_3"
@onready var puzzle_4 = $"../Puzzle_dialogo/puzzle_4"
@onready var puzzle_5 = $"../Puzzle_dialogo/puzzle_5"
@onready var puzzle_6 = $"../Puzzle_dialogo/puzzle_6"
@onready var puzzle_7 = $"../Puzzle_dialogo/puzzle_7"
@onready var puzzle_8 = $"../Puzzle_dialogo/puzzle_8"

func _on_interact_area_interaction_started(player: Player, from_right: bool) -> void:
	#Iniciar dialogo
	DialogueManager.show_dialogue_balloon(SHIELD, "show_sing", [self])
	await DialogueManager.dialogue_ended
	interact_area.interaction_ended.emit()
