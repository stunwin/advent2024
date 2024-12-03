extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day2test()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func day1():
	var list1 = []
	var list2 = []
	var totaldiff = 0
	
	var mainlist = load_from_file("day1input")
	for line in mainlist:
		if line != "":
			var splitline = line.rsplit("   ", false, 0)
			list1.append(int(splitline[0]))
			list2.append(int(splitline[1]))
	list1.sort()
	list2.sort()
	for i in range(0, len(list2)):
		var linediff = abs(list1[i] - list2[i])
		totaldiff += linediff
	
	print(totaldiff)


func day1star():
	var list1 = []
	var list2 = []
	var score = 0
	
	var mainlist = load_from_file("day1input")
	for line in mainlist:
		if line != "":
			var splitline = line.rsplit("   ", false, 0)
			list1.append(int(splitline[0]))
			list2.append(int(splitline[1]))
	for i in range(0, len(list2)):
		var numscore = list1[i] * list2.count(list1[i])
		score += numscore
	
	print(score)

func day2():
	var grid = []
	var safecount = 0
	var mainlist = load_from_file("day2input")
	for line in mainlist:
		if line != "":
			var splitline = line.rsplit(" ", false, 0)
			var intline = []
			for i in splitline:
				intline.append(int(i))
			grid.append(intline)
	for line in grid:
		var growth = null
		var safe = true
		for i in range(len(line) - 1):
			if line[i] == line[i + 1]:
				safe = false
				break
			var d = line[i + 1] - line[i]
			if not growth:
				growth = sign(d)
			if abs(d) > 3 or abs(d) < 0 or growth != sign(d):
				safe = false
				break
		if safe:
			safecount += 1
			print(line)
	print(safecount)


func day2star():
	var grid = []
	var safecount = 0
	var mainlist = load_from_file("day2test")
	for line in mainlist:
		if line != "":
			var splitline = line.rsplit(" ", false, 0)
			var intline = []
			for i in splitline:
				intline.append(int(i))
			grid.append(intline)
	for line in grid:
		var growth = null
		var safe = true
		for i in range(len(line) - 1):
			if line[i] == line[i + 1]:
				safe = false
				break
			var d = line[i + 1] - line[i]
			if not growth:
				growth = sign(d)
			if abs(d) > 3 or abs(d) < 0 or growth != sign(d):
				safe = false
				break
		if safe:
			safecount += 1
			print(line)
	print(safecount)
			

func load_from_file(input):
	var file = FileAccess.open(input, FileAccess.READ)
	var arr = []
	while not file.eof_reached():
		arr.append(file.get_line())
	return arr
