@abstract
extends Resource
class_name UsageType

@abstract
func use() -> void

@abstract
func get_availability() -> bool

@abstract
func process(delta: float) -> void
