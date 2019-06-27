extends Node

"""
Stores a chain of actions with a timespam
"""

signal actions_chain_cleared(action_chain)
signal actions_chain_changed(action_chain)
 
onready var solve_timer = $Timer
export (float) var clear_time = 0.5

var _unsolved_action_chain = []

func _unhandled_input(event):
	if not event.is_action_type():
		return
	if event.is_echo():
		return
	if not event.is_pressed():
		return
	
	var action = get_event_action(event)
	if action:
		_unsolved_action_chain.append(action)
		emit_signal("actions_chain_changed", _unsolved_action_chain)
		solve_timer.start(clear_time)



func get_event_action(event):
	var action_name = ""
	for action in InputMap.get_actions():
		if InputMap.action_has_event(action, event):
			if "ui" in action:
				continue
			action_name = action
	
	return action_name


func clear_unsolved_actions():
	emit_signal("actions_chain_cleared", _unsolved_action_chain)
	_unsolved_action_chain.clear()
