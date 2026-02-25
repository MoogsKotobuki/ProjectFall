extends Control

var pVelocity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pVelocity = DebugVariable.PlayerVelocity
	if pVelocity != null:
		$VBoxContainer/Label.text = "Player velocity: " + str(pVelocity)
	if pVelocity != pVelocity:
		print(pVelocity)
