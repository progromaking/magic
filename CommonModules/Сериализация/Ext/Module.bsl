﻿
Функция Объект_в_XDTO(СериализуемыйОбъект) Экспорт
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	Возврат Сериализатор.ЗаписатьXDTO(СериализуемыйОбъект);	
	
КонецФункции

Функция Объект_в_строку(СериализуемыйОбъект) Экспорт
	
	ОбъектXDTO = Объект_в_XDTO(СериализуемыйОбъект);
	
	Возврат XDTO_в_строку(ОбъектXDTO);
	
КонецФункции

Функция Объект_в_XML(СериализуемыйОбъект) Экспорт
	
	Строка = Объект_в_строку(СериализуемыйОбъект);
	
	Возврат Строка_в_XML(Строка);
	
КонецФункции

Функция Объект_в_DOM(СериализуемыйОбъект) Экспорт
	
	ОбъектXDTO = Объект_в_XDTO(СериализуемыйОбъект);
	
	Возврат  XDTO_в_DOM(ОбъектXDTO);
	
КонецФункции


Функция XDTO_в_объект(ОбъектXDTO) Экспорт
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	
	Возврат Сериализатор.ПрочитатьXDTO(ОбъектXDTO);	
	
	
КонецФункции

Функция XDTO_в_строку(ОбъектXDTO) Экспорт
	
	ЗаписьXML = Новый ЗаписьXML; 
	ЗаписьXML.УстановитьСтроку("UTF-8"); 
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ФабрикаXDTO.ЗаписатьXML(ЗаписьXML, ОбъектXDTO,,,,НазначениеТипаXML.Явное); 
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции

Функция XDTO_в_XML(ОбъектXDTO) Экспорт
	
	Строка = XDTO_в_строку(ОбъектXDTO);
	
	Возврат Строка_в_XML(Строка);
	
КонецФункции

Функция XDTO_в_DOM(ОбъектXDTO) Экспорт
	
	ЧтениеXML = XDTO_в_XML(ОбъектXDTO);
	
	Возврат XML_в_DOM(ЧтениеXML);
	
КонецФункции


Функция Строка_в_объект(Строка) Экспорт
	
	ОбъектXDTO = Строка_в_XDTO(Строка);
	
	Возврат XDTO_в_объект(ОбъектXDTO);
	
КонецФункции

Функция Строка_в_XDTO(Строка) Экспорт
	
	ЧтениеXML = Строка_в_XML(Строка);
	
	Возврат ФабрикаXDTO.ПрочитатьXML(ЧтениеXML);
	
КонецФункции

Функция Строка_в_XML(Строка) Экспорт
	
	ЧтениеXML=Новый ЧтениеXML(); 
	ЧтениеXML.УстановитьСтроку(Строка);
	ЧтениеXML.Прочитать();
	
	Возврат ЧтениеXML;
	
КонецФункции

Функция Строка_в_DOM(Строка) Экспорт
	
	ЧтениеXML = Строка_в_XML(Строка);
	ПостроительDOM = Новый ПостроительDOM;
	
	Возврат ПостроительDOM.Прочитать(ЧтениеXML);
	
	
КонецФункции


Функция XML_в_DOM(ЧтениеXML) Экспорт
	
	ПостроительDOM = Новый ПостроительDOM;
	
	Возврат ПостроительDOM.Прочитать(ЧтениеXML);
	
КонецФункции


Функция DOM_в_объект(ОбъектDOM) Экспорт
	
	Строка = DOM_в_строку(ОбъектDOM);
	
	Возврат Строка_в_объект(Строка);
	
КонецФункции

Функция DOM_в_XDTO(ОбъектDOM) Экспорт
	
	Строка = DOM_в_строку(ОбъектDOM);
	
	Возврат Строка_в_XDTO(Строка);
	
КонецФункции

Функция DOM_в_строку(ОбъектDOM) Экспорт
	
	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.УстановитьСтроку("UTF-8"); 
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	
	ЗаписьDOM = Новый ЗаписьDOM();
	ЗаписьDOM.Записать(ОбъектDOM.ПервыйДочерний, ЗаписьXML);
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции

Функция ПолучитьОбъектИзФайлаXML(ПутьКФайлу) Экспорт
	
	ЧтениеXML= Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ПутьКФайлу);

	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	Возврат Сериализатор.ПрочитатьXML(ЧтениеXML);
	
КонецФункции
Процедура СохранитьОбъектВФайлXML(Объект, ПутьКФайлу) Экспорт 
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	ЗаписьXML = Новый ЗаписьXML; 
	ЗаписьXML.ОткрытьФайл(ПутьКФайлу);
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	Сериализатор.ЗаписатьXML(ЗаписьXML, Объект);
	
КонецПроцедуры

Функция СериализоватьОбъектВXML(СериализуемыйОбъект) Экспорт
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	ОбъектXDTO = Сериализатор.ЗаписатьXDTO(СериализуемыйОбъект);	
	
	ЗаписьXML = Новый ЗаписьXML; 
	ЗаписьXML.УстановитьСтроку("UTF-8"); 
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ФабрикаXDTO.ЗаписатьXML(ЗаписьXML, ОбъектXDTO,,,,НазначениеТипаXML.Явное); 
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции
Функция ДесериализоватьОбъектИзXML(Строка) Экспорт
	
	ЧтениеXML=Новый ЧтениеXML(); 
	ЧтениеXML.УстановитьСтроку(Строка);
	ЧтениеXML.Прочитать();
	
	ОбъектXDTO = ФабрикаXDTO.ПрочитатьXML(ЧтениеXML);
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	
	Возврат Сериализатор.ПрочитатьXDTO(ОбъектXDTO);	
	
