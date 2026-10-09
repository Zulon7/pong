extends RigidBody2D

var speed = 500;
var max_velocity = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var input = Input.get_vector("left", "right", "up", "down");
	var movement = input * speed;
	state.apply_force(movement);
	state.linear_velocity = state.linear_velocity.limit_length(max_velocity);
	
	
	
