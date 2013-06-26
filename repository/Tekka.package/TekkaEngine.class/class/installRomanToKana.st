class initialization
installRomanToKana
	"TekkaEngine installRomanToKana"
	
	| dict composer |
	dict := Dictionary new.
	composer := [ :consonant :kanas | dict at: consonant put: (kanas asArray collect: [ :kana | kana asString collect: [ :c | self character: c asciiValue]])].
	composer value: '' value: 'あいうえお'.
	composer value: 'b' value: 'ばびぶべぼ'.
	composer value: 'by' value: #('びゃ' 'びぃ' 'びゅ' 'びぇ' 'びょ').
	composer value: 'cy' value: #('ちゃ' 'ちぃ' 'ちゅ' 'ちぇ' 'ちょ').
	composer value: 'ch' value: #('ちゃ' 'ち' 'ちゅ' 'ちぇ' 'ちょ').
	composer value: 'd' value: 'だぢづでど'.
	composer value: 'dy' value: #('ぢゃ' 'ぢぃ' 'ぢゅ' 'ぢぇ' 'ぢょ').
	composer value: 'dh' value: #('でゃ' 'でぃ' 'でゅ' 'でぇ' 'でょ').
	composer value: 'f' value: #('ふぁ' 'ふぃ' 'ふ' 'ふぇ' 'ふぉ').
	composer value: 'fy' value: #('ふゃ' 'ふぃ' 'ふゅ' 'ふぇ' 'ふょ').
	composer value: 'g' value: 'がぎぐげご'.
	composer value: 'gy' value: #('ぎゃ' 'ぎぃ' 'ぎゅ' 'ぎぇ' 'ぎょ').
	composer value: 'h' value: 'はひふへほ'.
	composer value: 'hy' value: #('ひゃ' 'ひぃ' 'ひゅ' 'ひぇ' 'ひょ').
	composer value: 'j' value: #('じゃ' 'じ' 'じゅ' 'じぇ' 'じょ').
	composer value: 'jy' value: #('じゃ' 'じぃ' 'じゅ' 'じぇ' 'じょ').
	composer value: 'k' value: 'かきくけこ'.
	composer value: 'ky' value: #('きゃ' 'きぃ' 'きゅ' 'きぇ' 'きょ').
	composer value: 'l' value: 'らりるれろ'.
	composer value: 'ly' value: #('りゃ' 'りぃ' 'りゅ' 'りぇ' 'りょ').
	composer value: 'm' value: 'まみむめも'.
	composer value: 'my' value: #('みゃ' 'みぃ' 'みゅ' 'みぇ' 'みょ').
	composer value: 'n' value: 'なにぬねの'.
	composer value: 'ny' value: #('にゃ' 'にぃ' 'にゅ' 'にぇ' 'にょ').
	composer value: 'p' value: 'ぱぴぷぺぽ'.
	composer value: 'py' value: #('ぴゃ' 'ぴぃ' 'ぴゅ' 'ぴぇ' 'ぴょ').
	composer value: 'q' value: #('くぁ' 'くぃ' 'くぅ' 'くぇ' 'くぉ').
	composer value: 'r' value: 'らりるれろ'.
	composer value: 'ry' value: #('りゃ' 'りぃ' 'りゅ' 'りぇ' 'りょ').
	composer value: 's' value: 'さしすせそ'.
	composer value: 'sh' value: #('しゃ' 'し' 'しゅ' 'しぇ' 'しょ').
	composer value: 'sy' value: #('しゃ' 'しぃ' 'しゅ' 'しぇ' 'しょ').
	composer value: 't' value: 'たちつてと'.
	composer value: 'th' value: #('てゃ' 'てぃ' 'てゅ' 'てぇ' 'てょ').
	composer value: 'ty' value: #('ちゃ' 'ちぃ' 'ちゅ' 'ちぇ' 'ちょ').
	composer value: 'v' value: #('ゔぁ' 'ゔぃ' 'ゔ' 'ゔぇ' 'ゔぉ').
	composer value: 'vy' value: #('ゔゃ' 'ゔぃ' 'ゔゅ' 'ゔぇ' 'ゔょ').
	composer value: 'w' value: #('わ' 'うぃ' 'う' 'うぇ' 'を').
	composer value: 'wh' value: #('うぁ' 'うぃ' 'う' 'うぇ' 'うぉ').
	composer value: 'x' value: 'ぁぃぅぇぉ'.
	composer value: 'xt' value: #('xta' 'xti'  'っ' 'xte' 'xto').
	composer value: 'xw' value: 'ゎぃぅぇぉ'.
	composer value: 'xy' value: 'ゃぃゅぇょ'.
	composer value: 'y' value: #('や' 'い' 'ゆ' 'いぇ' 'よ').
	composer value: 'z' value: 'ざじずぜぞ'.
	composer value: 'zy' value: #('じゃ' 'じぃ' 'じゅ' 'じぇ' 'じょ').
	^ RomanToKana := dict