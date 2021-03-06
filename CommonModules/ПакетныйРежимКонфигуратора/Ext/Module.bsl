﻿
#Область _ // Команды пакетного режима

Процедура ВыгрузитьФайлыКонфигурации(Параметры) Экспорт
	
	Если Параметры.Свойство("КаталогФайлов") = Ложь Тогда
		ВызватьИсключение "Не указан каталог для выгрузки файлов";
	КонецЕсли;
	
	Команда = 
		СтрокаЗапускаКонфигуратораВПакетномРежиме(Параметры)
		+ " /DumpConfigFiles %КаталогФайлов% -Module ";
		
	ПодставитьПараметрыВКоманду(Команда, Параметры);
	
	ВыполнитьИзКоманднойСтроки(Команда);
	
КонецПроцедуры

Процедура ЗагрузитьФайлыКонфигурации(Параметры) Экспорт
	
	Если Параметры.Свойство("КаталогФайлов") = Ложь Тогда
		ВызватьИсключение "Не указан каталог с загружаемыми файлами";
	КонецЕсли;
	
	Команда = 
		СтрокаЗапускаКонфигуратораВПакетномРежиме(Параметры)
		+ " /LoadConfigFiles %КаталогФайлов% -Module ";
		
	ПодставитьПараметрыВКоманду(Команда, Параметры);
	
	ВыполнитьИзКоманднойСтроки(Команда);
	
КонецПроцедуры

#КонецОбласти

#Область _ // Сервисные методы
	
Процедура ВыполнитьИзКоманднойСтроки(Команда)
	
	КодВозврата = Неопределено;
	ЗапуститьПриложение(Команда, КаталогПрограммы(), Истина, КодВозврата);
	Если КодВозврата = Неопределено Тогда
		КодВозврата = "Неопределено";
	КонецЕсли;
	
	Сообщение = "[Код возврата: " + КодВозврата + "] : " + Команда;
	
	Если НЕ КодВозврата = 0 Тогда
		ВызватьИсключение "ОШИБКА: " + Сообщение;
	КонецЕсли;
	
КонецПроцедуры

Функция СтрокаЗапускаКонфигуратораВПакетномРежиме(Параметры)
	Если НЕ ТипЗнч(Параметры) = Тип("Структура") Тогда
		Параметры = Новый Структура;
	КонецЕсли;
	Если Параметры.Свойство("ПутьК1С") = Ложь Тогда
		Параметры.Вставить("ПутьК1С", КаталогПрограммы() + "1cv8.exe");
	КонецЕсли;
	Если Параметры.Свойство("КаталогИБ") = Ложь Тогда
		Параметры.Вставить("КаталогИБ", КаталогТекущейИБ());
	КонецЕсли;
	Если Параметры.Свойство("ПользовательИБ") = Ложь Тогда
		Параметры.Вставить("ПользовательИБ", "");
	КонецЕсли;
	Если Параметры.Свойство("ПарольИБ") = Ложь Тогда
		Параметры.Вставить("ПарольИБ", "");
	КонецЕсли;
	
	Команда = 
		"%ПутьК1С%   DESIGNER "
		+ " /F %КаталогИБ% "
		+ " /N %ПользовательИБ% "
		+ " /P %ПарольИБ% "
		+ " /DisableStartupDialogs ";
		
	ПодставитьПараметрыВКоманду(Команда, Параметры);
	
	Возврат Команда;
	
КонецФункции

Процедура ПодставитьПараметрыВКоманду(Команда, Параметры)
	
	ОбернутьПараметрыКомандыВКавычки(Команда);
	
	Для каждого КлючИЗначение из Параметры Цикл
		ИмяПараметра = КлючИЗначение.Ключ;
		Команда = СтрЗаменить(Команда, "%"+ИмяПараметра+"%", Параметры[ИмяПараметра]);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбернутьПараметрыКомандыВКавычки(вхКоманда)
	Команда = " " + вхКоманда + " ";
	Команда = СтрЗаменить(Команда, " %", " ""%");
	Команда = СтрЗаменить(Команда, "% ", "%"" ");
	
	вхКоманда = СокрЛП(Команда);
КонецПроцедуры

Функция КаталогТекущейИБ()
	
	Путь = СтрокаСоединенияИнформационнойБазы();
	Путь = СтрЗаменить(Путь, "File=", "");
	Путь = СтрЗаменить(Путь, """", "");
	Путь = СтрЗаменить(Путь, ";", "");
	
	Возврат Путь;
	
КонецФункции

#КонецОбласти
