﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если НЕ Параметры.Свойство("Документ") Тогда
		Возврат;
	КонецЕсли;
	
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	ОтчетОбъект.ОбновитьСхемуКомпоновкиДанных(Параметры.Документ);
	ОтчетОбъект.УстановитьНастройкиПоУмолчанию();
	ОтчетОбъект.УстановитьПараметрКомпоновщика("Документ", Параметры.Документ);
	
	ЗначениеВРеквизитФормы(ОтчетОбъект, "Отчет");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьНастройки(Команда)
	ОбновитьНастройкиНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьНастройкиНаСервере()
	
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	ПараметрКД = ОтчетОбъект.ПолучитьПараметрКомпоновщика("Документ");
	ПараметрСКД = ОтчетОбъект.ПолучитьПараметрСКД("Документ");
	Если ПараметрКД = ПараметрСКД Тогда
		Возврат;
	КонецЕсли;
	
	ОтчетОбъект.ОбновитьСхемуКомпоновкиДанных(ПараметрКД);
	ОтчетОбъект.УстановитьНастройкиПоУмолчанию();
	ОтчетОбъект.УстановитьПараметрКомпоновщика("Документ", ПараметрКД);
	
	ЗначениеВРеквизитФормы(ОтчетОбъект, "Отчет");
	
	
КонецПроцедуры
