extends Node2D
var cards = []
var move_speed = 3
var ready_mount = 50

@onready var follower = $Path2D/PathFollow2D
func _process(delta):
	var del = []
	for i in range(len(cards)):
		match cards[i].stat:
			"normal", "ready":
				follower.set_progress_ratio(float(i)/len(cards))
				cards[i].position = cards[i].position.lerp(follower.position,delta*move_speed)
				cards[i].rotation = lerp_angle(cards[i].rotation,follower.rotation,delta*move_speed)
				if (cards[i].position - follower.position).length() <= ready_mount:
					cards[i].stat = "ready"
			"deleting":
				del.append(i)
	for i in del:
		cards.remove_at(i)
