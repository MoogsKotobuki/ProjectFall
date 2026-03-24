extends State
var cVelocity
var gravity

@onready var fixer:Fixer = Fixer.new()

var Speed:float
@export var accel:float = 5.0
@export var maxJump:float = 1.0
@export var friction:float = 0.5
var jumpLimit = 0
var doublejump = false

var globalInputStrenght = 0
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	Speed = Entity.previousMaxSpeed
func _update(_delta: float) -> void:
	if Entity.velocity.y < 5.0 and doublejump == true:
			state_machine.change_state("jump")
			doublejump = false
	
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	globalInputStrenght = input_strenght
	if input_strenght >0.75:
		Speed = Entity.runSpeed
	
func _physics_update(_delta: float) -> void:
	#Falling Logic
	if !Entity.is_on_floor():
		Entity.velocity.y += (Entity.get_gravity().y * Entity.mass) * _delta
		midAirMovement(_delta)
		
		#Double Jump Logic
		if Input.is_action_just_pressed("jump") and jumpLimit < maxJump:
			jumpLimit+= 1
			doublejump = true
			if globalInputStrenght == 0:
				#cancelling velocity during double when movement controller is not touch
				Entity.velocity.x = 0
	else:
		#Reset Double jump Counter
		jumpLimit = 0
		state_machine.change_state("idle")
		if globalInputStrenght == 0:
			#Reducing Velocity when landing
			Entity.velocity.x = Entity.velocity.x * friction
	Entity.move_and_slide()

func midAirMovement(_delta) -> void:
	#same logic as running with different acceleration value
	var direction = IHandler.mov.x
	var globalDirection
	#this is inefficient or maybe this is the solution
	if direction > 0:
		globalDirection =1
	else:
		globalDirection = -1
		
	
	if direction:
		if Entity.velocity.x > 0:
				Entity.viewSides = PI
		elif Entity.velocity.x < 0:
				Entity.viewSides = 0
		fixer.MaxSpeedFix(Entity,Speed)
		Entity.velocity.x += (accel * _delta) * globalDirection
