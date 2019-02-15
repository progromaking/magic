﻿
Процедура ОткрытьУправляемуюФормуВнешнейОбработки()
	
	Файл = "G:\GIT\xUnitFor1C\xddTestRunner.epf";
	АдресХранилища = "";
	Результат = ПоместитьФайл(АдресХранилища, Файл,, Ложь);
	ИмяОбработки = ВнешниеОбработки.Подключить(АдресХранилища, "xddTestRunner", Ложь);
	Форма = ПолучитьФорму("ВнешняяОбработка."+ ИмяОбработки +".Форма.УправляемаяФорма");
	Форма.ИспользуемоеИмяФайла = Файл; // изменяем используемое имя файла, чтобы загружались плагины
	Форма.Открыть();
	
КонецПроцедуры


Функция НайтиОткрытуюФормуПоИмени(ИмяНужнойФормы)
// Пример вызова: ФормаНоменклатуры = НайтиОткрытуюФормуПоИмени("Справочник.Номенклатура.Форма.ФормаЭлемента");
	
	ВсеОкна = ПолучитьОкна();
	Для каждого ТекущееОкно из ВсеОкна Цикл
		
		Для каждого Форма из ТекущееОкно.Содержимое Цикл
			Если НРег(Форма.ИмяФормы) = НРег(ИмяНужнойФормы) Тогда
				Возврат Форма;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуЗаписиРегистра()
	Измерения = Новый Структура;
	Измерения.Вставить("Период", Период);
	Измерения.Вставить("Номенклатура", Номенклатура);

	ПараметрыМассив = Новый Массив;
	ПараметрыМассив.Добавить(Измерения);
	КлючЗаписи = Новый("РегистрСведенийКлючЗаписи.Регистр1", ПараметрыМассив);
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Ключ", КлючЗаписи);
	ОткрытьФорму("РегистрСведений.Регистр1.ФормаЗаписи", ПараметрыОткрытия);

КонецПроцедуры

&НаСервере
Функция ПолноеИмяФормы(ЭтаФорма, КраткоеИмяФормы) Экспорт
	
    ПозицияТочки = СтрДлина(ЭтаФорма.ИмяФормы);
    Пока Сред(ЭтаФорма.ИмяФормы, ПозицияТочки, 1) <> "." Цикл ПозицияТочки = ПозицияТочки - 1; КонецЦикла; //
    Возврат Лев(ЭтаФорма.ИмяФормы, ПозицияТочки) + КраткоеИмяФормы;
	
КонецФункции
