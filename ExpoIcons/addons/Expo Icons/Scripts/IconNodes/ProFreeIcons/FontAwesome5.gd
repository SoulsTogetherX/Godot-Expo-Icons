@tool
class_name FontAwesome5 extends ProFreeIcons
## The node for all icons located in the FontAwesome5 [FontFile]s
##
## [b]NOTE[/b]: Some Icons are broken. This is due to a faulty meta file. I have no found a correct one on the internet yet.

const defaultIcon = "user" ## Default Icon
static var fontFiles : Dictionary  ## Used [FontFile]s
static var glyphs : Dictionary ## Used glyphs
static var metas : Dictionary ## Used metadatas

static var _ref_count : int = 0
func _enter_tree() -> void:
	_load_values()
func _exit_tree() -> void:
	_unload_values()
func _load_values() -> void:
	_ref_count += 1
	if _ref_count == 1:
		fontFiles = {
			"brands": load(_FONT_FOLDER + "FontAwesome5_Brands.ttf"),
			"regular": load(_FONT_FOLDER + "FontAwesome5_Regular.ttf"),
			"solid": load(_FONT_FOLDER + "FontAwesome5_Solid.ttf"),
		}
		glyphs = {
			ICON_STATE.Free: load(
				_GLYPHMAPS_FOLDER + "FontAwesome5Free.json"
			).data,
			ICON_STATE.Pro: load(
				_GLYPHMAPS_FOLDER + "FontAwesome5Pro.json"
			).data
		}
		metas = {
			ICON_STATE.Free: load(
				_GLYPHMAPS_FOLDER + "FontAwesome5Free_meta.json"
			).data,
			ICON_STATE.Pro: load(
				_GLYPHMAPS_FOLDER + "FontAwesome5Pro_meta.json"
			).data
		}
func _unload_values() -> void:
	_ref_count -= 1
	if _ref_count <= 0:
		fontFiles.clear()
		glyphs.clear()
		metas.clear()

## When given an string [param icon_name], return the corresponding glyph index.
## Returns -1 if icon cannot be found within the curren glyphs
static func get_default_icon() -> String:
	return defaultIcon
func _get_glyphs() -> Dictionary:
	if glyphs.has(_icon_state):
		return glyphs[_icon_state]
	return {}
## Returns the current FontFile in use, based on the current [member icon_state] value.
func get_fontFile() -> FontFile:
	if metas.has(_icon_state):
		var meta = metas[_icon_state]
		for type : String in fontFiles.keys():
			if meta[type].has(_icon_name):
				return fontFiles[type]
	return null
