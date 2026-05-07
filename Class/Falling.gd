extends State
var cVelocity
var gravity

@onready var fixer:Fixer = Fixer.new()

var Speed:float
@export var accel = 5
@export var decel = 10
@export var maxJump = 2

var frictionLand = 2.0
var friction = 1
var globalDirection = 0
var doubleJump = false

var globalInputStrenght = 0
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	Entity.specialStates = "Standing"
	Speed = Entity.previousMaxSpeed

func exit() -> void:
	if abs(IHandler.mov.x) <= 0.2:
		Entity.velocity.x = 0

func _update(_delta: float) -> void:
	pass
func _physics_update(_delta: float) -> void:
	if !Entity.is_on_floor():
		Entity.velocity.y += (Entity.get_gravity().y * Entity.mass) * _delta
		midAirMovement(_delta)
	Entity.move_and_slide()

func midAirMovement(_delta) -> void:
	var direction = IHandler.mov.x
	if abs(direction) > 0.2:
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
