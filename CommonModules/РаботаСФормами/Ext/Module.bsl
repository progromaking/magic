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

