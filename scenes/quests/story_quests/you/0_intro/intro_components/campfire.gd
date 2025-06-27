extends AnimatedSprite2D

@export var light_fuerza: float = 1.0
@export var light_escala: float = 1.0
@onready var luz = $PointLight2D

func _ready() -> void:
	luz.texture_scale = light_escala
	luz.energy = light_fuerza
