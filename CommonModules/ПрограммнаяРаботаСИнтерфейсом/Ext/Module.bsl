﻿
#Область _ // Добавление элементов управляемой формы

Процедура ПримерДобавленияЭлементовНаФорму(Форма)
	Элементы = Форма.Элементы;
	ЭтаФорма = Форма;
	
	// Панель страниц
    ЭлементСтраницы = Элементы.Добавить("ГруппаСтраницы1", Тип("ГруппаФормы"), ЭтаФорма);
    ЭлементСтраницы.Вид = ВидГруппыФормы.Страницы;
    ЭлементСтраницы.Заголовок = "Группа страниц";
	
	// Страница
    ЭлементСтраница =Элементы.Добавить("Страница1", Тип("ГруппаФормы"), ЭлементСтраницы);
    ЭлементСтраница.Вид = ВидГруппыФормы.Страница;
    ЭлементСтраница.Заголовок = "Страница 1";
	
	// Декорация надпись
  	Надпись = Элементы.Добавить("ДекорацияНадпись1", Тип("ДекорацияФормы"), ЭлементСтраница);
    Надпись.Вид = ВидДекорацииФормы.Надпись;
	
	
	// Группа формы
	ЭлементГруппа = Элементы.Добавить("Группа1", Тип("ГруппаФормы"), ЭлементСтраница);
	ЭлементГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ЭлементГруппа.ОтображатьЗаголовок = Ложь;
	ЭлементГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
	
	// Кнопка (гиперссылка)
	Кнопка = Элементы.Добавить("Кнопка1", Тип("КнопкаФормы"), ЭлементСтраница);
	Кнопка.ИмяКоманды = "Команда1";
	Кнопка.Вид = ВидКнопкиФормы.Гиперссылка;
	
	// Динамический список
	ИмяРеквизита = "Список1";
	ДобавляемыеРеквизиты = Новый Массив;
	Реквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("ДинамическийСписок"));
	ДобавляемыеРеквизиты.Добавить(Реквизит);
	ЭтаФорма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	Список = ЭтаФорма[ИмяРеквизита];
	Список.ОсновнаяТаблица = "Справочник.Номенклатура";
	
	ЭлементСписок = Элементы.Добавить("Список1", Тип("ТаблицаФормы"), ЭлементСтраница);
	ЭлементСписок.ПутьКДанным = ИмяРеквизита;
	
	ЭлементКолонка = Элементы.Добавить(ЭлементСписок.Имя + "Ссылка", Тип("ПолеФормы"), ЭлементСписок);
	ЭлементКолонка.ПутьКДанным = ИмяРеквизита+".Ссылка";
	
	// Отбор динамического списка
	ЭлементПоле = Элементы.Добавить("Отбор1", Тип("ПолеФормы"), ЭлементСтраница);
	ЭлементПоле.ПутьКДанным = "Список1.Отбор";
	ЭлементПоле.Вид = ВидПоляФормы.ПолеВвода;
	
	// Командная панель
	ЭлементКоманднаяПанель = Элементы.Добавить("КоманднаяПанель1", Тип("ГруппаФормы"), ЭлементСтраница);
	ЭлементКоманднаяПанель.Вид = ВидГруппыФормы.КоманднаяПанель;
	
	Кнопка = Элементы.Добавить(ЭлементКоманднаяПанель.Имя+"Создать", Тип("КнопкаФормы"), ЭлементКоманднаяПанель);
	Кнопка.Вид = ВидКнопкиФормы.КнопкаКоманднойПанели;
	Кнопка.ИмяКоманды = ИмяРеквизита+".Создать";
	
	
КонецПроцедуры


#КонецОбласти

#Область _ // Создание колонок табличного поля по таблице значений

Процедура ОбновитьТаблицуНаФормеПоТаблицеЗначений(Форма, ИмяТаблицы, ТаблицаЗначений) Экспорт
	
	НайтиСоздатьРеквизитФормыТаблица(Форма, ИмяТаблицы);
	
	ОбновитьКолонкиТаблицыРеквизита(Форма, ИмяТаблицы, ТаблицаЗначений);
	
	Форма[ИмяТаблицы].Загрузить(ТаблицаЗначений);
	
	НайтиСоздатьТабличноеПолеНаФорме(Форма, ИмяТаблицы);
	
	ОбновитьКолонкиТабличногоПоля(Форма, ИмяТаблицы);
	
