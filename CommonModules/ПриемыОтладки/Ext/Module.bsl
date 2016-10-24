﻿

#Область _ // Отладка общего модуля или модуля менеджера

Функция УстановитьМодульОтладки(Результат, ОтлаживаемыйМодуль = Неопределено) Экспорт
	
	ПутьКВнешнейОбработке = ТекущийКаталог() + ОтлаживаемыйМодуль + ".epf";
	
	Сообщить("Отладка из внешнего модуля: " + ПутьКВнешнейОбработке);
	
	Попытка
		Результат = ВнешниеОбработки.Создать(ПутьКВнешнейОбработке, Ложь);
	Исключение
		Сообщить("ОШИБКА: " + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Ложь;
	
КонецФункции

Функция ТекущийКаталог() Экспорт
	
	Файл = Новый Файл(Вычислить("ИспользуемоеИмяФайла"));  // чтобы везде проходил синтаксический контроль
	Возврат Файл.Путь;
	
КонецФункции


#КонецОбласти


#Область _ // Отладка форм

Функция ВосстановитьКонтекстФормы(Форма) Экспорт
	
	ПараметрыФормы = ХранилищеОбщихНастроек.Загрузить(ИмяСохраненнойНастройки());
	ЗаполнитьЗначенияСвойств(Форма.Параметры, ПараметрыФормы);
	
	ТипКлюча = "" + Форма.Параметры.Ключ;
	Если Найти(ТипКлюча, "Регистр") = 1 
		И Найти(ТипКлюча, "КлючЗаписи.") Тогда
		ИмяРеквизита = "Запись";
	ИначеЕсли Найти(ТипКлюча, "Ссылка.") Тогда
		ИмяРеквизита = "Объект";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИмяРеквизита) Тогда
		КлючФормы = Форма.РеквизитФормыВЗначение(ИмяРеквизита);
		ЗаполнитьЗначенияСвойств(КлючФормы, ПараметрыФормы.Ключ);
		Форма.ЗначениеВРеквизитФормы(КлючФормы, ИмяРеквизита);
	КонецЕсли;
	
КонецФункции

Функция СохранитьКонтекстФормы(Форма) Экспорт
	
	ПараметрыФормы = ПолучитьПараметрыУправляемойФормы(Форма);
	
	ХранилищеОбщихНастроек.Сохранить(ИмяСохраненнойНастройки(), , ПараметрыФормы);
	Возврат Ложь;
	
КонецФункции

Функция ПолучитьПараметрыУправляемойФормы(Форма)
	
	Результат = Новый Структура(	
		"ДополнительныеПараметры,
		|ЗакрыватьПриВыборе,
		|ЗакрыватьПриЗакрытииВладельца,
		|ЗначениеКопирования,
		|ЗначенияЗаполнения,
		|Ключ,
		|КлючНазначенияИспользования,
		|Основание,
		|ПараметрыВыбора,
		|ПараметрыФункциональныхОпций,
		|РежимВыбора,
		|ТекстЗаполнения,
		|ТолькоПросмотр,
		|ЭтоГруппа,
		|");
	ЗаполнитьЗначенияСвойств(Результат, Форма.Параметры);
	
	Возврат Результат;
	
КонецФункции

Функция ИмяСохраненнойНастройки()
	
	Возврат "Отладка";
	
КонецФункции

#КонецОбласти