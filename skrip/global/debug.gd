extends Node

var dev_mode := true
var allow_dev_mode := true # Selalu izinkan selagi masa Game Jam & debug
var fly_mode := false
var time_frozen := false
var hud_hidden := false

func _ready() -> void:
	# Pastikan script debug SELALU berjalan (PROCESS_MODE_ALWAYS) agar tombol Un-freeze tetap terdeteksi saat game dibekukan!
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if not allow_dev_mode:
		return
	if event.is_action_pressed("toggle_dev_mode") or (event is InputEventKey and event.physical_keycode == KEY_TAB and event.pressed and not event.echo):
		dev_mode = !dev_mode

	# Custom input Admin & Photo Mode - Aktif hanya saat dev_mode (Debug) dinyalakan
	if dev_mode and event is InputEventKey and event.pressed and not event.echo:
		# 1. Mode Terbang (Fly/No-Clip Admin Mode) - Tekan tombol F / F1
		if event.physical_keycode == KEY_F or event.physical_keycode == KEY_F1:
			fly_mode = !fly_mode
			
		# 2. Time Freeze / Photo Mode (Hentikan Waktu Murni TANPA Menu Pause!) - Tekan tombol T / F2
		if event.physical_keycode == KEY_T or event.physical_keycode == KEY_F2:
			time_frozen = !time_frozen
			if get_tree():
				get_tree().paused = time_frozen
				Global.play_sfx("res://asset/brackeys_platformer_assets/sounds/tap.wav")

		# 3. Toggle Sembunyikan HUD / UI (Clean Screenshot Mode) - Tekan tombol H / F3
		if event.physical_keycode == KEY_H or event.physical_keycode == KEY_F3:
			hud_hidden = !hud_hidden
			Global.play_sfx("res://asset/brackeys_platformer_assets/sounds/tap.wav")

func is_active():
	return dev_mode and allow_dev_mode
