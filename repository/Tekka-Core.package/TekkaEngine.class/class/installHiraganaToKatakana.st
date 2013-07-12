class initialization
installHiraganaToKatakana
	"TekkaEngine installHiraganaToKatakana"
	| dict composer |
	dict := Dictionary new.
	composer := [:hiras :katas | hiras
				with: katas
				do: [:hira :kata | dict
						at: (self character: hira asciiValue)
						put: (self character: kata asciiValue)]].
	composer value: 'あいうえお' value: 'アイウエオ'.
	composer value: 'ぁぃぅぇぉ' value: 'ァィゥェォ'.
	composer value: 'ゔ' value: 'ヴ'.
	composer value: 'かきくけこ' value: 'カキクケコ'.
	composer value: 'がぎぐげご' value: 'ガギグゲゴ'.
	composer value: 'さしすせそ' value: 'サシスセソ'.
	composer value: 'ざじずぜぞ' value: 'ザジズゼゾ'.
	composer value: 'たちつてと' value: 'タチツテト'.
	composer value: 'だぢづでど' value: 'ダヂヅデド'.
	composer value: 'なにぬねの' value: 'ナニヌネノ'.
	composer value: 'はひふへほ' value: 'ハヒフヘホ'.
	composer value: 'ばびぶべぼ' value: 'バビブベボ'.
	composer value: 'ぱぴぷぺぽ' value: 'パピプペポ'.
	composer value: 'まみむめも' value: 'マミムメモ'.
	composer value: 'やゆよ' value: 'ヤユヨ'.
	composer value: 'ゃゅょ' value: 'ャュョ'.
	composer value: 'らりるれろ' value: 'ラリルレロ'.
	composer value: 'わをんっゎ' value: 'ワヲンッヮ'.
	^ HiraganaToKatakana := dict