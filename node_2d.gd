extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day8()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func day1():
	var list1 = []
	var list2 = []
	var totaldiff = 0
	
	var mainlist = arr_from_file("day1input")
	for line in mainlist:
		if line != " ":
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
	
	var mainlist = arr_from_file("day1input")
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
	var mainlist = arr_from_file("day2input")
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
	var mainlist = arr_from_file("day2test")
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
			
func day3():
	var input = string_from_file("day3input")
	var regex = RegEx.new()
	var total = 0
	#plz help im not good at computer
	regex.compile("mul\\(\\d{1,3},\\d{1,3}\\)")
	var matches = regex.search_all(input)
	for match in matches:
		print(match.get_string())
		var fullmatch = match.get_string().lstrip("mul()").rstrip(")").rsplit(",", false, 0)
		total += int(fullmatch[0]) * int(fullmatch[1])
	print(total)

func day3star():
	var input = string_from_file("day3input")
	var regex = RegEx.new()
	var total = 0
	var chunkarray = input.rsplit("do", false, 0)
	var count = true

	for chunk in chunkarray:
		if chunk.findn("n't()") == 0:
			count = false
		elif chunk.findn("()") == 0 or count:
			count = true
			regex.compile("mul\\(\\d{1,3},\\d{1,3}\\)")
			var matches = regex.search_all(chunk)
			for match in matches:
				var fullmatch = match.get_string().lstrip("mul()").rstrip(")").rsplit(",", false, 0)
				total += int(fullmatch[0]) * int(fullmatch[1])
	print(total)



func day4():
	var totalcount = 0
	var grid = arr_from_file("day4input")
	for row in range(len(grid)):
		for col in range(len(grid[0])):
			if grid[row][col] == "X":
				totalcount += mcheck(grid, row, col)
	print(totalcount)



func mcheck(grid, row, col) :
	var count = 0
	for i in range(-1, 2):
		for j in range(-1, 2):
			if boundarycheck(row, col, i, j, grid):
				continue
			if grid[row + i][col + j] == "M" and ascheck(grid, row, col, i, j):
				count += 1
	return count

func ascheck(grid, row, col, i, j):
	row = row + i
	col = col + j
	if boundarycheck(row, col, i, j, grid) or boundarycheck(row, col, 2 * i, 2 * j, grid):
		return false
	if grid[row + i][col + j] == "A" and grid[row + 2 * i][col + 2 * j] == "S":
		return true
	else:
		return false

func boundarycheck(row, col, i, j, grid):
		return row + i < 0 or row + i >= len(grid) or col + j < 0 or col + j >= len(grid[0])

func day5():
	var infiles = day5input("day5input")
	var rules = infiles[0]
	var books = infiles[1]
	var goodbooks = []
	var total = 0

	for book in books:
		var rulebreaker = false
		for rule in rules:
			if book.find(rule[0]) == -1 or book.find(rule[1]) == -1:
				continue
			if book.find(rule[0]) > book.find(rule[1]):
				rulebreaker = true
				break
		if not rulebreaker:
			goodbooks.append(book)
			
	for book in goodbooks:
		var middle = int(len(book))/2
		total += int(book[middle])

	print(total)



func day5star():
	var infiles = day5input("day5input")
	var rules = infiles[0]
	var books = infiles[1]
	var badbooks = []
	var total = 0

	for book in books:
		for rule in rules:
			if book.find(rule[0]) == -1 or book.find(rule[1]) == -1:
				continue
			if book.find(rule[0]) > book.find(rule[1]):
				badbooks.append(book)
				break
	for book in badbooks:
		var swapped = true		
		while swapped:
			swapped = false
			for rule in rules:
				if book.find(rule[0]) == -1 or book.find(rule[1]) == -1:
					continue
				if book.find(rule[0]) > book.find(rule[1]):
					swapped = true
					
					var i = book.find(rule[0])

					var j = book.find(rule[1])
					var swap = book[i]
					book[i] = book[j]
					book[j] = swap
	for book in badbooks:
		var middle = int(len(book))/2
		total += int(book[middle])

	print(total)


