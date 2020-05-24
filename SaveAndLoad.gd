extends Node

const SCORE_DATA_PATH = "res://score_data.json"

var default_score_data = {
	highscore=40
}

func save_score_to_file(score_data):
	var json_string = to_json(score_data)
	var score_file = File.new()
	
	score_file.open(SCORE_DATA_PATH, File.WRITE)
	score_file.store_line(json_string)
	score_file.close()

func load_score_from_file():
	var score_file = File.new()
	if not score_file.file_exists(SCORE_DATA_PATH):
		return default_score_data
		
	score_file.open(SCORE_DATA_PATH, File.READ)
	var score_data = parse_json(score_file.get_as_text())
	score_file.close()
	return score_data
