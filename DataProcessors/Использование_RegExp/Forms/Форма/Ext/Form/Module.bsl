﻿
&НаСервере
Процедура ExecuteНаСервере()
	RegExp = Новый COMОбъект("VBScript.RegExp");
	RegExp.Pattern = Объект.РегулярноеВыражение;
	RegExp.Global = Истина;
	RegExp.MultiLine = Истина;
	Matches = RegExp.Execute(Объект.ИсходнаяСтрока);
	
	Результат = "";
	Для Счетчик = 0 По Matches.Count - 1 Цикл 
    	Результат = Результат + Matches.Item(Счетчик).Value + Символы.ПС;
	КонецЦикла;
	Объект.Результат = Результат;
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаExecute(Команда)
	ExecuteНаСервере();
КонецПроцедуры