КонецПроцедуры

#Область _// Работа с реквизитами формы

Процедура НайтиСоздатьРеквизитФормыТаблица(Форма, ИмяТаблицы)
	
	Буфер = Новый Структура(ИмяТаблицы);
	ЗаполнитьЗначенияСвойств(Буфер, Форма);
	Если НЕ Буфер[ИмяТаблицы] = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДобавляемыеРеквизиты = Новый Массив;
	Реквизит = Новый РеквизитФормы(ИмяТаблицы, Новый ОписаниеТипов("ТаблицаЗначений"));
	ДобавляемыеРеквизиты.Добавить(Реквизит);
	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);	
	
КонецПроцедуры

Процедура ОбновитьКолонкиТаблицыРеквизита(Форма, ИмяТаблицы, ТаблицаЗначений)
	
	НеудаляемыеРеквизиты = Новый Массив;
	
	Реквизиты = Форма.ПолучитьРеквизиты(ИмяТаблицы);
	Для каждого Реквизит из Реквизиты Цикл
	    УдаляемыеРеквизиты = Новый Массив;
		УдаляемыеРеквизиты.Добавить(ИмяТаблицы + "." + Реквизит.Имя);
		Попытка
			Форма.ИзменитьРеквизиты( ,УдаляемыеРеквизиты);	
		Исключение
			НеудаляемыеРеквизиты.Добавить(Реквизит.Имя);
		КонецПопытки;
	КонецЦикла;
	
	
	Реквизиты = Форма.ПолучитьРеквизиты(ИмяТаблицы);
	ДобавляемыеРеквизиты = Новый Массив;
	Для каждого Колонка из ТаблицаЗначений.Колонки Цикл
		Если НЕ НеудаляемыеРеквизиты.Найти(Колонка.Имя) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
        Реквизит = Новый РеквизитФормы(Колонка.Имя, Колонка.ТипЗначения, ИмяТаблицы, Колонка.Заголовок);
		ДобавляемыеРеквизиты.Добавить(Реквизит);
	КонецЦикла;
	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);	
	
КонецПроцедуры

#КонецОбласти

#Область _// Работа с элементами формы

Процедура НайтиСоздатьТабличноеПолеНаФорме(Форма, ИмяТаблицы)
	
	Если не Форма.Элементы.Найти(ИмяТаблицы) = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицаФормы = Форма.Элементы.Добавить(ИмяТаблицы, Тип("ТаблицаФормы"));
	ТаблицаФормы.ПутьКДанным = ИмяТаблицы;
		
КонецПроцедуры

Процедура ОбновитьКолонкиТабличногоПоля(Форма, ИмяТаблицы)
	
	ТаблицаНаФорме = Форма.Элементы[ИмяТаблицы];
	КоллекцияКолонок = ТаблицаНаФорме.ПодчиненныеЭлементы;
	
	НеудаляемыеЭлементыФормы = Новый Массив; // если колонка добавлена в режиме конфигурирования, то ее нельзя удалить
	
	// 1. Удалить колонки
	КоличествоКолонок = КоллекцияКолонок.Количество() - 1;
	Для сч = -КоличествоКолонок по 0 Цикл
		Колонка = КоллекцияКолонок.Получить(-сч);
		Попытка
			Форма.Элементы.Удалить(Колонка);
		Исключение
			Буфер = Новый Структура("ПутьКДанным");
			ЗаполнитьЗначенияСвойств(Буфер, Колонка);
			НеудаляемыеЭлементыФормы.Добавить(Буфер.ПутьКДанным);
		КонецПопытки;
	КонецЦикла;
	
	// 2. Создать колонки
	ТаблицаИсточник = Вычислить("Форма."+ТаблицаНаФорме.ПутьКДанным).Выгрузить();
	Для каждого Колонка из ТаблицаИсточник.Колонки Цикл
		ИмяКолонкиФормы = ТаблицаНаФорме.Имя + Колонка.Имя;
		Если НЕ КоллекцияКолонок.Найти(ИмяКолонкиФормы) = Неопределено Тогда
			Продолжить;
		ИначеЕсли НЕ Форма.Элементы.Найти(ИмяКолонкиФормы) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ПутьКДанным = ТаблицаНаФорме.ПутьКДанным+"."+Колонка.Имя;
		Если НЕ НеудаляемыеЭлементыФормы.Найти(ПутьКДанным) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		КолонкаНаФорме = Форма.Элементы.Добавить(ИмяКолонкиФормы, Тип("ПолеФормы"), ТаблицаНаФорме);
		КолонкаНаФорме.Вид = ВидПоляФормы.ПолеВвода;
		КолонкаНаФорме.ПутьКДанным = ПутьКДанным;
		
	КонецЦикла;
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область _ // Установка типа ячейки табличного поля перед выбором

