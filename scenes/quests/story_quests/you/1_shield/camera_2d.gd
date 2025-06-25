extends Camera2D

@export var decay: float = 0.8;

@export var max_offset: Vector2 = Vector2(80,80);
@export var max_roll: float = 0.1;

@export var target: NodePath;

var trauma = 0.0;
var trauma_power = 2;

var noise_y = 0;
@onready var noise = FastNoiseLite.new();