func day6():
	var grid = arr_from_file("day6input", true)
	var direction = [Vector2i(-1, 0), Vector2i(0, 1),  Vector2i(1, 0),  Vector2i(0, -1), ]
	var location = Vector2i()
	var diridx = 0
	var elfvector = direction[diridx]
	var coverage = 0

	for row in len(grid):
		if grid[row].find("^") != -1:
			location.x = row
			location.y = grid[row].find("^")
			grid[location.x][location.y] = "X"
			break
	while not boundarycheck(location.x, location.y, elfvector.x, elfvector.y, grid):
		var next = location + elfvector
		if grid[next.x][next.y] == "#":
			diridx += 1
			elfvector = direction[diridx % 4]
		else:
			location = location + elfvector
			grid[location.x][location.y] = "X"
		# for row in len(grid):
		# 	print("".join(grid[row]))

		
	for row in grid:
		coverage = coverage + row.count("X")
	
	print(coverage)
			
func day7():
	var list = arr_from_file("day7input")
	var fixed_list = []	
	var short_list = []
	var total = 0

	for line in list:
		var intline = []
		var fixed_line = line.rsplit(" ")
		fixed_line[0] = fixed_line[0].rstrip(":")
		# print(fixed_line)
		for i in range(len(fixed_line)):
			intline.append(int(fixed_line[i]))
		fixed_list.append(intline)
	list = fixed_list
	# print(len(list))
	#
	# for line in list:
	# 	if addall(line) and multall(line):
	# 		short_list.append(line)
	# list = short_list
	# print(len(list))
	for line in list:
		if ungabunga(line, 2, line[0], line[1]):
			total += line[0]
	print(total)
		
func day8():
	var grid = arr_from_file("day8input")
	var charlist = []
	var directory = []
	var resultlist= grid.duplicate(true)
	var count = 0
	for row in grid:
		for i in len(row):
			if row[i] not in charlist:
				charlist.append(row[i])
	for i in charlist:
		if i == ".":
			continue
		directory.append(towerfinder(i, grid))
	for set in directory:
		for tower in set:
			for tower2 in set:
				if tower == tower2:
					continue
				var vec = tower2 - tower
				var result = tower2 + vec
				if not boundarycheck(result.x, result.y, 0, 0, grid) and resultlist[result.x][result.y] != "#":
					count += 1
					resultlist[result.x][result.y] = "#"
	print(resultlist)
	print(count)

			
		

func towerfinder(letter, grid):
	var coordlist = []
	for i in len(grid):
		for j in len(grid[0]):
			if grid[i][j] == letter:
				var coord = Vector2i(i, j)
				coordlist.append(coord)
	return coordlist

func ungabunga(line, depth, goal, total):
	var multtotal = total * line[depth]
	var addtotal = total + line[depth]
	if depth == len(line) - 1 and (multtotal == goal or addtotal == goal):
		# print(line)
		return true
		
	elif depth == len(line) - 1:
		return false
	var mult = ungabunga(line, depth + 1, line[0], multtotal)
	var plus = ungabunga(line, depth + 1, line[0], addtotal)
	if mult or plus:
		return true




func addall(line):
	var goal = line[0]
	var total = 0
	for i in range(1, len(line)):
		total += line[i]
	if total > goal:
		# print("addall failed, total (" + str(total) + ") is higher than goal (" + str(goal) + ")")
		return false
	else:
		return true
	
func multall(line):
	var goal = line[0]
	var total = line[1]
	for i in range(2, len(line)):
		total *= line[i]
	if total < goal:
		# print("multall failed, total (" + str(total) + ") is lower than goal (" + str(goal) + ")")
		return false
	else:
		return true





func day5input(input):
	var file = FileAccess.open(input, FileAccess.READ)
	var rules = []
	var pages = []
	var splitidx
	var ruleints = []
	var pageints = []
	var found = false
	while not file.eof_reached():
		var line = file.get_line() 
		if line == "" and not found:
			splitidx = len(rules)
			found = true
		rules.append(line)
	rules.pop_back()

	for i in range(len(rules) - splitidx - 1):
		pages.append(rules.pop_back())
	rules.pop_back()

	for rule in rules:
		var intrule = rule.rsplit("|", false, 0)
		ruleints.append(intrule)

	
	for book in pages:
		var intpage = book.rsplit(",", false, 0)
		pageints.append(intpage) 

	
	return [ ruleints, pageints ]


	


func string_from_file(input):
	var file = FileAccess.open(input, FileAccess.READ)
	return file.get_as_text()

func arr_from_file(input, twod = false):
	var file = FileAccess.open(input, FileAccess.READ)
	var arr = []
	var twodarr = []
	while not file.eof_reached():
		arr.append(file.get_line())
	arr.pop_back()
	if twod:
		for line in arr:
			var linearr = []
			for c in line:
				linearr.append(c)
			twodarr.append(linearr)
		arr = twodarr
				
	return arr
