﻿
Процедура ПолучениеДлиныСтрокиВЗапросеМетодомПоловинногоДеления()
	// из комментария к статье на ИС: http://forum.infostart.ru/forum24/topic143725/message1479873/#message1479873
	
	
	ТекстЗапроса = 
	"
	|ВЫБРАТЬ
	|    ""12345678901234567890123456789012345678901234567890"" КАК Стр,
	|    1023 КАК Х
	|ПОМЕСТИТЬ Дано
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|    Стр, Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -   0, 1) = """" ТОГДА Х -   1 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -   1, 1) = """" ТОГДА Х -   2 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -   3, 1) = """" ТОГДА Х -   4 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -   7, 1) = """" ТОГДА Х -   8 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -  15, 1) = """" ТОГДА Х -  16 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -  31, 1) = """" ТОГДА Х -  32 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х -  63, 1) = """" ТОГДА Х -  64 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х - 127, 1) = """" ТОГДА Х - 128 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х - 255, 1) = """" ТОГДА Х - 256 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    (ВЫБРАТЬ Стр, ВЫБОР КОГДА ПОДСТРОКА(Стр, Х - 511, 1) = """" ТОГДА Х - 512 ИНАЧЕ Х КОНЕЦ КАК Х
	|ИЗ    Дано КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ) КАК ВЗ
	|";
	
КонецПроцедуры
