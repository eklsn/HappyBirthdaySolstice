extends Node

var player : Player 
var room_manager : RoomManager
var current_room : Room
var plot = 0

var save_data :Dictionary = {}


var needed_gems : Array[MiningGem] = []

var mined_gems : Array[MiningGem] = []

var mined_gems_text : String
