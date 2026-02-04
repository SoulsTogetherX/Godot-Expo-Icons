# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
@tool
class_name MultiIconContainer extends Container
## A class to dynamically switch between given [IconBase] types.


#region External Variables
@export_tool_button("Load All Default Icons") var _load_icons := func():
	set_icon_scripts([
		load("uid://dyhhvqcy300sm"),
		load("uid://l2q4q4vnluob"),
		load("uid://8bjt6f1ip3oj"),
		load("uid://b58the6pio4w"),
		load("uid://ouh2uorb4gmr"),
		load("uid://uo0ns2lhrhkd"),
		load("uid://cxqnbfkn4sque"),
		load("uid://c6iw3dpi5q7va"),
		load("uid://18fl8skgouv8"),
		load("uid://bw124ti4smdn4"),
		load("uid://sssi1oere6n7"),
		load("uid://58tcc605ihw2"),
		load("uid://ottnvo0s64il"),
		load("uid://cvqvpsswcy6ph"),
		load("uid://bmxo2408u6o0w")
	])

## The available cache of icon [Script]s.
## [br][br]
## Also see [method set_icon_scripts],
## [method add_icon_script], and [method remove_icon_script].
@export_custom(
	PROPERTY_HINT_ARRAY_TYPE, "Script", PROPERTY_USAGE_EDITOR
) var icon_scripts : Array[Script]:
	set = set_icon_scripts,
	get = get_icon_scripts

## Font size of the Icon's Glyphs
var icon_size : int = IconBase.DEFAULT_ICON_SIZE:
	get:
		return _icon_size
	set(val):
		_icon_size = max(1, val)
		_set_icon_size()

## String ID name of the icon
var icon_name : StringName:
	get:
		return _icon_name
	set(val):
		_icon_name = val
		_set_icon_name()

## Glyph index of the icon
var icon_glyph : int:
	get:
		return _icon_glyph
	set(val):
		_icon_glyph = val
		_set_icon_glyph()

## The state that determines what [FontFile] and meta the icon uses
##
## See [enum ProFreeIcons.ICON_STATE].
var icon_state : ProFreeIcons.ICON_STATE:
	get:
		return _icon_state
	set(val):
		_icon_state = val
		_set_icon_state()
#endregion


#region Private Variables
@export_storage var _icon_type : int = -1:
	set(val):
		_icon_type = val
		
		notify_property_list_changed()
		_create_icon()
@export_storage var _icon_scripts : Array[Script]

var _icon : IconBase = null
@export_storage var _icon_size : int = IconBase.DEFAULT_ICON_SIZE
@export_storage var _icon_name : StringName
@export_storage var _icon_glyph : int
@export_storage var _icon_state : ProFreeIcons.ICON_STATE

var _is_queuing : bool = false
#endregion



#region Virtual Methods
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_READY:
			_queue_batch_update()
		NOTIFICATION_SORT_CHILDREN:
			_on_sort_children()

func _get_property_list() -> Array[Dictionary]:
	var properties : Array[Dictionary] = []
	var enum_hint_string : String
	var enum_usage := PROPERTY_USAGE_EDITOR
	
	if _icon_scripts.is_empty():
		enum_usage |= PROPERTY_USAGE_READ_ONLY
	else:
		var idx := 0
		for script : Script in _icon_scripts:
			if script:
				enum_hint_string += "%s:%d," % [script.get_global_name(), idx]
			idx += 1;
		enum_hint_string = enum_hint_string.left(-1)
	
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
		"usage": PROPERTY_USAGE_EDITOR,
	})
	properties.append({
		"name": "icon_glyph",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_EDITOR,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(_icon.get_glyphs().keys())
	})
	properties.append({
		"name": "icon_size",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_EDITOR
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
func _get_minimum_size() -> Vector2:
	return (
		_icon.get_combined_minimum_size()
		if (_icon && !clip_contents)
		else Vector2.ZERO
	)
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
	
	_set_icon_state()
	_set_icon_name()
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
	_icon_type = mini(maxi(0, _icon_type), _icon_scripts.size() - 1)
	notify_property_list_changed()
#endregion


#region Public Static Methods
## Checks if a given [Script] inherits from [IconBase].
static func is_icon_script(script : Script) -> bool:
	if !script:
		return false
	
	var temp_check = script.new()
	if temp_check is IconBase:
		temp_check.free()
		return true
	temp_check.free()
	return false
#endregion


#region Public Methods
## A method to get the entire available cache of icon [Script]s.
func get_icon_scripts() -> Array[Script]:
	return _icon_scripts
## A method to set the entire available cache of icon [Script]s.
## [br][br]
## [b]NOTE[/b]: This method has to check every script given and,
## thus, can be slow if used more than needed.
func set_icon_scripts(scripts : Array[Script]) -> void:
	_icon_scripts.clear()
	for check_script : Script in scripts:
		_icon_scripts.append(
			check_script
			if is_icon_script(check_script) && (!check_script in _icon_scripts)
			else null
		)
	_queue_batch_update()

## Add an icon [Script] to the available icon cache.
func add_icon_script(script : Script) -> void:
	# Checks if the script is of the right type.
	if (!is_icon_script(script)):
		push_error("Attempted to add script that does not inherit from 'IconBase'.")
		return
	
	# Checks if script already exists in list
	if script in _icon_scripts:
		push_error("Attempted to add script that is already inserted.")
		return
	
	_icon_scripts.append(script)
	_queue_batch_update()
## Removes an icon [Script] to the available icon cache.
func remove_icon_script(script : Script) -> void:
	if !(script in _icon_scripts):
		push_error("Attempted to remove script that has not been inserted.")
		return
	_icon_scripts.erase(script)
	_queue_batch_update()

## Returns the icon [Script] currently selected. Returns
## [code]null[/code] if there are no [Script]s in the icon
## cache.
func get_current_icon_script() -> Script:
	if 0 > _icon_type || _icon_type >= _icon_scripts.size():
		return null
	return _icon_scripts[_icon_type]
## Returns the default name ID of the currently selected icon
## [Script]. Returns an empty string if there are no [Script]s
## in the icon cache.
func get_current_default_icon_name() -> String:
	var script := get_current_icon_script()
	if script == null:
		return ""
	return script.get_default_icon()
#endregion

# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
