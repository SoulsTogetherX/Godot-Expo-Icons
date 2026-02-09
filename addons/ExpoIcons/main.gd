# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
@tool
extends EditorPlugin


const ICON_FOLDER := "res://addons/ExpoIcons/assets/icons/"


func _enter_tree() -> void:
	add_custom_type(
		"IconBase",
		"Control",
		load("uid://bfg5x70yt7pii"),
		preload(ICON_FOLDER + "IconBase.svg")
	)
	add_custom_type(
		"MultiIconContainer",
		"Container",
		load("uid://bn5panlmq1v2d"),
		preload(ICON_FOLDER + "MultiIconContainer.svg")
	)
	
	add_custom_type(
		"AntDesign",
		"Control",
		load("uid://dyhhvqcy300sm"),
		preload(ICON_FOLDER + "AntDesign.svg")
	)
	add_custom_type(
		"Entypo",
		"Control",
		load("uid://l2q4q4vnluob"),
		preload(ICON_FOLDER + "Entypo.svg")
	)
	add_custom_type(
		"EvilIcons",
		"Control",
		load("uid://8bjt6f1ip3oj"),
		preload(ICON_FOLDER + "EvilIcons.svg")
	)
	add_custom_type(
		"Feather",
		"Control",
		load("uid://b58the6pio4w"),
		preload(ICON_FOLDER + "Feather.svg")
	)
	add_custom_type(
		"FontAwesome5",
		"Control",
		load("uid://uo0ns2lhrhkd"),
		preload(ICON_FOLDER + "FontAwesome5.svg")
	)
	add_custom_type(
		"FontAwesome6",
		"Control",
		load("uid://cxqnbfkn4sque"),
		preload(ICON_FOLDER + "FontAwesome6.svg")
	)
	add_custom_type(
		"FontAwesome",
		"Control",
		load("uid://ouh2uorb4gmr"),
		preload(ICON_FOLDER + "FontAwesome.svg")
	)
	add_custom_type(
		"Fontisto",
		"Control",
		load("uid://c6iw3dpi5q7va"),
		preload(ICON_FOLDER + "Fontisto.svg")
	)
	add_custom_type(
		"Foundation",
		"Control",
		load("uid://18fl8skgouv8"),
		preload(ICON_FOLDER + "Foundation.svg")
	)
	add_custom_type(
		"Ionicons",
		"Control",
		load("uid://bw124ti4smdn4"),
		preload(ICON_FOLDER + "Ionicons.svg")
	)
	add_custom_type(
		"MaterialCommunityIcons",
		"Control",
		load("uid://sssi1oere6n7"),
		preload(ICON_FOLDER + "MaterialCommunityIcons.svg")
	)
	add_custom_type(
		"MaterialIcons",
		"Control",
		load("uid://58tcc605ihw2"),
		preload(ICON_FOLDER + "MaterialIcons.svg")
	)
	add_custom_type(
		"Octicons",
		"Control",
		load("uid://ottnvo0s64il"),
		preload(ICON_FOLDER + "Octicons.svg")
	)
	add_custom_type(
		"SimpleLineIcons",
		"Control",
		load("uid://cvqvpsswcy6ph"),
		preload(ICON_FOLDER + "SimpleLineIcons.svg")
	)
	add_custom_type(
		"Zocial",
		"Control",
		load("uid://bmxo2408u6o0w"),
		preload(ICON_FOLDER + "Zocial.svg")
	)

func _exit_tree() -> void:
	remove_custom_type("Zocial")
	remove_custom_type("SimpleLineIcons")
	remove_custom_type("Octicons")
	remove_custom_type("MaterialIcons")
	remove_custom_type("MaterialCommunityIcons")
	remove_custom_type("Foundation")
	remove_custom_type("Fontisto")
	remove_custom_type("FontAwesome")
	remove_custom_type("FontAwesome6")
	remove_custom_type("FontAwesome5")
	remove_custom_type("Feather")
	remove_custom_type("EvilIcons")
	remove_custom_type("Entypo")
	remove_custom_type("AntDesign")
	
	remove_custom_type("IconBase")

# Made by Xavier Alvarez. A part of the "Expo Icons" Godot addon. @2025
