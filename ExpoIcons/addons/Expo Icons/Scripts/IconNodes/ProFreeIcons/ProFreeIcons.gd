class_name ProFreeIcons extends IconBase
## The base abstract class for all ProFreeIcon nodes

enum ICON_STATE {
	Free,
	Pro
}

var _icon_state : ICON_STATE = ICON_STATE.Free
## The state that determines what [FontFile] and meta the icon uses
##
## See [enum ICON_STATE].
@export var icon_state : ICON_STATE:
	get:
		return _icon_state
	set(state):
		_icon_state = state
		var glyphs := _get_glyphs()
		var glyph_index = glyphs.keys().find(_current_icon)
		if glyph_index == -1:
			var defaultIcon := get_default_icon()
			_current_icon = defaultIcon
			_icon_name = defaultIcon
			_icon_glyph = glyphs.keys().find(defaultIcon)
		else:
			_icon_glyph = glyph_index
		notify_property_list_changed()
		queue_redraw()

## An abstract function ment to be overridden.
##
## Returns the current FontFile in use, based on the current [member icon_state] value.
func get_current_fontFile() -> FontFile:
	push_warning("Function 'get_current_fontFile()' not implemented in abstract class")
	return null