&НаКлиенте
Процедура ТаблицаНаФормеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если НЕ Элемент.ОграничениеТипа = Неопределено Тогда
		ТипЗначения = Элемент.Родитель.ТекущиеДанные.ТипЗначения;
		МассивТипов = Новый Массив;
		//МассивТипов.Добавить(Тип(ТипЗначения)); // если ТипЗначения - это ОписаниеТипов
		МассивТипов.Добавить(ТипЗначения);
		Элемент.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область _ // Динамические списки  (клиент-сервер. взято из erp21)

// Добавить или заменить существующий элемент отбора динамического списка.
//
// Параметры:
//   ДинамическийСписок - ДинамическийСписок - Список, в котором требуется установить отбор.
//   ИмяПоля            - Строка - Поле, по которому необходимо установить отбор.
//   ПравоеЗначение     - Произвольный - Значение отбора.
//       Необязательный. Значение по умолчанию: Неопределено.
//       Внимание! Если передать Неопределено, то значение не будет изменено.
//   ВидСравнения  - ВидСравненияКомпоновкиДанных - Условие отбора.
//   Представление - Строка - Представление элемента компоновки данных.
//       Необязательный. Значение по умолчанию: Неопределено.
//       Если указано, то выводится только флажок использования с указанным представлением (значение не выводится).
//       Для очистки (чтобы значение снова выводилось) следует передать пустую строку.
//   Использование - Булево - Флажок использования этого отбора.
//       Необязательный. Значение по умолчанию: Неопределено.
//   РежимОтображения - РежимОтображенияЭлементаНастройкиКомпоновкиДанных - Способ отображения этого отбора
//                                                                          пользователю.
//       * РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ - В группе быстрых настроек над списком.
//       * РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Обычный       - В настройка списка (в подменю Еще).
//       * РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный   - Запретить пользователю менять этот отбор.
//   ИдентификаторПользовательскойНастройки - Строка - Уникальный идентификатор этого отбора.
//       Используется для связи с пользовательскими настройками.
//
// См. также:
//   Одноименные свойства объекта "ЭлементОтбораКомпоновкиДанных" в синтакс-помощнике.
//
Процедура УстановитьЭлементОтбораДинамическогоСписка(ДинамическийСписок, ИмяПоля,
	ПравоеЗначение = Неопределено,
	ВидСравнения = Неопределено,
	Представление = Неопределено,
	Использование = Неопределено,
	РежимОтображения = Неопределено,
	ИдентификаторПользовательскойНастройки = Неопределено) Экспорт
	
	Если РежимОтображения = Неопределено Тогда
		РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	КонецЕсли;
	
	Если РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный Тогда
		ОтборДинамическогоСписка = ДинамическийСписок.КомпоновщикНастроек.ФиксированныеНастройки.Отбор;
	Иначе
		ОтборДинамическогоСписка = ДинамическийСписок.КомпоновщикНастроек.Настройки.Отбор;
	КонецЕсли;
	
	УстановитьЭлементОтбора(
		ОтборДинамическогоСписка,
		ИмяПоля,
		ПравоеЗначение,
		ВидСравнения,
		Представление,
		Использование,
		РежимОтображения,
		ИдентификаторПользовательскойНастройки);
	
КонецПроцедуры

