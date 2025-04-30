extends ProgressBar

func addHealth(healValue: int) -> void:
	self.value += healValue

func loseHealth(damage: int) -> void:
	self.value -= damage
	print('losing health: ', damage)
