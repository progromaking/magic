﻿
Процедура ВыполнитьКодИзФайла(Путь)
	
	Файл = Новый Файл(Путь);
	Если Не Файл.Существует() Тогда
		Сообщить(НСтр("ru = 'Доступ к файлу не возможен!'"), СтатусСообщения.Внимание);
		Возврат;
	КонецЕсли; 

	ТекстовыйФайл = Новый ТекстовыйДокумент;
	ТекстовыйФайл.Прочитать(Файл.ПолноеИмя, КодировкаТекста.UTF8);
		
	Попытка		
		Выполнить(ТекстовыйФайл.ПолучитьТекст()); // !!! ВЫПОЛНЯЕМ КОД ИЗ ФАЙЛА !!!
	Исключение
		Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
	КонецПопытки;	
	
КонецПроцедуры


// Замер времени
Функция ЗамерВремениНачало() 
	__СкриптКонтрол = Новый COMОбъект("MSScriptControl.ScriptControl");
	__СкриптКонтрол.Language = "javascript";

	Возврат Новый Структура("Скрипт,ЗамерВремениНачало",__СкриптКонтрол.eval("new Date().getTime()"), __СкриптКонтрол);

КонецФункции

Функция ЗамерВремениКонец(Параметры)
	__СкриптКонтрол = Параметры.Скрипт;
	ЗамерВремениОкончание = __СкриптКонтрол.eval("new Date().getTime()");	

	Миллисекунды		= ЗамерВремениОкончание-Параметры.ЗамерВремениНачало;
	// Часы
	КолВоЧасов			= Цел(Миллисекунды/(60*60*1000));
	Остаток				= Миллисекунды-КолВоЧасов*60*60*1000;	
	// Минуты
	КолВоМинут			= Цел(Остаток/(60*1000));
	Остаток				= Остаток-КолВоМинут*60*1000;	
	// Секунды,миллисекунды
	КолВоСекунд			= Цел(Остаток/1000);
	КолВоМиллисекунд	= Остаток-КолВоСекунд*1000;
		
	Возврат НСтр("ru = 'Время выполнения: " + Формат(КолВоЧасов,"ЧЦ=3;ЧН=;ЧВН=")+":"+Формат(КолВоМинут,"ЧЦ=2;ЧН=;ЧВН=")+":"+Формат(КолВоСекунд,"ЧЦ=2;ЧН=;ЧВН=")+":"+Формат(КолВоМиллисекунд,"ЧЦ=3;ЧН=;ЧВН=") + " мс.'");
КонецФункции


