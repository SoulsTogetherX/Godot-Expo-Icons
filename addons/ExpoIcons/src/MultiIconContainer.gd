# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
@tool
class_name MultiIconContainer extends Container
## A class to dynamically switch between Icon Types


#region External Variables
var icon_size : int = IconBase.DEFAULT_ICON_SIZE:
	get:
		return _icon_size
	set(val):
		_icon_size = max(1, val)
		_set_icon_size()

var icon_name : StringName:
	get:
		return _icon_name
	set(val):
		_icon_name = val
		_set_icon_name()

var icon_glyph : int:
	get:
		return _icon_glyph
	set(val):
		_icon_glyph = val
		_set_icon_glyph()

var icon_state : ProFreeIcons.ICON_STATE:
	get:
		return _icon_state
	set(val):
		_icon_state = val
		_set_icon_state()
#endregion


#region Private Variables
var _icon_type : int = -1:
	set(val):
		if val != _icon_type:
			_icon_type = val
			
			notify_property_list_changed()
			_create_icon()
var _icon_scripts : Array[Script]:
	set(val):
		if val != _icon_scripts:
			_icon_scripts = val
			_queue_batch_update()

var _icon : IconBase = null
var _icon_size : int = IconBase.DEFAULT_ICON_SIZE
var _icon_name : StringName
var _icon_glyph : int
var _icon_state : ProFreeIcons.ICON_STATE

var _is_queuing : bool = false
#endregion



#region Virtual Methods
func _init() -> void:
	add_icon_script(preload("uid://dyhhvqcy300sm"))
	add_icon_script(preload("uid://l2q4q4vnluob"))
	add_icon_script(preload("uid://8bjt6f1ip3oj"))
	add_icon_script(preload("uid://bmxo2408u6o0w"))
	add_icon_script(preload("uid://uo0ns2lhrhkd"))

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_SORT_CHILDREN:
			_on_sort_children()

func _get_property_list() -> Array[Dictionary]:
	var properties : Array[Dictionary] = []
	var enum_hint_string : String
	var enum_usage := PROPERTY_USAGE_DEFAULT
	
	if !_icon_scripts.is_empty():
		for script : Script in _icon_scripts:
			enum_hint_string += script.get_global_name() + ","
		enum_hint_string = enum_hint_string.left(-1)
	else:
		enum_usage |= PROPERTY_USAGE_READ_ONLY
	
	# Mutable External Variables
	properties.append({
		"name": "icon_type",
		"type": TYPE_INT,
		"usage": enum_usage,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": enum_hint_string
	})
	
	if _icon == null:
		return properties
	
	# Unmutable External Variables
	properties.append({
		"name": "Icon Parameters",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_GROUP,
		"hint_string": ""
	})
	
	properties.append({
		"name": "icon_name",
		"type": TYPE_STRING_NAME,
		"usage": PROPERTY_USAGE_DEFAULT,
	})
	properties.append({
		"name": "icon_glyph",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(_icon.get_glyphs().keys())
	})
	properties.append({
		"name": "icon_size",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT
	})
	
	if !(_icon is ProFreeIcons):
		return properties
	
	properties.append({
		"name": "icon_state",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(ProFreeIcons.ICON_STATE.keys())
	})
	
	return properties
func _set(property: StringName, value: Variant) -> bool:
	match property:
		"icon_type":
			_icon_type = value
			return false
		"icon_name":
			icon_name = value
			_set_icon_name()
			return false
		"icon_glyph":
			icon_glyph = value
			_set_icon_glyph()
			return false
		"icon_size":
			icon_size = value
			_set_icon_size()
			return false
	return true
func _get(property: StringName) -> Variant:
	match property:
		"icon_type":
			return _icon_type
		"icon_name":
			return icon_name
		"icon_glyph":
			return icon_glyph
		"icon_size":
			return icon_size
	return null

func _property_can_revert(property: StringName) -> bool:
	match property:
		"icon_type":
			return -1 if _icon_scripts.is_empty() else 0
		"icon_name":
			return icon_name != get_current_default_icon_name()
		"icon_size":
			return icon_size != IconBase.DEFAULT_ICON_SIZE
	return false
func _property_get_revert(property: StringName) -> Variant:
	match property:
		"icon_type":
			return -1 if _icon_scripts.is_empty() else 0
		"icon_name":
			return get_current_default_icon_name()
		"icon_size":
			return IconBase.DEFAULT_ICON_SIZE
	return null
#endregion


#region Private Methods (Events) 
func _on_sort_children() -> void:
	if _icon:
		fit_child_in_rect(_icon, Rect2(Vector2.ZERO, size))
#endregion


#region Private Methods (Icon Controller) 
func _create_icon() -> void:
	if _icon:
		_remove_icon()
	
	var script := get_current_icon_script()
	if script == null:
		return
	
	_icon = script.new()
	add_child(_icon)
	fit_child_in_rect(_icon, Rect2(Vector2.ZERO, size))
	
	icon_state = ProFreeIcons.ICON_STATE.Free
	icon_name = script.get_default_icon()
	_set_icon_size()
func _remove_icon() -> void:
	_icon.queue_free()
	_icon = null

func _set_icon_name() -> void:
	if !_icon:
		return
	_icon.icon_name = icon_name
	_icon_glyph = _icon.icon_glyph
func _set_icon_glyph() -> void:
	if !_icon:
		return
	_icon.icon_glyph = icon_glyph
	_icon_name = _icon.icon_name
func _set_icon_size() -> void:
	if !_icon:
		return
	_icon.icon_size = icon_size
func _set_icon_state() -> void:
	if !_icon || !(_icon is ProFreeIcons):
		return
	_icon.icon_state = icon_state
#endregion


#region Private Methods (Icon Update Queue) 
func _queue_batch_update() -> void:
	if _is_queuing:
		return
	_is_queuing = true
	
	call_deferred("_batch_update")
func _batch_update() -> void:
	_is_queuing = false
	_icon_type = maxi(mini(0, _icon_type), _icon_scripts.size() - 1)
	notify_property_list_changed()
#endregion


#region Public Methods
func add_icon_script(script : Script) -> void:
	# Checks if the script is of the right type.
	var temp_check = script.new()
	if !(temp_check is IconBase):
		temp_check.free()
		push_error("Attempted to add script that does not inherit from 'IconBase'.")
		return
	temp_check.free()
	
	# Checks if script already exists in list
	if script in _icon_scripts:
		push_error("Attempted to add script that is already inserted.")
		return
	
	_icon_scripts.append(script)
func remove_icon_script(script : Script) -> void:
	if !(script in _icon_scripts):
		push_error("Attempted to remove script that has not been inserted.")
		return
	_icon_scripts.erase(script)

func get_current_icon_script() -> Script:
	if 0 > _icon_type || _icon_type >= _icon_scripts.size():
		return null
	return _icon_scripts[_icon_type]
func get_current_default_icon_name() -> String:
	var script := get_current_icon_script()
	if script == null:
		return ""
	return script.get_default_icon()
#endregion
