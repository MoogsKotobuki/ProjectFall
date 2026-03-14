extends State
var cVelocity
var gravity

@onready var fixer:Fixer = Fixer.new()

var Speed:float
@export var accel = 5
@export var decel = 10
@export var JumpState:State

var frictionLand = 2.0
var friction = 1
var globalDirection = 0

var globalInputStrenght = 0
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	Speed = Entity.previousMaxSpeed
func _update(_delta: float) -> void:
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	globalInputStrenght = input_strenght
	if input_strenght >0.75:
		Speed = Entity.runSpeed
func _physics_update(_delta: float) -> void:
	if !Entity.is_on_floor():
		Entity.velocity.y += (Entity.get_gravity().y * Entity.mass) * _delta
		midAirMovement(_delta)
		if Input.is_action_just_pressed("jump"):
			state_machine.change_state("jump")
	else:
		JumpState.jumpLimit = 0
		state_machine.change_state("idle")
	Entity.move_and_slide()

func midAirMovement(_delta) -> void:
	var direction = IHandler.mov.x
	if direction:
		if direction > 0:
			globalDirection =1
		else:
			globalDirection = -1
			
		if Entity.velocity.x > 0:
				Entity.viewSides = PI
		elif Entity.velocity.x < 0:
				Entity.viewSides = 0
		fixer.MaxSpeedFix(Entity,Speed)
		Entity.velocity.x += (accel * _delta) * globalDirection