// Добавить или заменить существующий элемент отбора.
//
// Параметры:
//  ОбластьПоискаДобавления - контейнер с элементами и группами отбора, например.
//                  Список.Отбор или группа в отборе.
//  ИмяПоля                 - Строка - имя поля компоновки данных (заполняется всегда).
//  ПравоеЗначение          - произвольный - сравниваемое значение.
//  ВидСравнения            - ВидСравненияКомпоновкиДанных - вид сравнения.
//  Представление           - Строка - представление элемента компоновки данных.
//  Использование           - Булево - использование элемента.
//  РежимОтображения        - РежимОтображенияЭлементаНастройкиКомпоновкиДанных - режим отображения.
//  ИдентификаторПользовательскойНастройки - Строка - см. ОтборКомпоновкиДанных.ИдентификаторПользовательскойНастройки
//                                                    в синтакс-помощнике.
//
Процедура УстановитьЭлементОтбора(ОбластьПоискаДобавления,
								Знач ИмяПоля,
								Знач ПравоеЗначение = Неопределено,
								Знач ВидСравнения = Неопределено,
								Знач Представление = Неопределено,
								Знач Использование = Неопределено,
								Знач РежимОтображения = Неопределено,
								Знач ИдентификаторПользовательскойНастройки = Неопределено) Экспорт
	
	ЧислоИзмененных = ИзменитьЭлементыОтбора(ОбластьПоискаДобавления, ИмяПоля, Представление,
							ПравоеЗначение, ВидСравнения, Использование, РежимОтображения, ИдентификаторПользовательскойНастройки);
	
	Если ЧислоИзмененных = 0 Тогда
		Если ВидСравнения = Неопределено Тогда
			Если ТипЗнч(ПравоеЗначение) = Тип("Массив")
				Или ТипЗнч(ПравоеЗначение) = Тип("ФиксированныйМассив")
				Или ТипЗнч(ПравоеЗначение) = Тип("СписокЗначений") Тогда
				ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
			Иначе
				ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
			КонецЕсли;
		КонецЕсли;
		Если РежимОтображения = Неопределено Тогда
			РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
		КонецЕсли;
		ДобавитьЭлементКомпоновки(ОбластьПоискаДобавления, ИмяПоля, ВидСравнения,
								ПравоеЗначение, Представление, Использование, РежимОтображения, ИдентификаторПользовательскойНастройки);
	КонецЕсли;
	
КонецПроцедуры

// Добавить элемент компоновки в контейнер элементов компоновки.
//
// Параметры:
//  ОбластьДобавления - контейнер с элементами и группами отбора, например.
//                  Список.Отбор или группа в отборе.
//  ИмяПоля                 - Строка - имя поля компоновки данных (заполняется всегда).
//  ПравоеЗначение          - произвольный - сравниваемое значение.
//  ВидСравнения            - ВидСравненияКомпоновкиДанных - вид сравнения.
//  Представление           - Строка - представление элемента компоновки данных.
//  Использование           - Булево - использование элемента.
//  РежимОтображения        - РежимОтображенияЭлементаНастройкиКомпоновкиДанных - режим отображения.
//  ИдентификаторПользовательскойНастройки - Строка - см. ОтборКомпоновкиДанных.ИдентификаторПользовательскойНастройки
//                                                    в синтакс-помощнике.
//
Функция ДобавитьЭлементКомпоновки(ОбластьДобавления,
									Знач ИмяПоля,
									Знач ВидСравнения,
									Знач ПравоеЗначение = Неопределено,
									Знач Представление  = Неопределено,
									Знач Использование  = Неопределено,
									знач РежимОтображения = Неопределено,
									знач ИдентификаторПользовательскойНастройки = Неопределено) Экспорт
	
	Элемент = ОбластьДобавления.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	Элемент.ЛевоеЗначение = Новый ПолеКомпоновкиДанных(ИмяПоля);
	Элемент.ВидСравнения = ВидСравнения;
	
	Если РежимОтображения = Неопределено Тогда
		Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	Иначе
		Элемент.РежимОтображения = РежимОтображения;
	КонецЕсли;
	
	Если ПравоеЗначение <> Неопределено Тогда
		Если ТипЗнч(ПравоеЗначение) = Тип("Массив") Тогда
			Если ПравоеЗначение.Количество() = 1 Тогда
				Элемент.ПравоеЗначение         = ПравоеЗначение[0];
			ИначеЕсли ПравоеЗначение.Количество() > 1 Тогда
				ЗначениеСписок = Новый СписокЗначений;
				ЗначениеСписок.ЗагрузитьЗначения(ПравоеЗначение);
				Элемент.ПравоеЗначение         = ЗначениеСписок;
			Иначе
				Элемент.ПравоеЗначение         = ПравоеЗначение;
			КонецЕсли;
		Иначе
			Элемент.ПравоеЗначение         = ПравоеЗначение;
		КонецЕсли;
	КонецЕсли;
	
	Если Представление <> Неопределено Тогда
		Элемент.Представление = Представление;
	КонецЕсли;
	
	Если Использование <> Неопределено Тогда
		Элемент.Использование = Использование;
	КонецЕсли;
	
	// Важно: установка идентификатора должна выполняться
	// в конце настройки элемента, иначе он будет скопирован
	// в пользовательские настройки частично заполненным.
	Если ИдентификаторПользовательскойНастройки <> Неопределено Тогда
		Элемент.ИдентификаторПользовательскойНастройки = ИдентификаторПользовательскойНастройки;
	ИначеЕсли Элемент.РежимОтображения <> РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный Тогда
		Элемент.ИдентификаторПользовательскойНастройки = ИмяПоля;
	КонецЕсли;
	
	Возврат Элемент;
	
