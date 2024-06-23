extends Control

@export var score_label : Label

func _ready():
	DifficultyManager.connect("score_changed", set_score)
	score_label.text = "%06d" % DifficultyManager.score

func set_score(score : int):
	score_label.text = "%06d" % score
