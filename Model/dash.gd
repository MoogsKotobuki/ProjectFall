extends State
var dashSpeed = 0
@export var dashTimer:float = 0.5
@onready var timer = $Timer
@onready var coolDown:float = 0.5

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	dashSpeed = Entity.moveAttributes.speed.dash
	Entity.playerAttributes.animationState="dash"
	timer.start(dashTimer)

func exit()-> void:
	timer.start(coolDown)
	
func _update(_delta: float) -> void:
	pass
func _physics_update(_delta: float) -> void:
	Entity.velocity.y = 0
	
	if Entity.velocity.x > 0:
		Entity.velocity.x = dashSpeed 
	else:
		Entity.velocity.x = -dashSpeed
	
	Entity.move_and_slide()


func _on_timer_timeout() -> void:
	state_machine.change_state("run")