КонецФункции

// Изменить элемент отбора с заданным именем поля или представлением.
//
// Параметры:
//  ИмяПоля                 - Строка - имя поля компоновки данных (заполняется всегда).
//  Представление           - Строка - представление элемента компоновки данных.
//  ПравоеЗначение          - произвольный - сравниваемое значение.
//  ВидСравнения            - ВидСравненияКомпоновкиДанных - вид сравнения.
//  Использование           - Булево - использование элемента.
//  РежимОтображения        - РежимОтображенияЭлементаНастройкиКомпоновкиДанных - режим отображения.
//
Функция ИзменитьЭлементыОтбора(ОбластьПоиска,
								Знач ИмяПоля = Неопределено,
								Знач Представление = Неопределено,
								Знач ПравоеЗначение = Неопределено,
								Знач ВидСравнения = Неопределено,
								Знач Использование = Неопределено,
								Знач РежимОтображения = Неопределено,
								Знач ИдентификаторПользовательскойНастройки = Неопределено) Экспорт
	
	Если ЗначениеЗаполнено(ИмяПоля) Тогда
		ЗначениеПоиска = Новый ПолеКомпоновкиДанных(ИмяПоля);
		СпособПоиска = 1;
	Иначе
		СпособПоиска = 2;
		ЗначениеПоиска = Представление;
	КонецЕсли;
	
	МассивЭлементов = Новый Массив;
	
	НайтиРекурсивно(ОбластьПоиска.Элементы, МассивЭлементов, СпособПоиска, ЗначениеПоиска);
	
	Для Каждого Элемент Из МассивЭлементов Цикл
		Если ИмяПоля <> Неопределено Тогда
			Элемент.ЛевоеЗначение = Новый ПолеКомпоновкиДанных(ИмяПоля);
		КонецЕсли;
		Если Представление <> Неопределено Тогда
			Элемент.Представление = Представление;
		КонецЕсли;
		Если Использование <> Неопределено Тогда
			Элемент.Использование = Использование;
		КонецЕсли;
		Если ВидСравнения <> Неопределено Тогда
			Элемент.ВидСравнения = ВидСравнения;
		КонецЕсли;
		Если ПравоеЗначение <> Неопределено Тогда
			Элемент.ПравоеЗначение = ПравоеЗначение;
		КонецЕсли;
		Если РежимОтображения <> Неопределено Тогда
			Элемент.РежимОтображения = РежимОтображения;
		КонецЕсли;
		Если ИдентификаторПользовательскойНастройки <> Неопределено Тогда
			Элемент.ИдентификаторПользовательскойНастройки = ИдентификаторПользовательскойНастройки;
		КонецЕсли;
	КонецЦикла;
	
	Возврат МассивЭлементов.Количество();
	
КонецФункции

Процедура НайтиРекурсивно(КоллекцияЭлементов, МассивЭлементов, СпособПоиска, ЗначениеПоиска)
	
	Для каждого ЭлементОтбора Из КоллекцияЭлементов Цикл
		
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
			
			Если СпособПоиска = 1 Тогда
				Если ЭлементОтбора.ЛевоеЗначение = ЗначениеПоиска Тогда
					МассивЭлементов.Добавить(ЭлементОтбора);
				КонецЕсли;
			ИначеЕсли СпособПоиска = 2 Тогда
				Если ЭлементОтбора.Представление = ЗначениеПоиска Тогда
					МассивЭлементов.Добавить(ЭлементОтбора);
				КонецЕсли;
			КонецЕсли;
		Иначе
			
			НайтиРекурсивно(ЭлементОтбора.Элементы, МассивЭлементов, СпособПоиска, ЗначениеПоиска);
			
			Если СпособПоиска = 2 И ЭлементОтбора.Представление = ЗначениеПоиска Тогда
				МассивЭлементов.Добавить(ЭлементОтбора);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры


