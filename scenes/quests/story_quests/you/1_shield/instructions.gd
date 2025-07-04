extends Node2D
const SHIELD = preload("res://scenes/quests/story_quests/you/1_shield/shield.dialogue")
@onready var interact_area: InteractArea = $InteractArea


func _on_interact_area_interaction_started(player: Player, from_right: bool) -> void:
	#Iniciar dialogo
	DialogueManager.show_dialogue_balloon(SHIELD, "show_sing", [self])
	await DialogueManager.dialogue_ended
	interact_area.interaction_ended.emit()