КонецФункции

// json
Функция ОбъектВСтрокуJSON(СериализуемыйОбъект)
	
	КопияОбъекта = КопияКоллекции(СериализуемыйОбъект);
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	
	ЗаписатьJSON(ЗаписьJSON, КопияОбъекта); 
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции
Функция КопияКоллекции(ИсходныйОбъект)
	
	Если ТипЗнч(ИсходныйОбъект) = Тип("Структура") Тогда
		Результат = Новый Структура;
		
		Для каждого КлючИЗначение из ИсходныйОбъект Цикл
			Результат.Вставить(КлючИЗначение.Ключ, КопияКоллекции(КлючИЗначение.Значение));
		КонецЦикла;
		
	ИначеЕсли ТипЗнч(ИсходныйОбъект) = Тип("Массив") Тогда
		Результат = Новый Массив;
		
		Для каждого ЭлементМассива из ИсходныйОбъект Цикл
			Результат.Добавить(КопияКоллекции(ЭлементМассива));
		КонецЦикла;
		
	ИначеЕсли ТипЗнч(ИсходныйОбъект) = Тип("УправляемаяФорма") Тогда
		Результат = ИсходныйОбъект.ИмяФормы;
		
	ИначеЕсли ТипЗнч(ИсходныйОбъект) = Тип("COMОбъект") Тогда
		Результат = Строка(ИсходныйОбъект);
		
	Иначе
		Результат = ИсходныйОбъект;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ЗначениеСтрокой(Значение)
	
	Если ТипЗнч(Значение) = Тип("ХранилищеЗначения") Тогда
		Результат = ЗначениеСтрокой(Значение.Получить());
		
	ИначеЕсли ТипЗнч(Значение) = Тип("Структура") Тогда
		Результат = "";
		Для Каждого КлючИЗначение Из Значение Цикл
			Результат = Результат + Символы.ПС 
				+ КлючИЗначение.Ключ + " : " + ЗначениеСтрокой(КлючИЗначение.Значение);
		КонецЦикла;
		
	ИначеЕсли ТипЗнч(Значение) = Тип("Массив") Тогда
		Результат = "";
		Для Каждого Строка Из Значение Цикл
			Результат = Результат + Символы.ПС + Строка;
		КонецЦикла;
		
	Иначе
		Результат = Строка(Значение);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьСтруктуруИзСтрокиJSON(СтрокаJSON)
	
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(СтрокаJSON);
	Возврат ПрочитатьJSON(Чтение, Ложь);
	
КонецФункции
Функция ПолучитьСтрокуJSONИзСтруктуры(Структура)
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Структура); 
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции

// диагностика ошибок сериализации json
Функция ОшибкиСериализации(Коллекция)
	
	НекорректныеЗначения = Новый Массив;
	
	СобратьОшибкиВКоллекцииРекурсивно(Коллекция, НекорректныеЗначения);
	
	Результат = Символы.ПС;
	Для каждого Строка из НекорректныеЗначения Цикл
		Результат = Результат + "Путь: " + Строка.Путь 
					+ Символы.ПС + "Некорректный тип: " + Строка.Тип 
					+ Символы.ПС + "Некорректное значение: " + Строка.Значение 
					+ Символы.ПС 
					+ Символы.ПС;
	КонецЦикла;
				
	Возврат Результат;			
	
КонецФункции

Процедура СобратьОшибкиВКоллекцииРекурсивно(Коллекция, НекорректныеЗначения, Путь = "")
	
	Если ТипЗнч(Коллекция) = Тип("Булево") Тогда
		Возврат;
	ИначеЕсли ТипЗнч(Коллекция) = Тип("Число") Тогда
		Возврат;
	ИначеЕсли ТипЗнч(Коллекция) = Тип("Строка") Тогда
		Возврат;
	ИначеЕсли ТипЗнч(Коллекция) = Тип("Дата") Тогда
		Возврат;
	ИначеЕсли Коллекция = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Коллекция) = Тип("Массив") Тогда
		Для сч = 0 по Коллекция.ВГраница() Цикл
			Элемент = Коллекция[сч];
			ПутьКЭлементу = Путь + "/" + сч;
			СобратьОшибкиВКоллекцииРекурсивно(Элемент, НекорректныеЗначения, ПутьКЭлементу);
		КонецЦикла;
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Коллекция) = Тип("Структура") 
		ИЛИ ТипЗнч(Коллекция) = Тип("Соответствие") Тогда
		Для каждого КлючИЗначение из Коллекция Цикл
			ПутьКЭлементу = Путь + "/" + КлючИЗначение.Ключ;
			СобратьОшибкиВКоллекцииРекурсивно(КлючИЗначение.Значение, НекорректныеЗначения, ПутьКЭлементу);
		КонецЦикла;
		Возврат;
	КонецЕсли;
	
	Если Коллекция = NULL Тогда
		Значение = "NULL";
	Иначе
		Значение = Строка(Коллекция);
	КонецЕсли;
	
	ОписаниеОшибки = Новый Структура;
	ОписаниеОшибки.Вставить("Путь", Путь);
	ОписаниеОшибки.Вставить("Тип", ТипЗнч(Коллекция));
	ОписаниеОшибки.Вставить("Значение", Значение);
	
	НекорректныеЗначения.Добавить(ОписаниеОшибки);
	
КонецПроцедуры



