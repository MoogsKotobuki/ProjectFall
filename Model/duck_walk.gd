extends State

@onready var fixer:Fixer = Fixer.new()

var Speed
@export var accel = 20
@export var decel = 10
var friction = 1

var rayD:RayCast3D
var globalDirection = 0
var globalInputStrenght = 0
# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	if rayD == null:
		r.addRay(Entity,"duckDetection",Vector3(0,1.0,0),self,Vector3(0,1.0,0))
	
	Speed = Entity.moveAttributes.speed.duck
	Entity.playerAttributes.animationState="duckWalk"
	Entity.previousMaxSpeed = Speed
	Entity.specialStates = "duck"
	
func _update(_delta: float) -> void:
	var input = IHandler.mov

	
	if input.y < 0.1 and !rayD.is_colliding():
		state_machine.change_state("idle")
	
	if !Entity.is_on_floor():
		state_machine.change_state("fall")
	elif Input.is_action_just_pressed("jump") and !rayD.is_colliding():
		state_machine.change_state("jump")
func _physics_update(_delta: float) -> void:
	var direction = IHandler.mov.x
	if abs(direction) > 0.2:
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
		state_machine.change_state("duck")
	Entity.move_and_slide()
	
	fixer.MaxSpeedFix(Entity,Speed)
