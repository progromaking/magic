﻿
Процедура ВывестиСКДВТабличныйДокумент(МакетСКД, ТабличныйДокумент, КомпоновщикНастроек) Экспорт
	
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();  
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(МакетСКД, Настройки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ТабличныйДокумент);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
// Пример вызова из отчета	
//Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
//	
//	СтандартнаяОбработка = Ложь; 
//	ПрограммнаяРаботаССКД.ВывестиСКДВТабличныйДокумент(СхемаКомпоновкиДанных, ДокументРезультат, КомпоновщикНастроек);
//	
//КонецПроцедуры	
	
КонецПроцедуры

Функция ПолучитьТаблицуЗначенийИзСКД(МакетСКД, КомпоновщикНастроек) Экспорт
	
	Результат = Новый ТаблицаЗначений;
	
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();  
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(МакетСКД, Настройки,,,
				Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ПроцессорВывода.УстановитьОбъект(Результат);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	Возврат Результат;
	
КонецФункции


Процедура УстановитьЗначениеПараметра(ОтчетОбъект, ИмяПараметра, Значение) Экспорт
    
    ПараметрыОтчета = ОтчетОбъект.КомпоновщикНастроек.Настройки.ПараметрыДанных;
    
    Параметр = ПараметрыОтчета.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных(ИмяПараметра));
    Параметр.Использование = Истина;
    Параметр.Значение = Значение;
    
КонецПроцедуры

Функция ПолучитьЗначениеПараметра(ОтчетОбъект, ИмяПараметра) Экспорт
    
    ПараметрыОтчета = ОтчетОбъект.КомпоновщикНастроек.Настройки.ПараметрыДанных;
    
    Параметр = ПараметрыОтчета.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных(ИмяПараметра));
    Возврат Параметр.Значение;
    
КонецФункции


Процедура УстановитьЗначениеПараметраПользовательскихНастроек(ПользовательскиеНастройки, ИмяПараметра, ЗначениеПараметра) Экспорт
	
	Для Каждого Элемент Из ПользовательскиеНастройки.Элементы Цикл
		Если НЕ ТипЗнч(Элемент) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") Тогда
			Продолжить;
		КонецЕсли;
		Если НЕ ""+Элемент.Параметр = ИмяПараметра Тогда
			Продолжить;
		КонецЕсли;
		Элемент.Значение = ЗначениеПараметра;
		Элемент.Использование = Истина;
		
		Возврат;
		
	КонецЦикла;
	
	// пример вызова:
	// ПользовательскиеНастройки = ПользовательскиеНастройки = ПолучитьПользовательскиеНастройкиОтчетаНаСервере("ГПН_СправкаОНаличииНПДляСобственника");
	// УстановитьЗначениеПараметраПользовательскиНастройки(ПользовательскиеНастройки, "Период", Дата(2016,1,1));
	
КонецПроцедуры

Функция ПолучитьПользовательскиеНастройкиОтчетаНаСервере(ИмяОтчета) Экспорт
	ОтчетОбъект = Отчеты[ИмяОтчета].Создать();
	Возврат ОтчетОбъект.КомпоновщикНастроек.ПользовательскиеНастройки;
КонецФункции
