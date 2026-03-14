extends State


@onready var fixer:Fixer = Fixer.new()
var Speed
@export var accel = 20
@export var decel = 10

var friction = 1
var globalDirection = 0
var globalInputStrenght = 0

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	Speed = Entity.runSpeed
	Entity.previousMaxSpeed = Speed
	
func _update(_delta: float) -> void:
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	globalInputStrenght = input_strenght
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
	if !Entity.is_on_floor():
		state_machine.change_state("fall")
	
func _physics_update(_delta: float) -> void:
	var direction = IHandler.mov.x
	if direction:
		if direction > 0:
			globalDirection =1
		else:
			globalDirection = -1
			
		if globalDirection > 0:
				Entity.viewSides = PI
		elif globalDirection < 0:
				Entity.viewSides = 0
		Entity.velocity.x += (accel * _delta) * globalDirection
	else:
		state_machine.change_state("idle")
	Entity.move_and_slide()
	
	fixer.MaxSpeedFix(Entity,Speed)
	
