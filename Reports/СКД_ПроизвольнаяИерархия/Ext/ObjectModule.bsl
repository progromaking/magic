﻿Процедура СформироватьОтчет(Результат) Экспорт
	
	ТаблицаДанные = Новый ТаблицаЗначений;
	ТаблицаДанные.Колонки.Добавить("Деталь", Новый ОписаниеТипов("Строка"));
	ТаблицаДанные.Колонки.Добавить("Количество", Новый ОписаниеТипов("Число"));
	
	НоваяСтрока = ТаблицаДанные.Добавить();
	НоваяСтрока.Деталь = "Болт";
	НоваяСтрока.Количество = 4;
	
	НоваяСтрока = ТаблицаДанные.Добавить();
	НоваяСтрока.Деталь = "Гайка1";
	НоваяСтрока.Количество = 5;
	
	НоваяСтрока = ТаблицаДанные.Добавить();
	НоваяСтрока.Деталь = "Гайка2";
	НоваяСтрока.Количество = 4;	
	
	ТаблицаИерархия = Новый ТаблицаЗначений;
	ТаблицаИерархия.Колонки.Добавить("Деталь", Новый ОписаниеТипов("Строка"));
	ТаблицаИерархия.Колонки.Добавить("Узел", Новый ОписаниеТипов("Строка"));
	ТаблицаИерархия.Колонки.Добавить("Количество", Новый ОписаниеТипов("Число"));
	
	НоваяСтрока = ТаблицаИерархия.Добавить();
	НоваяСтрока.Деталь = "Болт";
	НоваяСтрока.Узел = "Колесо";
	
	НоваяСтрока = ТаблицаИерархия.Добавить();
	НоваяСтрока.Деталь = "Гайка2";
	НоваяСтрока.Узел = "Колесо";	
	
	НоваяСтрока = ТаблицаИерархия.Добавить();
	НоваяСтрока.Деталь = "Гайка1";
	НоваяСтрока.Узел = "Двигатель";
	
	НоваяСтрока = ТаблицаИерархия.Добавить();
	НоваяСтрока.Деталь = "Колесо";
	НоваяСтрока.Узел = "Автомобиль";
	НоваяСтрока.Количество = 4;
	
	НоваяСтрока = ТаблицаИерархия.Добавить();
	НоваяСтрока.Деталь = "Двигатель";
	НоваяСтрока.Узел = "Автомобиль";
	НоваяСтрока.Количество = 1;
	
	НоваяСтрока = ТаблицаИерархия.Добавить();
	НоваяСтрока.Деталь = "Автомобиль";
	НоваяСтрока.Узел = "";
	НоваяСтрока.Количество = 1;
	
	Настройки = КомпоновщикНастроек.Настройки;

	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("Таблица", ТаблицаДанные);
	ВнешниеНаборыДанных.Вставить("Иерархия", ТаблицаИерархия);
		
		
	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
		
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки,ВнешниеНаборыДанных, ДанныеРасшифровки);
		
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(Результат);
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
		
КонецПроцедуры