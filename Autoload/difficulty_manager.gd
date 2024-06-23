extends Node

signal score_changed(score : int)

const DIFFICULTY_START : float = 1.0
const DIFFICULTY_INCREMENT : float = 0.4
const AGE_START : int = 8
const SCORE_BONUS_ON_LEVEL : int = 100
const BPM_START : float = 130.0

var difficulty : float = DIFFICULTY_START
var age : int = AGE_START
var bpm : float = BPM_START
var score : int = 0

func add_score(points : int):
	score += points
	score_changed.emit(score)

func gameover():
	difficulty = DIFFICULTY_START
	age = AGE_START
	score = 0

func level_complete():
	add_score(SCORE_BONUS_ON_LEVEL * age)
	difficulty += DIFFICULTY_INCREMENT
	age += 1
	bpm = BPM_START * difficulty
