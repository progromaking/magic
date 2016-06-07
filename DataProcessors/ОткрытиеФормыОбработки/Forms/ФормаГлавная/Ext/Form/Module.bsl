﻿
&НаКлиенте
Процедура ОткрытьФорму_Вариант1(Команда)
	// если форма в текущей обработке
	
	ИмяОткрываемойФормы = "МояФорма";
	ПараметрыОткрываемойФормы = Новый Структура();
	
	ПолноеИмяФормы = ПолучитьПолноеИмяФормы(ИмяОткрываемойФормы);
	ОткрытаяФорма = ОткрытьФорму(ПолноеИмяФормы, ПараметрыОткрываемойФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФорму_Вариант2(Команда)
	// если форма в какой-то внешней обработке
	
	ИмяОткрываемойФормы = "МояФорма";
	ПараметрыОткрываемойФормы = Новый Структура();
	
	Путь = "C:\Обработка.epf";
	ИмяОбработки = ПодключитьВнешнююОбработкуНаКлиенте(Путь);
	
	ПолноеИмяФормы = "ВнешняяОбработка."+ ИмяОбработки +".Форма."+ИмяОткрываемойФормы;	
	ОткрытаяФорма = ОткрытьФорму(ПолноеИмяФормы, ПараметрыОткрываемойФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФорму_Вариант3(Команда)
	// если данная внешняя обработка содержит динамический список объектов и форму объекта
	
	Ссылка = Элементы.Список.ТекущаяСтрока;
	ПараметрыОткрываемойФормы = Новый Структура();
	ПараметрыОткрываемойФормы.Вставить("Ключ", Ссылка);	
	
	//Путь = "C:\Документ_ЗаказПоставщику_ФормаДокумента.epf";
	//ИмяОбработки = ПодключитьВнешнююОбработкуНаКлиенте(Путь);
	
	ИмяОткрываемойФормы = "ФормаДокумента";
	ПолноеИмяФормы = ПолучитьПолноеИмяФормы(ИмяОткрываемойФормы);
	ОткрытаяФорма = ОткрытьФорму(ПолноеИмяФормы, ПараметрыОткрываемойФормы);
	
КонецПроцедуры

// Вспомогательные функции

&НаСервере 
Функция ПолучитьПолноеИмяФормы(ИмяФормы)
	// ** coded by Sergey (aka Porutchik) * 2012, forum.aeroion.ru/

    СимволТочка = ".";
    ПозицияТочки = СтрДлина(ЭтаФорма.ИмяФормы);
    Пока Сред(ЭтаФорма.ИмяФормы, ПозицияТочки, 1) <> СимволТочка Цикл ПозицияТочки = ПозицияТочки - 1; КонецЦикла; //
    Возврат Лев(ЭтаФорма.ИмяФормы, ПозицияТочки) + ИмяФормы;

КонецФункции

&НаКлиенте
Функция ПодключитьВнешнююОбработкуНаКлиенте(ПутьКФайлуНаКлиенте)
    АдресХранилища = "";
	ПоместитьФайл(АдресХранилища, ПутьКФайлуНаКлиенте, , Ложь);
	ИмяОбработки = ПодключитьВнешнююОбработкуНаСервере(АдресХранилища);
	Возврат ИмяОбработки;
КонецФункции

&НаСервере
Функция ПодключитьВнешнююОбработкуНаСервере(АдресХранилища)
	Возврат ВнешниеОбработки.Подключить(АдресХранилища,,Ложь);
КонецФункции