Функция РассчитатьХэшСтроки(СтрокаТекста, Алгоритм = 0)
	// взято с форума: http://forum.infostart.ru/forum9/topic156660/message1603393/#message1603393
	
    //    Алгоритм : 0 - SHA1, 1 - SHA256, 2 - MD5

    Если Алгоритм = 2 Тогда
        CryptoProvider    = "System.Security.Cryptography.MD5CryptoServiceProvider";
    ИначеЕсли Алгоритм = 1 Тогда
        CryptoProvider    = "System.Security.Cryptography.SHA256Managed";
    Иначе     // SHA1
        CryptoProvider    = "System.Security.Cryptography.SHA1Managed";
    КонецЕсли;

    ТекстСкрипта    = "
        |Function Hash()
    |    Set Crypto    = CreateObject(""" + CryptoProvider + """)
    |    Set UTF8Enc    = CreateObject(""System.Text.UTF8Encoding"")
    |    aHash    = Crypto.ComputeHash_2(UTF8Enc.GetBytes_4("""+СтрокаТекста+"""))
    |    Set Crypto    = Nothing
    |    Set UTF8Enc    = Nothing
        |
    |    cHash    = """"
    |    for i = 1 to LenB(aHash) 
    |        k    = AscB(MidB( aHash, i, 1 ))
    |        lo    = k Mod 16
    |        hi    = (k - lo) / 16
    |        if hi > 9 then
    |            chHi    = Chr(Asc(""a"") + hi - 10)
    |        else
    |            chHi    = Chr(Asc(""0"") + hi)
    |        end if
    |        if lo > 9 then
    |            chLo    = Chr(Asc(""a"") + lo - 10)
    |        else
    |            chLo    = Chr(Asc(""0"") + lo)
    |        end if
    |        cHash    = cHash & chHi & chLo
    |    next
    |    Hash    = cHash
    |End Function
        |";
        
    ScrCtrl    = Новый COMОбъект("MSScriptControl.ScriptControl");
    ScrCtrl.Language = "vbscript";
    ScrCtrl.AddCode(ТекстСкрипта);

    Возврат ScrCtrl.Run("Hash");

КонецФункции //РассчитатьХэшСтроки

Функция ХэшДокумента(СсылкаНаДокум)
	// взято с форума: http://forum.infostart.ru/forum24/topic155964/message1597516/
	
	Докум   = СсылкаНаДокум.ПолучитьОбъект();
	мтДок   = Докум.Метаданные();
	зап      = Новый ЗаписьXML;
	зап.УстановитьСтроку();
	зап.ЗаписатьНачалоЭлемента("obj");
	зап.ЗаписатьАтрибут("Дата"   , XMLСтрока(Докум.Дата));
	зап.ЗаписатьАтрибут("Номер"   , XMLСтрока(Докум.Номер));
	зап.ЗаписатьАтрибут("Пров"   , XMLСтрока(Докум.Проведен));
	зап.ЗаписатьАтрибут("Удал"   , XMLСтрока(Докум.ПометкаУдаления));
	Для Каждого рекв Из мтДок.Реквизиты Цикл
		зап.ЗаписатьАтрибут(рекв.Имя, XMLСтрока(Докум[рекв.Имя]));
	КонецЦикла;
	Для Каждого тч Из мтДок.ТабличныеЧасти Цикл
		зап.ЗаписатьНачалоЭлемента(тч.Имя);
		Для Каждого стр Из Докум[тч.Имя] Цикл
			зап.ЗаписатьНачалоЭлемента("line");
			Для Каждого рекв из тч.Реквизиты Цикл
				зап.ЗаписатьАтрибут(рекв.Имя, XMLСтрока(стр[рекв.Имя]));
			КонецЦикла;
			зап.ЗаписатьКонецЭлемента();
		КонецЦикла;
		зап.ЗаписатьКонецЭлемента();
	КонецЦикла;
	зап.ЗаписатьКонецЭлемента();
	
	хеш   = Новый ХешированиеДанных(ХешФункция.SHA1);
	хеш.Добавить(зап.Закрыть());
	
	Возврат хеш.ХешСумма;
КонецФункции

Функция СравнитьТаблицыЗначений(Таблица1,Таблица2)
	// взято из статьи: http://infostart.ru/public/418002/
    
    ПострительОтчета = Новый ПостроительОтчета;
    
    // подготовка 1-ой таблицы
    ПострительОтчета.ИсточникДанных = Новый ОписаниеИсточникаДанных(Таблица1);
    ПострительОтчета.ЗаполнитьНастройки();
    ТабДок = Новый ТабличныйДокумент; 
    ПострительОтчета.Вывести(ТабДок);
    ИмяФайла1 = ПолучитьИмяВременногоФайла();
    ТабДок.Записать(ИмяФайла1);
    
    // подготовка 2-ой таблицы
    ПострительОтчета.ИсточникДанных = Новый ОписаниеИсточникаДанных(Таблица2);
    ПострительОтчета.ЗаполнитьНастройки();
    ТабДок = Новый ТабличныйДокумент; 
    ПострительОтчета.Вывести(ТабДок);
    ИмяФайла2 = ПолучитьИмяВременногоФайла();
    ТабДок.Записать(ИмяФайла2);
    
    // сравнение
    СравнениеФайлов = Новый СравнениеФайлов;
    СравнениеФайлов.ПервыйФайл = ИмяФайла1;
    СравнениеФайлов.ВторойФайл = ИмяФайла2;
    СравнениеФайлов.СпособСравнения = СпособСравненияФайлов.ТабличныйДокумент;
    СравнениеФайлов.ПоказатьРазличия();
    
КонецФункции