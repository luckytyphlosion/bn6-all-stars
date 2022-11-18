@archive ChooseCrossesTextScript_JP
@size 21

script 0 mmbn6 {
  mugshotShow
    mugshot = MegaMan
  msgOpen
  """
  1つ目のクロスを
  せんたくしてね
  """
  keyWait
    any = false
  clearMsg
  jump
    target = 5
}

script 1 mmbn6 {
  mugshotShow
    mugshot = MegaMan
  msgOpen
  """
  2つ目のクロスを
  せんたくしてね
  """
  keyWait
    any = false
  clearMsg
  jump
    target = 5
}

script 2 mmbn6 {
  mugshotShow
    mugshot = MegaMan
  msgOpen
  """
  3つ目のクロスを
  せんたくしてね
  """
  keyWait
    any = false
  clearMsg
  jump
    target = 5
}

script 3 mmbn6 {
  mugshotShow
    mugshot = MegaMan
  msgOpen
  """
  4つ目のクロスを
  せんたくしてね
  """
  keyWait
    any = false
  clearMsg
  jump
    target = 5
}

script 4 mmbn6 {
  mugshotShow
    mugshot = MegaMan
  msgOpen
  """
  5つ目のクロスを
  せんたくしてね
  """
  keyWait
    any = false
  clearMsg
  jump
    target = 5
}

/*
0 1 2 3
4 5 6
7 8 9
*/

script 5 mmbn6 {
  msgOpen
  textSpeed
    delay = 0

  option // 0
    brackets = 0
    left = 3
    right = 1
    up = 7
    down = 4
  space
    count = 1
  "ヒート"

  option // 1
    brackets = 0
    left = 0
    right = 2
    up = 8
    down = 5
  space
    count = 1
  "エレキ"

  option // 2
    brackets = 0
    left = 1
    right = 3
    up = 9
    down = 6
  space
    count = 1
  "スラッシュ"

  option // 3
    brackets = 0
    left = 2
    right = 0
    up = 9
    down = 6
  space
    count = 1
  "キラー\n"

  option // 4
    brackets = 0
    left = 6
    right = 5
    up = 0
    down = 7
  space
    count = 1
  "チャージ"

  option // 5
    brackets = 0
    left = 4
    right = 6
    up = 1
    down = 8
  space
    count = 1
  "アクア"

  option // 6
    brackets = 0
    left = 5
    right = 4
    up = 3
    down = 9
  space
    count = 1
  "トマホーク\n"

  option // 7
    brackets = 0
    left = 9
    right = 8
    up = 4
    down = 0
  space
    count = 1
  "テング"

  option // 8
    brackets = 0
    left = 7
    right = 9
    up = 5
    down = 1
  space
    count = 1
  "グランド"

  option // 9
    brackets = 0
    left = 8
    right = 7
    up = 6
    down = 3
  space
    count = 1
  "ダスト"

	textSpeed
		delay = 2

  soundDisableChoiceSFX
	select
		default = 0
		BSeparate = true
		disableB = false
		clear = false
		targets = [
			jump = 6,
			jump = 7,
			jump = 8,
			jump = 9,
			jump = 10,
			jump = 11,
			jump = 12,
			jump = 13,
			jump = 14,
			jump = 15,
      jump = continue
		]
  clearMsg
  "クロスのせんたくをやめる?\n"
	positionOptionHorizontal
		width = 8
	option
		brackets = 0
		left = 1
		right = 1
		up = 0
		down = 0
	space
		count = 1
	" はい  "
	option
		brackets = 0
		left = 0
		right = 0
		up = 1
		down = 1
	space
		count = 1
	" いいえ"
	select
		default = 0
		BSeparate = false
		disableB = false
		clear = true
		targets = [
			jump = 20,
			jump = continue,
			jump = continue
		]
  soundDisableTextSFX
  soundPlay
    track = 103
	soundEnableTextSFX
  jump
    target = 18
}

script 6 mmbn6 {
  storeGlobal
    global = 0
    value = 1
  jump
    target = 16
}

script 7 mmbn6 {
  storeGlobal
    global = 0
    value = 2
  jump
    target = 16
}

script 8 mmbn6 {
  storeGlobal
    global = 0
    value = 3
  jump
    target = 16
}

script 9 mmbn6 {
  storeGlobal
    global = 0
    value = 4
  jump
    target = 16
}

script 10 mmbn6 {
  storeGlobal
    global = 0
    value = 5
  jump
    target = 16
}

script 11 mmbn6 {
  storeGlobal
    global = 0
    value = 6
  jump
    target = 16
}

script 12 mmbn6 {
  storeGlobal
    global = 0
    value = 7
  jump
    target = 16
}

script 13 mmbn6 {
  storeGlobal
    global = 0
    value = 8
  jump
    target = 16
}

script 14 mmbn6 {
  storeGlobal
    global = 0
    value = 9
  jump
    target = 16
}

script 15 mmbn6 {
  storeGlobal
    global = 0
    value = 10
  jump
    target = 16
}

script 16 mmbn6 {
  soundDisableTextSFX

  storeTimer
    timer = 0
    value = 1
  waitOWVar
    variable = 0
    value = 0
  checkGlobal
    variable = 2
    value = 1
    jumpIfEqual = 17
    jumpIfNotEqual = continue
	soundPlay
		track = 386
	soundEnableTextSFX
  jump
    target = 18
}

script 17 mmbn6 {
	soundPlay
		track = 105
	soundEnableTextSFX
  storeGlobal
    global = 2
    value = 0
  """
  このクロスはもう選ばれてるよ!
  """
  keyWait
    any = false
  clearMsg
  jump
    target = 5
}

script 18 mmbn6 {
  checkGlobal
    variable = 1
    value = 0
    jumpIfEqual = 0
    jumpIfNotEqual = continue
  checkGlobal
    variable = 1
    value = 1
    jumpIfEqual = 1
    jumpIfNotEqual = continue
  checkGlobal
    variable = 1
    value = 2
    jumpIfEqual = 2
    jumpIfNotEqual = continue
  checkGlobal
    variable = 1
    value = 3
    jumpIfEqual = 3
    jumpIfNotEqual = continue
  checkGlobal
    variable = 1
    value = 4
    jumpIfEqual = 4
    jumpIfNotEqual = continue
  checkGlobal
    variable = 1
    value = 5
    jumpIfEqual = 19
    jumpIfNotEqual = continue
}

script 19 mmbn6 {
  """
  クロスせんたくかんりょう!
  """
  keyWait
    any = false
  clearMsg
  end
}

script 20 mmbn6 {
  soundDisableTextSFX
  soundPlay
    track = 104
	soundEnableTextSFX
  """
  クロスせんたくを
  キャンセルしました
  """
  keyWait
    any = false
  storeTimer
    timer = 0
    value = 1
  storeTimer
    timer = 1
    value = 1
  waitOWVar
    variable = 0
    value = 0
  clearMsg
  end
}
