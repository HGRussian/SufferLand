extends Node

var nodes: Dictionary = {}


func register_node(n_name, n_node) -> void:
	if nodes.has(n_name):
		print("Node name already exiting: " + n_name)
	
	nodes[n_name] = n_node


func pick_node(n_name):
	if nodes.has(n_name):
		return nodes[n_name]
	else:
		return null
