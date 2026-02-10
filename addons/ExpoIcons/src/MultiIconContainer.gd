# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
@tool
class_name MultiIconContainer extends Container
## A class to dynamically switch between given [IconBase] types.


#region External Variables
## The [BaseIcon] [Script] this node will attempt to
## implement and use. If an invaild [Script] is given,
## then no icon will be displayed.
@export var icon_script : Script:
	set(val):
		if val == icon_script:
			return
		icon_script = val
		
		_create_icon()
		icon_name = get_default_icon_name()
		notify_property_list_changed()

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
var _icon : IconBase = null

@export_storage var _icon_size : int = IconBase.DEFAULT_ICON_SIZE
@export_storage var _icon_name : StringName
@export_storage var _icon_glyph : int
@export_storage var _icon_state : ProFreeIcons.ICON_STATE
#endregion



#region Virtual Methods
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_READY:
			_create_icon()
		NOTIFICATION_SORT_CHILDREN:
			_on_sort_children()

func _get_property_list() -> Array[Dictionary]:
	var properties : Array[Dictionary] = []
	
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
		"icon_name":
			icon_name = value
			_set_icon_name()
			return true
		"icon_glyph":
			icon_glyph = value
			_set_icon_glyph()
			return true
		"icon_size":
			icon_size = value
			_set_icon_size()
			return true
	return false
func _get(property: StringName) -> Variant:
	match property:
		"icon_name":
			return icon_name
		"icon_glyph":
			return icon_glyph
		"icon_size":
			return icon_size
	return null

func _property_can_revert(property: StringName) -> bool:
	match property:
		"icon_name":
			return icon_name != get_default_icon_name()
		"icon_size":
			return icon_size != IconBase.DEFAULT_ICON_SIZE
	return false
func _property_get_revert(property: StringName) -> Variant:
	match property:
		"icon_name":
			return get_default_icon_name()
		"icon_size":
			return IconBase.DEFAULT_ICON_SIZE
	return null
#endregion


#region Private Methods (Events) 
func _on_sort_children() -> void:
	if _icon:
		fit_child_in_rect(
			_icon,
			Rect2(Vector2.ZERO, size)
		)
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
	
	if icon_script == null || !icon_script.can_instantiate():
		return
	var temp = icon_script.new()
	if !(temp is IconBase):
		temp.free()
		return
	
	_icon = icon_script.new()
	add_child(_icon, false, Node.INTERNAL_MODE_BACK)
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


#region Public Methods
## Returns the default name ID of the currently selected icon
## [Script]. Returns an empty string if there are no [Script]s
## in the icon cache.
func get_default_icon_name() -> String:
	if !_icon:
		return ""
	return _icon.get_default_icon()

## Returns the [IconBase] currently implemented.
## [br][br]
## [b]Warning[/b]: This is a required internal node,
## removing and freeing it may cause a crash.
func get_icon() -> IconBase:
	return _icon
#endregion

# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