#КонецОбласти

#Область _ // Дерево формы

&НаСервере
Функция ПолучитьСтрокуДереваЗначенийПоСтрокеДереваФормы(ДеревоЗначений, СтрокаДереваФормы, ДеревоФормы) Экспорт
	// Пример вызова:
	//	ДеревоЗначений = РеквизитФормыВЗначение("Объект").Дерево;
	//	ИДТекущейСтроки = Элементы.Дерево.ТекущаяСтрока;
	//	СтрокаДереваФормы = Объект.Дерево.НайтиПоИдентификатору(ИДТекущейСтроки);
	//	ПолучитьСтрокуДереваЗначенийПоСтрокеДереваФормы(ДеревоЗначений, СтрокаДереваФормы, Объект.Дерево);

	
	МассивИндексов = Новый Массив;
	
	ТекущаяСтрокаДереваФормы = СтрокаДереваФормы;
	Родитель = ТекущаяСтрокаДереваФормы.ПолучитьРодителя();
	Пока Не Родитель = Неопределено Цикл
		МассивИндексов.Вставить(0, Родитель.ПолучитьЭлементы().Индекс(ТекущаяСтрокаДереваФормы));
		
		ТекущаяСтрокаДереваФормы = Родитель;
		Родитель = ТекущаяСтрокаДереваФормы.ПолучитьРодителя();
	КонецЦикла;
	
	МассивИндексов.Вставить(0, ДеревоФормы.ПолучитьЭлементы().Индекс(ТекущаяСтрокаДереваФормы));
	
	ТекущаяСтрокаДереваЗначений = ДеревоЗначений;
	Для Каждого Индекс Из МассивИндексов Цикл
		ТекущаяСтрокаДереваЗначений = ТекущаяСтрокаДереваЗначений.Строки[Индекс];
	КонецЦикла;
	
	Возврат ТекущаяСтрокаДереваЗначений;
КонецФункции

&НаСервере
Функция ПолучитьСтрокуДереваФормыПоСтрокеДереваЗначений(ДеревоФормы, СтрокаДереваЗначений, ДеревоЗначений)
	// Пример вызова:
	//	ДеревоЗначений = РеквизитФормыВЗначение("Объект").Дерево;
	//	СтрокаДереваЗначений = ДеревоЗначений.Строки[0];
	//	ПолучитьСтрокуДереваФормыПоСтрокеДереваЗначений(Объект.Дерево, СтрокаДереваЗначений, ДеревоЗначений);
	
	МассивИндексов = Новый Массив;
	
	ТекущаяСтрокаДереваЗначений = СтрокаДереваЗначений;
	Родитель = ТекущаяСтрокаДереваЗначений.Родитель;
	Пока ЗначениеЗаполнено(Родитель) Цикл
		МассивИндексов.Вставить(0, Родитель.Строки.Индекс(ТекущаяСтрокаДереваЗначений));
		
		ТекущаяСтрокаДереваЗначений = Родитель;
		Родитель = ТекущаяСтрокаДереваЗначений.Родитель;
	КонецЦикла;
	
	МассивИндексов.Вставить(0, ДеревоЗначений.Строки.Индекс(ТекущаяСтрокаДереваЗначений));
	
	ТекущаяСтрокаДереваФормы = ДеревоФормы;
	Для Каждого Индекс Из МассивИндексов Цикл
		ТекущаяСтрокаДереваФормы = ТекущаяСтрокаДереваФормы.ПолучитьЭлементы()[Индекс];
	КонецЦикла;
	
	Возврат ТекущаяСтрокаДереваФормы;
	
КонецФункции


Функция ПолучитьСтрокуДереваФормыПоИдентификатору(ДеревоФормы, ИдСтроки)
	// Пример вызова:
	//	ПолучитьСтрокуДереваФормыПоИдентификатору(Объект.Дерево, Элементы.Дерево.ТекущаяСтрока);
	
	Возврат ДеревоФормы.НайтиПоИдентификатору(ИдСтроки);
	
КонецФункции


#КонецОбласти


